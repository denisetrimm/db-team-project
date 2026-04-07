# MovinOn Inc. – Database Team Project

CCCS 330 Database Design & Business Applications Development (McGill University)

This repository contains the **MovinOn_TeamNo** database implementation for MovinOn Inc., a moving and storage company, including schema, sample data, views, functions, stored procedures, triggers, and reports as per the project requirements.

## Technology

- **Database:** Microsoft SQL Server (T-SQL)
- **Database name:** `MovinOn_TeamNo`

## Team
- Anton Tang (261156269)
- Denise Trimm (260619643)
- Alonso Vasconcelos Gallegos	(261133267)


## Script execution order

Run scripts in this order:

1. `scripts/create_database.sql` – Create the database
2. `scripts/create_tables.sql` – Create all tables (per Figure 2.1)
3. `scripts/import_sample_data.sql` – Insert sample data (positions, warehouses, customers, vehicles, drivers, employees, job orders, job details, storage units, unit rentals)
4. `scripts/indexing_strategy.sql` – Create indexes on FK and frequently queried columns
5. `scripts/years_of_service_vested.sql` – View: employee years of service and vesting (5+ years)
6. `scripts/triggers_employee_phone_areacode.sql` – Trigger: validate employee phone/cell area codes for OR, WA, WY
7. `scripts/views_employee_earnings_age.sql` – View: employee annual earnings (salary or hourly × 2080), years of service, age
8. `scripts/reports_warehouse_manager_labels.sql` – Procedure: `WarehouseManagerReportLabels` (mailing labels by warehouse)
9. `scripts/reports_job_revenue.sql` – View + procedure: `JobRevenueReport` (income, driver payment, net income per job and totals)
10. `scripts/reports_storage_revenue.sql` – View + procedure: `StorageRevenueReport` (storage revenue by warehouse, years rented, totals)
11. `scripts/faq_objects.sql` – FAQ objects: functions, views, stored procedure for the five additional questions
12. `scripts/transaction_example.sql` – Transaction demonstrating atomic job creation with rollback

## Requirements coverage

- **Database design (Figure 2.1):** Tables, fields, data types, validation rules, relationships in `create_tables.sql`
- **Sample data:** All tables populated via `import_sample_data.sql` (Employee.xlsx-style data represented in SQL)
- **Years of service & vesting:** `vw_EmployeeVesting` – years of service; vested when years of service > 5; End Date hidden for active employees; Review hidden for inactive
- **Phone area code validation:** Trigger on `employees` – OR (541, 503, 971), WA (425, 360, 206, 509, 253), WY (307); error messages as specified
- **Employee earnings:** `vw_EmployeeEarnings` – annual salary (Salary or HourlyRate × 2080), years of service, age
- **WarehouseManagerReportLabels:** Stored procedure with optional `@WarehouseID`; returns manager name, warehouse number, mailing info
- **JobRevenueReport:** Income = MileageActual×0.70 + WeightActual×0.20; Driver Payment = 50 + MileageRate×MileageActual; Net = Income − Driver Payment; dollar formatting and totals
- **StorageRevenueReport:** By warehouse, renter last name, rent per unit, years rented (1 decimal), warehouse subtotals, grand total
- **FAQ objects (views, functions, stored procedure, trigger):**
  - How many storage units rented last year? → `fn_StorageUnitsRentedLastYear()`
  - What percentage of customers have rented at least one unit? → `fn_PercentCustomersWithRental()`
  - Greatest number of rents by an individual? → `sp_GreatestRentsByIndividual`
  - Average length of rental period? → `vw_AverageRentalPeriod`
  - Peak rental months? → `vw_PeakRentalMonths`
  - Phone validation → trigger on `employees` (above)

## Project structure

```
db-team-project/
├── README.md
├── LICENSE
├── Presentation/
│   ├── SLIDES.md                 – Slide-by-slide presentation content (18 slides)
│   ├── speaker_notes.md          – Detailed speaker notes with timing
│   ├── data_dictionary.md        – Full data dictionary (all 10 tables)
│   ├── erd_relationships.md      – ERD diagram and relationship descriptions
│   └── normalization.md          – 1NF / 2NF / 3NF analysis
├── project-requirements/
│   ├── MovingOn_Requirements.pdf
│   └── data-source/
│       └── readme.txt
└── scripts/
    ├── create_database.sql
    ├── create_tables.sql
    ├── import_sample_data.sql
    ├── indexing_strategy.sql
    ├── years_of_service_vested.sql
    ├── triggers_employee_phone_areacode.sql
    ├── views_employee_earnings_age.sql
    ├── reports_warehouse_manager_labels.sql
    ├── reports_job_revenue.sql
    ├── reports_storage_revenue.sql
    ├── faq_objects.sql
    ├── average_rental_period.sql
    ├── peak_rental_month.sql
    ├── transaction_example.sql
    └── test_debug.sql
```

## Quick test

After running all scripts:

```sql
USE MovinOn_TeamNo;
SELECT * FROM vw_EmployeeVesting;
SELECT * FROM vw_EmployeeEarnings;
EXEC WarehouseManagerReportLabels NULL;
EXEC JobRevenueReport;
EXEC StorageRevenueReport;
EXEC sp_GreatestRentsByIndividual;
SELECT dbo.fn_StorageUnitsRentedLastYear() AS UnitsRentedLastYear;
SELECT dbo.fn_PercentCustomersWithRental() AS PctCustomersWithRental;
SELECT * FROM vw_AverageRentalPeriod;
SELECT * FROM vw_PeakRentalMonths;
```
