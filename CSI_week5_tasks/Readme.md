# Data Integration & Pipeline Automation Tasks

These tasks demonstrates end-to-end data integration and pipeline automation using **Python** and **SQL Server**, focused on real-world data engineering tasks.

Features

1. **Data Export Pipelines**  
   - Export SQL Server tables to:
     - CSV (`pandas`)
     - Parquet (`pyarrow`)
     - Avro (`fastavro`)

2. **Pipeline Automation**  
   - **Scheduled triggers** using `schedule`
   - **Event-based triggers** using `watchdog` (e.g., when new CSVs are added to a folder)

3. **Full Database Migration**  
   - Copy all tables from source (`master`) to destination (`sk`) database  
   - Uses `SQLAlchemy`, `pandas`, and raw SQL

4. **Selective Table/Column Migration**  
   - Migrate only selected tables or columns based on business logic  
   - Controlled using Python filters and query customization

## 🧰 Tech Stack

- **Language**: Python 3.x
- **Database**: Microsoft SQL Server
- **Libraries**: 
  - `pandas`, `pyarrow`, `fastavro`
  - `sqlalchemy`, `pyodbc`
  - `schedule`, `watchdog`
- **ADF**




