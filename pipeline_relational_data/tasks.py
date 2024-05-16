import pyodbc
import pandas as pd
import os
def create_db_connection(server, database):
    try:
        connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
        connection = pyodbc.connect(connection_string)
        print("INFO: create_db_connection: Database connection successful.")
        return connection
    except Exception as e:
        print(f"ERROR: create_db_connection: Failed to connect to database: {e}")
        return None

def load_data_from_excel(excel_path):
    """Load all sheets from an Excel file into a dictionary of DataFrames."""
    try:
        data = pd.read_excel(excel_path, sheet_name=None)
        print("INFO: load_data_from_excel: Excel file loaded successfully.")
        return data
    except Exception as e:
        print(f"ERROR: load_data_from_excel: Failed to load Excel file: {e}")
        return None

def create_sql_insert_script(df, table_name, db_name='dbo'):
    """Generate an SQL insert script for a given DataFrame and table name."""
    try:
        columns = ', '.join([f'[{col}]' for col in df.columns])  # Add brackets around column names
        placeholders = ', '.join(['?' for _ in df.columns])
        sql_script = f"INSERT INTO {db_name}.{table_name} ({columns}) VALUES ({placeholders});"
        print(f"INFO: create_sql_insert_script: SQL insert script created for table {table_name}.")
        print(sql_script)
        return sql_script
    except Exception as e:
        print(f"ERROR: create_sql_insert_script: Failed to create SQL insert script: {e}")
        return None

def execute_sql_script(connection, sql_script, data):
    """
    Executes an SQL script using the given database connection.

    :param connection: A database connection object
    :param sql_script: A string containing SQL commands
    :param data: Data to be inserted
    """
    try:
        cursor = connection.cursor()
        cursor.executemany(sql_script, data)
        connection.commit()
        print("INFO: execute_sql_script: Script executed successfully")
    except Exception as e:
        connection.rollback()
        print(f"ERROR: execute_sql_script: An error occurred: {e}")

def process_excel_data(excel_path, connection):
    """Process each sheet in the Excel file, convert to SQL, and insert data into the database."""
    data = load_data_from_excel(excel_path)
    if data is None:
        print("ERROR: process_excel_data: No data to process.")
        return

    for sheet_name, df in data.items():
        try:
            df = df.where(pd.notnull(df), None)
            print(sheet_name)
            sql_script = create_sql_insert_script(df, sheet_name)
            if sql_script:
                execute_sql_script(connection, sql_script, df.values.tolist())
        except Exception as e:
            print(f"ERROR: process_excel_data: An error occurred while processing sheet {sheet_name}: {e}")

