from sqlalchemy import create_engine
import pandas as pd

# Source: master DB | Destination: sk DB
source_engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)
dest_engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/sg?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)

# Choose tables and columns you want
selected_tables = {
    "Customers": ["CustomerID", "CompanyName", "City", "Country"],
    "Orders": ["OrderID", "CustomerID", "OrderDate", "ShipCity"]
}

for table, columns in selected_tables.items():
    col_str = ", ".join(columns)
    df = pd.read_sql(f"SELECT {col_str} FROM [{table}]", source_engine)
    df.to_sql(name=table + "_selected", con=dest_engine, index=False, if_exists='replace')
    print(f"✅ Selected columns copied from: {table}")
