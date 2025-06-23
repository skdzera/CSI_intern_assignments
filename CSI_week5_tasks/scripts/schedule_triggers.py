import schedule
import time
import pandas as pd
from sqlalchemy import create_engine

def get_engine():
    return create_engine(
        "mssql+pyodbc://localhost/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
    )

def pipeline_job():
    print("Running scheduled pipeline job...")
    engine = get_engine()

    # Example: Read table into DataFrame
    df = pd.read_sql("SELECT * FROM Products", engine)
    print(f"Fetched {len(df)} rows from Products")

    # You can also write to DB like:
    # df.to_sql("Backup_Products", engine, if_exists="replace", index=False)

# Schedule job
schedule.every().day.at("02:00").do(pipeline_job)

while True:
    schedule.run_pending()
    time.sleep(60)
