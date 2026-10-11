# Business Requirements Document (BRD)

**Case:** FinTech Customer Retention & Revenue Intelligence

**Problem:** Explain activity decline and monetization by month, plan, and channel

**Stakeholders:** Growth Manager; Business Operations; Finance Analyst; Retention Lead

## Management questions
1. How many customers transact each month?
2. How is recognized revenue split by plan?
3. What is the MoM inactivity-churn rate?
4. Which prior active customers need retention outreach?
5. Do service tickets co-occur with poor engagement?

## In scope

Customer-month metrics, SQL cohort queries, revenue reconciliations, Excel workbook, PBIP report; excludes causal experimentation and real cancellation labels.

## Data acceptance criteria

- Document record grain and primary keys; do not count joined facts as unique customers.
- No missing foreign keys; zero duplicate primary/composite keys.
- Reconcile monetary totals with component measures and expose denominator definitions.
- Distinguish operational proxies and simulated labels from verified business facts.
- Provide auditable SQL, formula-based Excel summaries, DAX source, and a documented dashboard layout.

## Dashboard design

Page 1: management scorecard with four KPI cards, time trend and mix chart.

Page 2: investigative/retention detail with operational indicators and segmentation.

## Sign-off standard

Counts and ratios must reconcile between raw CSV and SQL. Visual screenshots require separate Power BI Desktop execution before claiming a rendered interactive report.
