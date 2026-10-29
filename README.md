# Asterbridge Health & Insurance — Healthcare Operational Analytics

## Project Overview

An end-to-end data analytics portfolio project using PostgreSQL, SQL, Power BI and DAX to analyse operational performance at a fictional healthcare and insurance organisation.

The project covers healthcare activity, clinical outcomes, workforce capacity, incident risk and data quality.

**Tools:** PostgreSQL 18, pgAdmin 4, Power BI Desktop, SQL, DAX

**Reporting period:** October 2024 – September 2026

## Business Objectives

- Analyse healthcare encounter volumes and waiting times.
- Understand clinical activity and patient outcomes.
- Monitor workforce shifts and staffing hours.
- Investigate incidents by severity, category and location.
- Demonstrate SQL data cleaning and validation.

## Power BI Dashboard

**Explore the full dashboard:**
- [View all five dashboard screenshots](03_Screenshot/)
- [Download the Power BI dashboard](01_PowerBI/AsterBridge_Healthcare_Dashboard.pbix)
- [Explore the SQL scripts](02_SQL/)

The interactive dashboard contains five pages:

1. **Executive Overview** — Encounter trends, patients, waiting times and departmental activity.
2. **Clinical Overview** — Encounter types, outcomes and average waiting times by department.
3. **Workforce & Capacity** — Shift volumes, scheduled hours, recorded worked hours and missing values.
4. **Quality & Risk** — Incident severity, categories, locations and monthly trends.
5. **Data Quality & Methodology** — Data cleaning, validation and analytical limitations.

## Key Findings

| Metric | Result |
|---|---:|
| Unique healthcare encounters | 100,107 |
| Median waiting time | 22 minutes |
| Average waiting time | 30.39 minutes |
| Unique workforce shifts | 36,000 |
| Staff with recorded shifts | 372 |
| Scheduled workforce hours | 288,067.50 |
| Recorded worked hours | 273,348.88 |
| Total incidents | 3,000 |
| High or severe incidents | 443 |
| High or severe incident share | 14.8% |

## Data Cleaning and Validation

**Encounter data:** Examined 102,745 source records, identified 2,638 excess records and produced 100,107 unique encounters. Standardised department names, converted valid waiting times and prioritised higher record versions.

**Workforce data:** Removed 360 identical duplicate shift records from 36,360 source records, producing 36,000 unique shifts. Preserved 540 missing worked-hour values.

**Incident data:** Validated 3,000 unique incidents with no missing severity or category values.

**Consistency check:** Confirmed zero record-version mismatches and zero missing encounter types or outcomes between the executive and clinical reporting views.

## Project Structure

- `01_PowerBI/` — Interactive Power BI dashboard
- `02_SQL/` — PostgreSQL cleaning and reporting views
- `03_Screenshots/` — Screenshots of all five dashboard pages
- `04_Documentation/` — Methodology and validation notes
- `05_Data/` — Data dictionary or shareable sample data, if provided

## Methodology and Limitations

The analysis uses PostgreSQL reporting views, a Power BI date table and DAX measures.

Missing worked hours were not assumed to be zero. Incident counts were not adjusted for exposure or patient activity. Record-version agreement was validated, but matching versions do not necessarily establish identical source-row selection.

The SQL scripts depend on the original source tables and are not a standalone database backup.

## Disclaimer

Asterbridge Health & Insurance is a fictional organisation. This project was developed for learning and data analytics portfolio purposes.
