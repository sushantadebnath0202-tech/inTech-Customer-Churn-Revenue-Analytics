# Data dictionary

All records synthetic. Monetary fields use USD.

## customers
Grain: one customer

| Column | Interpretation |
| --- | --- |
| `customer_id` | Customer id (synthetic identifier; use for joins) |
| `signup_date` | Signup date |
| `plan` | Plan |
| `country` | Country |
| `acquisition_channel` | Acquisition channel |
| `age_band` | Age band |

## monthly_metrics
Grain: one eligible customer-month

| Column | Interpretation |
| --- | --- |
| `customer_id` | Customer id (synthetic identifier; use for joins) |
| `month_start` | Month start |
| `is_active` | Is active (0=no; 1=yes) |
| `transaction_count` | Transaction count |
| `transaction_volume_usd` | Transaction volume usd |
| `subscription_revenue_usd` | Subscription revenue usd |
| `interchange_revenue_usd` | Interchange revenue usd |
| `fx_fee_revenue_usd` | Fx fee revenue usd |
| `total_revenue_usd` | Total revenue usd |

## support_tickets
Grain: one ticket

| Column | Interpretation |
| --- | --- |
| `ticket_id` | Ticket id (synthetic identifier; use for joins) |
| `customer_id` | Customer id (synthetic identifier; use for joins) |
| `created_date` | Created date |
| `issue_type` | Issue type |
| `status` | Status |
| `resolution_hours` | Resolution hours |
| `satisfaction_score` | Satisfaction score |
