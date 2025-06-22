from sqlalchemy import create_engine
import pandas as pd

engine = create_engine(
    'mssql+pyodbc://SKDZERA\\SQLEXPRESS/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes'
)

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
for table in tables:
    quoted_table = f"[dbo].[{table}]"
    df = pd.read_sql(f"SELECT * FROM {quoted_table}", engine)

    filename = table.replace(" ", "_") + ".csv"
    df.to_csv(filename, index=False)

    print(f"Exported: {filename}")