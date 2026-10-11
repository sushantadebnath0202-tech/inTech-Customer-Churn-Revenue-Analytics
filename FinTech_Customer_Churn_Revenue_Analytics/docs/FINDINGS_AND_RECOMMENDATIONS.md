# Business findings — customer churn and revenue simulation

Analysis period: April–September 2026. Synthetic USD data.

| KPI | Validated result |
| --- | ---: |
| Customers | 450 |
| Customer-month records | 2,458 |
| Support tickets | 184 |
| Total recognized simulated revenue | $37,509.00 |
| September monthly active users | 287 |
| August active customer base | 379 |
| Newly inactive in September | 134 |
| September churn proxy | 35.36% |
| September retention among August actives | 64.64% |

## Findings and actions

1. From an August active base of 379 customers, 134 had no September transactions. This yields a **35.36% inactivity-churn proxy**, not actual subscription cancellation.
2. September recognized revenue was $5,447.92, versus $7,130.44 in August; evaluate whether activation, existing-customer engagement, or plan mix drove the decline.
3. Separate the monthly active-customer trend from customer acquisition: cohorts joining over time naturally affect counts and aggregate revenue.
4. Target outreach to previously active accounts with higher prior-month recognized revenue, then review product or support issues; the prioritization SQL query is an **operational hypothesis**, not a causal churn model.
5. Monitor MAU, prior-month active base, retention, plan revenue mix and service resolution trends together in an executive dashboard.

## Caveats

- "Churn" refers only to users active in August with zero activity in September.
- No account closure or subscription cancellation event is present.
- Synthetic data intentionally includes a September activity drop; it is not evidence of a real FinTech product problem.
- Revenue is a *simulated recognized revenue proxy* (plan fees + interchange + FX fees), not GMV or net profit.
