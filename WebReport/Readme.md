SAP Business One Web Report

A web-based reporting dashboard for SAP Business One. It shows live company data (sales, purchase, production, finance, inventory) as KPI cards and charts in a browser, and works as a lightweight alternative to Power BI.

1. In simple words (for non-technical readers)

The problem: Managers need to see business numbers quickly: how much we sold, what we owe suppliers, how production is going, how much stock we hold. Normally this needs Excel work or a paid BI tool such as Power BI.

My solution: A web application that connects to SAP Business One and shows these numbers automatically on one screen. A manager opens a link in a browser, picks a date range, and sees the results instantly.

What a user can do:

See key business numbers (KPIs) for Sales, Purchase, Production, Finance and Inventory
Filter by date range and by warehouse
Compare this year with the previous year
Download any report to Excel
Refresh to get the latest data
Control who can see which menu (admin feature)
2. Technical overview
Item	Details
ERP	SAP Business One 10
Database	SAP HANA
Front end	___
Back end	___
Charts	___
Currency	INR

Common features on every screen

Sidebar: Executive, Sales, Purchase, Production, Finance, Inventory, Admin
Period filter (preset or custom From/To dates)
Refresh button and "Data as of" timestamp
Export to Excel
Tabs inside each menu
3. Menus and what they report
Sales

Tabs: Sales Overview, Customer Analysis, Item and Product Analysis, Order to Cash

KPIs: Net Sales, Gross Margin, Invoices, Average Invoice Value, Orders Booked, Open Sales Orders, Overdue Receivables, Active Customers
Charts: Monthly net sales vs previous year, Top 10 customers
Purchase

Tabs: Purchase Overview, Supplier Analysis, Procurement Pipeline, Price and Variance

KPIs: Net Purchases, POs Placed, Open PO Value, Received Not Billed, Payables Outstanding, Overdue Payables, Supplier Bills, Active Suppliers
Charts: Monthly net purchases vs previous year, Top 10 suppliers
Production

Tabs: Production Overview, Production Orders, Material Consumption, Receipts and Issues

KPIs: Production Orders, Planned vs Completed Quantity, Efficiency, Open Orders, Delayed Orders, Yield, Material Variance Cost
Charts: Planned vs completed quantity by month, Order status
Finance

Tabs: Finance Overview, Receivables and Payables, Cash and Bank, Ledger and P&L

KPIs: Income, Expenses, Net Profit, Net Profit Margin, Cash and Bank Balance, Receivables, Payables, DSO, DPO
Charts: Income vs expense by month, Receivables ageing
Inventory

Tabs: Inventory Overview, Stock Status, Movement and Transactions, Ageing and Reorder

KPIs: Total Stock Value, Items in Stock, Inward and Outward Value, Stock Turnover, Days of Inventory, Below Minimum Stock, Non-Moving Stock Value
Charts: Stock value by warehouse, Stock ageing
Extra filter: Warehouse
Admin

Tabs: Users and Access, Audit log, Connection

Add users and reset passwords
Role-based access: choose which menus each user can open
4. Screenshots

Screenshots use test data.

Sales

Sales

Purchase

Purchase

Production

Production

Finance

Finance

Inventory

Inventory

Admin

Admin

5. Why this instead of Power BI
No per-user BI licence cost
Built directly on SAP B1 / HANA data
Only a web browser is needed
Menus, KPIs and access rules are designed around business needs
