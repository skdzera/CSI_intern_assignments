# Automated Daily ETL Pipeline with Azure Data Factory: Truncate & Reload Strategy

## Overview

This project outlines the implementation of an automated ETL (Extract, Transform, Load) pipeline using Azure Data Factory (ADF) to ingest, transform, and load data from three different types of CSV files stored in Azure Data Lake Storage Gen2 (ADLS Gen2) into Azure SQL Database tables. The ETL process is designed to perform a **truncate and reload** operation daily, ensuring up-to-date and clean data loads.

## Table of Contents

- Project Requirements
- Azure Resources & Linked Services
- File Types & Processing Rules
- Pipeline Architecture
- Dataset Configuration
- Data Flow Logic
- Scheduling & Automation
- Best Practices
- Acknowledgments

## Project Requirements

- **Automate** the daily ingestion and loading of three types of files from ADLS Gen2 into SQL tables.
- **Truncate** the destination table before loading new data.
- Each file type requires distinct transformations or handling.
- The solution must be scalable for new files added daily, each with a different date in the filename.

## Azure Resources & Linked Services

- **Azure Data Factory**: Orchestration and ETL management.
- **Azure Data Lake Storage Gen2**: Source storage for raw files.
- **Azure SQL Database**: Target data warehouse for loaded data.

**Linked Services:**
- Connect ADF to both ADLS Gen2 (for inputs) and Azure SQL Database (for outputs).

## File Types & Processing Rules

| File Pattern                   | Transformation Required                                   | Destination Table       |
|------------------------------- |----------------------------------------------------------|------------------------|
| `CUST_MSTR_YYYYMMDD.csv`       | Add `date` column parsed as `YYYY-MM-DD` from filename   | `CUST_MSTR`            |
| `master_child_export-YYYYMMDD.csv` | Add `date` column (`YYYY-MM-DD`) & `date_key` (`YYYYMMDD`) from filename | `master_child`         |
| `H_ECOM_ORDER.csv`             | No transformation, direct load                           | `H_ECOM_Orders`        |

> **Note:** There can be multiple files per type, each for a different date.

## Pipeline Architecture

The pipeline is organized into three parallel branches—one for each file type.

1. **Get Metadata**  
   Retrieve file lists for each pattern from respective folders in ADLS Gen2.

2. **ForEach Activity**  
   Loop through each detected file and trigger a corresponding Data Flow for processing and loading.

3. **Data Flow Activities**  
   - Perform dynamic column derivations as required based on filename patterns.
   - Truncate destination SQL table at the start of each load.

### 1. CUST_MSTR File Processing

- **Input:** All files matching `CUST_MSTR_*.csv`
- **Logic:**  
  - Derive a `date` column by extracting and formatting the date from the filename (e.g., `20191112` → `2019-11-12`).
  - Load the data into `CUST_MSTR` after truncating old data.

  **Derived Column Expression Example (ADF):**
  ```
  toDate(
    replace(
      split(split(byName('source_file_name'), '/')[3], '_')[3], 
      '.csv', ''
    ),
    'yyyyMMdd'
  )
  ```
- **Output:** Updated `CUST_MSTR` table with a fresh daily load and added `date` column.

### 2. master_child_export File Processing

- **Input:** Files following `master_child_export-*.csv`
- **Logic:**  
  - Add two columns:
    - `date`: Extracted and formatted as `YYYY-MM-DD`.
    - `date_key`: Raw date key from filename as `YYYYMMDD`.
  - Truncate `master_child` table, load transformed data.

  **Derived Columns:**
  - `date`
    ```
    toDate(
      replace(
        split(split(byName('source_file_name'), '/')[3],'-')[2],
        '.csv',''
      ),
      'yyyyMMdd'
    )
    ```
  - `date_key`
    ```
    replace(
      split(split(byName('source_file_name'), '/')[3],'-')[2],
      '.csv',''
    )
    ```
- **Output:** Daily-refreshed `master_child` table with new `date` and `date_key` columns.

### 3. H_ECOM_ORDER File Processing

- **Input:** Files named `H_ECOM_ORDER.csv` for each date.
- **Logic:**  
  - No transformation.
  - Table `H_ECOM_Orders` is truncated, and new data is loaded as is.
- **Output:** Latest e-commerce order data in `H_ECOM_Orders`.

## Dataset Configuration

- **Source Datasets:**  
  - One dataset per source file pattern/folder, parameterized to dynamically reference each file.

- **Sink Datasets:**  
  - One dataset per SQL target table.

## Data Flow Logic

- Utilize parameterized Data Flows to extract values from filenames.
- Use Derived Column transformations for dynamic date parsing and new column creation.
- Employ Sink activities set to 'Truncate' the destination table before each load.

## Scheduling & Automation

- **Trigger:**  
  - Set up a Scheduled Trigger in ADF to run the pipeline once daily.
  - Time pipeline execution for off-peak hours to optimize resource usage.

## Best Practices

- **Parameterization:** Make datasets and pipelines flexible with parameters for easy future extension.
- **Monitoring:** Use ADF monitoring tools for run history and error alerts.
- **Error Handling:** Implement fail-safe activities and notifications for load failures.

## Acknowledgments

Special thanks to CSI (Celebal Technologies) for enabling this hands-on data engineering journey and providing exposure to enterprise-grade modern data workflows.

This ETL pipeline offers a robust, repeatable, and fully automated approach to synchronizing your data lake with refined Azure SQL tables—ready for analytics, reporting, or further downstream processing.
