from sqlalchemy import create_engine
import pandas as pd

# Source: master DB | Destination: sk DB
source_engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)
dest_engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/sk?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)

tables_to_copy = [
    "Categories", "CustomerCustomerDemo", "CustomerDemographics",
    "Customers", "Employees", "EmployeeTerritories",
    "Order Details", "Orders", "Products", "Region",
    "Shippers", "Suppliers", "Territories"
]

for table in tables_to_copy:
    df = pd.read_sql(f"SELECT * FROM [{table}]", source_engine)
    df.to_sql(name=table, con=dest_engine, index=False, if_exists='replace')
    print(f"Full table copied: {table}")
