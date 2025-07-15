# NYC Taxi Data Analysis using PySpark & Databricks

# Task Overview
This task involves end-to-end data engineering and analysis using Databricks, PySpark, and Azure Data Lake/Blob Storage. NYC taxi trip data is ingested, transformed, and analyzed to extract key business insights using distributed data processing.

📊 Tasks Performed
Data Loading:

Loaded NYC Yellow Taxi Trip Data from public datasets into DBFS (Databricks File System).

Flattened nested JSON fields (if any) and stored data as an external Parquet table.

PySpark Analysis Queries:

✅ Query 1: Added a new column Revenue as the sum of:

Fare_amount, Extra, MTA_tax, Improvement_surcharge, Tip_amount, Tolls_amount, Total_amount.

✅ Query 2: Count of total passengers in New York City by area.

✅ Query 3: Real-time average fare and total earning by two vendors.

✅ Query 4: Moving count of payments made by each payment mode.

✅ Query 5: Top two revenue-generating vendors on a particular date, showing number of passengers and total cab distance.

✅ Query 6: Most number of passengers on a specific route (between pickup and drop-off locations).

✅ Query 7: Top pickup locations with most passengers in the last 5/10 seconds.

🛠️ Technologies Used
Databricks

PySpark

Azure Data Lake / Blob Storage

DBFS (Databricks File System)

Parquet File Format

SQL (via Spark SQL)


#  Learnings & Highlights
✅ Hands-on with distributed data processing using PySpark.
✅ Data flattening and external table creation using Parquet format.
✅ Real-time querying and aggregation using Spark SQL.
✅ Dynamic analysis of payment methods, vendor performance, and passenger routes.
