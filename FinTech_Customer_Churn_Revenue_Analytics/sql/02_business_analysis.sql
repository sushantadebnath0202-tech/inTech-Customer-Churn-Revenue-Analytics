USE fintech_churn_analytics;
-- 01 Monthly performance: MAU, total revenue, ARPAU and transaction volume.
SELECT DATE_FORMAT(month_start,'%Y-%m') AS month,
 SUM(is_active) AS mau,ROUND(SUM(total_revenue_usd),2) AS revenue_usd,
 ROUND(SUM(total_revenue_usd)/NULLIF(SUM(is_active),0),2) AS revenue_per_mau_usd,
 SUM(transaction_count) AS transactions,ROUND(SUM(transaction_volume_usd),2) AS volume_usd
FROM monthly_metrics GROUP BY month_start ORDER BY month_start;

-- 02 Strict month-to-month inactivity proxy (not contract cancellations).
WITH status_change AS (
 SELECT customer_id,month_start,is_active,
 LAG(is_active) OVER(PARTITION BY customer_id ORDER BY month_start) AS prev_active
 FROM monthly_metrics
)
SELECT DATE_FORMAT(month_start,'%Y-%m') AS month,
 SUM(prev_active=1) AS previous_active_base,
 SUM(prev_active=1 AND is_active=0) AS newly_inactive,
 ROUND(100*SUM(prev_active=1 AND is_active=0)/NULLIF(SUM(prev_active=1),0),2) AS churn_proxy_pct,
 ROUND(100*SUM(prev_active=1 AND is_active=1)/NULLIF(SUM(prev_active=1),0),2) AS retention_pct
FROM status_change WHERE prev_active IS NOT NULL GROUP BY month_start ORDER BY month_start;

-- 03 Revenue contributions by membership plan.
SELECT c.plan,SUM(m.is_active) AS active_customer_months,
 SUM(m.total_revenue_usd) AS revenue_usd,
 ROUND(100*SUM(m.total_revenue_usd)/(SELECT SUM(total_revenue_usd) FROM monthly_metrics),2) AS revenue_share_pct
FROM monthly_metrics m JOIN customers c USING(customer_id)
GROUP BY c.plan ORDER BY revenue_usd DESC;

-- 04 September churn proxy by plan and acquisition channel.
WITH aug AS (SELECT customer_id,is_active AS aug_active FROM monthly_metrics WHERE month_start='2026-08-01'),
 sep AS (SELECT customer_id,is_active AS sep_active FROM monthly_metrics WHERE month_start='2026-09-01')
SELECT c.plan,c.acquisition_channel,COUNT(*) AS august_active_base,
 SUM(sep.sep_active=0) AS became_inactive,
 ROUND(100*AVG(sep.sep_active=0),2) AS churn_proxy_pct
FROM aug JOIN sep USING(customer_id) JOIN customers c USING(customer_id)
WHERE aug.aug_active=1
GROUP BY c.plan,c.acquisition_channel HAVING COUNT(*)>=5
ORDER BY churn_proxy_pct DESC,august_active_base DESC;

-- 05 Month-on-month revenue growth with LAG (no future leakage).
WITH totals AS (SELECT month_start,SUM(total_revenue_usd) AS revenue FROM monthly_metrics GROUP BY month_start)
SELECT month_start,revenue,LAG(revenue) OVER(ORDER BY month_start) AS prev_revenue,
 ROUND(100*(revenue-LAG(revenue) OVER(ORDER BY month_start))/NULLIF(LAG(revenue) OVER(ORDER BY month_start),0),2) AS mom_revenue_growth_pct
FROM totals ORDER BY month_start;

-- 06 High-value customer retention: current-month value proxy only.
WITH ranked AS (
 SELECT m.customer_id,c.plan,SUM(m.total_revenue_usd) AS revenue,
 DENSE_RANK() OVER(ORDER BY SUM(m.total_revenue_usd) DESC) AS revenue_rank
 FROM monthly_metrics m JOIN customers c USING(customer_id)
 GROUP BY m.customer_id,c.plan)
SELECT * FROM ranked WHERE revenue_rank<=20 ORDER BY revenue_rank;

-- 07 Service quality / cross-sectional, NOT proof of causality.
SELECT c.plan,COUNT(*) AS tickets,
 ROUND(AVG(t.resolution_hours),1) AS avg_resolution_hours,
 ROUND(AVG(t.satisfaction_score),2) AS avg_satisfaction
FROM support_tickets t JOIN customers c USING(customer_id) GROUP BY c.plan ORDER BY tickets DESC;

-- 08 Customer-level September prioritization for retention outreach.
WITH customer_status AS (
 SELECT c.customer_id,c.plan,c.country,aug.is_active AS active_aug,sep.is_active AS active_sep,
 aug.total_revenue_usd AS revenue_aug,
 COUNT(t.ticket_id) AS total_tickets
 FROM customers c JOIN monthly_metrics aug ON c.customer_id=aug.customer_id AND aug.month_start='2026-08-01'
 JOIN monthly_metrics sep ON c.customer_id=sep.customer_id AND sep.month_start='2026-09-01'
 LEFT JOIN support_tickets t ON c.customer_id=t.customer_id
 GROUP BY c.customer_id,c.plan,c.country,aug.is_active,sep.is_active,aug.total_revenue_usd
)
SELECT *,CASE WHEN active_aug=1 AND active_sep=0 AND revenue_aug>=25 THEN 'Priority 1'
 WHEN active_aug=1 AND active_sep=0 THEN 'Priority 2' ELSE 'Monitor' END AS outreach_priority
FROM customer_status WHERE active_aug=1 AND active_sep=0
ORDER BY revenue_aug DESC,total_tickets DESC LIMIT 30;
