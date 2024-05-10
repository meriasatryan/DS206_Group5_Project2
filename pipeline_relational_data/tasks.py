import pyodbc
import pandas as pd
import os

def create_db_connection(server, database, username, password):
    """
    Establishes a database connection using given credentials.

    :param server: Server address
    :param database: Database name
    :param username: User name
    :param password: Password
    :return: Connection object or None
    """
    try:
        connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
        connection = pyodbc.connect(connection_string)
        print("Database connection successful.")
        return connection
    except Exception as e:
        print(f"Failed to connect to database: {e}")
        return None

def create_table(connection, create_table_sql):
    """
    Creates a table in the database based on the provided SQL command.

    :param connection: Database connection object
    :param create_table_sql: SQL string to create the table
    """
    try:
        cursor = connection.cursor()
        cursor.execute(create_table_sql)
        connection.commit()
        print("Table created successfully.")
    except Exception as e:
        connection.rollback()
        print(f"Failed to create table: {e}")

# def load_data_from_excel(excel_path):
#     """Load all sheets from an Excel file into a dictionary of DataFrames."""
#     return pd.read_excel(excel_path, sheet_name=None)

# def create_sql_insert_script(df, table_name, db_name='dbo'):
#     """Generate an SQL insert script for a given DataFrame and table name."""
#     columns = ', '.join([f'[{col}]' for col in df.columns])  # Add brackets around column names
#     placeholders = ', '.join(['?' for _ in df.columns])
#     sql_script = f"INSERT INTO {db_name}.{table_name} ({columns}) VALUES ({placeholders});"
#     return sql_script

# def save_sql_script(script, directory, filename):
#     """Save the SQL script to a file in the specified directory."""
#     if not os.path.exists(directory):
#         os.makedirs(directory)
#     with open(os.path.join(directory, filename), 'w') as file:
#         file.write(script)

# def process_excel_data(excel_path, output_dir):
#     """Process each sheet in the Excel file, convert to SQL, and save the script."""
#     data = load_data_from_excel(excel_path)
#     for sheet_name, df in data.items():
#         df = df.where(pd.notnull(df), None)
#         script = create_sql_insert_script(df, sheet_name)
#         save_sql_script(script, output_dir, f'insert_into_{sheet_name}.sql')

# excel_path = 'raw_data_source.xlsx'
# output_dir = 'pipeline_relational_data/queries/'

# process_excel_data(excel_path, output_dir)
