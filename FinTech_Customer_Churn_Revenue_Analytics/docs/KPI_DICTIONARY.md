# KPI dictionary — churn & revenue

| KPI | Definition | Notes |
| --- | --- | --- |
| Monthly active users (MAU) | Distinct customer IDs with at least one transaction in that calendar month | Monthly context necessary |
| Recognized revenue | Subscription fee + interchange + FX fee for that month | Synthetic revenue proxy, not customer payment volume |
| Payment volume | Sum value of simulated customer transactions | GMV proxy, not revenue |
| ARPAU | Monthly recognized revenue / MAU | Per active user within selected period |
| Previous month active base | Customers active in the immediately preceding month | The September denominator is August MAU |
| Newly inactive | Prior-month actives who have no transactions in the selected month | Not proof of permanent churn |
| Churn proxy % | Newly inactive / prior-month active base | Monthly inactivity proxy |
| Retention % | Previously active users remaining active / previous active base | Equals 1 - churn proxy |
| MoM revenue growth % | (This month's revenue - prior month's revenue) / prior month's revenue | Blank/zero denominator guard |
| Member plan rank | Rank plans by recognized revenue | DENSE_RANK/RANKX |

**Important:** The dataset contains active and inactive eligible customer-months; customers before sign-up have no row. An account can become active again after a dormant month. Cohort-acquisition comparisons should account for this.
