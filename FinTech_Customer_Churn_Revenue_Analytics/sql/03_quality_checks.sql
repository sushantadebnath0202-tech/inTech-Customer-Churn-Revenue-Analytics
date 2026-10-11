USE fintech_churn_analytics;
SELECT 'customers' AS table_name,COUNT(*) AS records FROM customers
UNION ALL SELECT 'monthly_metrics',COUNT(*) FROM monthly_metrics
UNION ALL SELECT 'support_tickets',COUNT(*) FROM support_tickets;
SELECT COUNT(*) AS broken_customer_keys FROM monthly_metrics m LEFT JOIN customers c ON m.customer_id=c.customer_id WHERE c.customer_id IS NULL;
SELECT COUNT(*) AS duplicate_customer_months FROM (SELECT customer_id,month_start FROM monthly_metrics GROUP BY 1,2 HAVING COUNT(*)>1)x;
SELECT COUNT(*) AS revenue_reconciliation_errors FROM monthly_metrics
 WHERE ABS(total_revenue_usd-(subscription_revenue_usd+interchange_revenue_usd+fx_fee_revenue_usd))>.011;
SELECT COUNT(*) AS inactive_but_positive_transactions FROM monthly_metrics WHERE is_active=0 AND transaction_count>0;
SELECT COUNT(*) AS active_without_transactions FROM monthly_metrics WHERE is_active=1 AND transaction_count=0;
