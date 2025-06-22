from sqlalchemy import create_engine
import pandas as pd
import pyarrow
# Connect to SQL Server
engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)

# List of tables to export
tables = [
    'Categories',
    'CustomerCustomerDemo',
    'CustomerDemographics',
    'Customers',
    'Employees',
    'EmployeeTerritories',
    'Order Details',
    'Orders',
    'Products',
    'Region',
    'Shippers',
    'Suppliers',
    'Territories'
]

# Export each table to Parquet in current directory
for table in tables:
    safe_name = table.replace(" ", "_")
    quoted = f"[dbo].[{table}]"

    df = pd.read_sql(f"SELECT * FROM {quoted}", engine)
    df.to_parquet(f"{safe_name}.parquet", index=False)

    print(f"Exported: {safe_name}.parquet")
