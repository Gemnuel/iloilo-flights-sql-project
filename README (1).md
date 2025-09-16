Iloilo Flights SQL Project

 Project Overview

This project explores and analyzes flight data from Iloilo Airport using
SQL.\
It includes queries for:\
- Finding which airline has the most passengers\
- Identifying delays and affected passengers\
- Ranking airlines by average ticket price\
- Detecting data quality issues and cleaning the dataset

------------------------------------------------------------------------

 Repository Contents

-   `MyProjectFile.xlsx` → Excel file containing raw flight data\
-   `MyDataCleaningProject.sql` → Queries for cleaning and validating
    the data\
-   `MysqlMyProject.sql` → Main SQL analysis queries (scenarios and
    insights)\
-   `README.md` → Instructions (this file)

------------------------------------------------------------------------

 How to Run the Project

Option A: Import Excel File into MySQL

1.  Open **MySQL Workbench**.\

2.  Create a database schema, e.g.:

    ``` sql
    CREATE DATABASE iloilo_airport;
    USE iloilo_airport;
    ```

3.  Right-click the schema → **Table Data Import Wizard**.\

4.  Select `MyProjectFile.xlsx` from this repository.\

5.  Workbench will create a table (e.g., `iloilo_flights`) with the
    imported data.

------------------------------------------------------------------------

### Option B: Import SQL File

If you prefer, you can run the `.sql` file directly:

1.  Open **MySQL Workbench**.\

2.  Create a schema:

    ``` sql
    CREATE DATABASE iloilo_airport;
    USE iloilo_airport;
    ```

3.  Open `MysqlMyProject.sql` or `MyDataCleaningProject.sql`.\

4.  Run the script --- it will create tables and insert data
    automatically.

------------------------------------------------------------------------

 Example Queries

1. Which airline has the most passengers?

``` sql
SELECT a.airline_name, COUNT(p.passenger_id) AS total_passenger
FROM iloilo_flights f
JOIN iloilo_passengers p ON f.flight_id = p.flight_id
JOIN iloilo_airlines a ON f.airline = a.airline_name
GROUP BY a.airline_name
ORDER BY total_passenger DESC;
```

2. Which airline has the most delayed passengers?

``` sql
WITH Delayed_flight AS (
  SELECT f.flight_id, f.airline, f.status, COUNT(p.passenger_id) AS affected_passenger
  FROM iloilo_flights f
  JOIN iloilo_passengers p ON f.flight_id = p.flight_id
  WHERE f.status = 'Delayed'
  GROUP BY f.flight_id, f.airline, f.status
)
SELECT airline, SUM(affected_passenger) AS total_affected
FROM Delayed_flight
GROUP BY airline
ORDER BY total_affected DESC;
```

------------------------------------------------------------------------
 Requirements

-   MySQL Workbench (or any SQL IDE)\
-   GitHub (to download the repo)

------------------------------------------------------------------------

 Key Skills Demonstrated

-   SQL Joins\
-   Common Table Expressions (CTEs)\
-   Window Functions (Ranking, Aggregation)\
-   Data Cleaning & Validation\
-   Importing Data from Excel to SQL
