from sqlalchemy import create_engine
import pandas as pd
import fastavro

# Connect to SQL Server
engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)

# Tables to export
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

# Export each table to Avro (in current folder)
for table in tables:
    df = pd.read_sql(f"SELECT * FROM [dbo].[{table}]", engine)

    # Convert all data to string safely
    safe_df = df.copy()
    for col in safe_df.columns:
        try:
            safe_df[col] = safe_df[col].astype(str)
        except Exception:
            safe_df[col] = safe_df[col].apply(lambda x: str(x) if pd.notnull(x) else "")

    # Create schema
    schema = {
        "type": "record",
        "name": table.replace(" ", "_"),
        "fields": [{"name": col, "type": ["null", "string"]} for col in safe_df.columns]
    }

    # Convert to records
    records = safe_df.fillna('').to_dict(orient="records")

    # Write to avro
    with open(f"{table.replace(' ', '_')}.avro", "wb") as f:
        fastavro.writer(f, schema, records)

    print(f"✅ Exported: {table}.avro")
