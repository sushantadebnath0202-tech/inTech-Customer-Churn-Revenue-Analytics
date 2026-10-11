# Power BI developer project: Customer_Churn_Revenue_Intelligence

- Open `Customer_Churn_Revenue_Intelligence.pbip` in a current Windows version of Power BI Desktop.
- This is **source code in PBIP/PBIR/TMDL format**, not a binary `.pbix` export.
- The Power Query partitions embed the same synthetic CSV snapshots included under `/data`; no machine-specific file path, MySQL password, or online service is required in the model definition.
- The semantic model contains explicit one-to-many relationships and DAX measures, with two report pages.
- This environment cannot run Windows Power BI Desktop, so **opening/rendering in Desktop has not been verified**. JSON syntax and source-file presence have been checked; visual/report compatibility may require Desktop correction and resaving before public presentation as a validated interactive dashboard.
- A data-grounded static dashboard illustration is available at `/assets/dashboard_preview.png`; it is **not** a screenshot exported from Power BI.
- SQL and Excel outputs have separate reproducible implementations. Their data and KPIs can be examined without Power BI Desktop.

## Updating from MySQL
The PBIP includes an embedded snapshot for portability. For a live local MySQL connection, in Power Query replace each table's `Source` step with `MySQL.Database("localhost", "fintech_churn_analytics")`, navigate to the corresponding table and preserve column names/types. Database credentials are never included in this repository.
