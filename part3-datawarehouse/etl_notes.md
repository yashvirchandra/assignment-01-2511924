
## ETL Decisions

### Decision 1 — Date Standardization
Problem: The date column in the raw dataset was stored as text format like: dd-mm-yyyy; which is not suitable for the time-based analysis in SQL.

Resolution: So I Used STR_TO_DATE() with the format '%d-%m-%Y' to convert the text into a proper DATE format. This allowed extraction of day, month, and year for analysis.

---

### Decision 2 — Category Standardization
Problem: The category column contained inconsistent values such as 'grocery' and 'groceries', along with other inconsistent casing, which would lead to incorrect grouping.

Resolution: Applied TRIM() and LOWER() to normalize text, and used a CASE statement to map similar values into a single standardized category (e.g:- ('grocery', 'groceries') TO : 'GROCERIES').

---

### Decision 3 — Data Type Correction
Problem: Some fields in the raw dataset were not properly structured for analysis, especially for numerical calculations.

Resolution: Ensured that units_sold and unit_price were used as numeric data types, allowing accurate calculation of total_sales in the fact table.
