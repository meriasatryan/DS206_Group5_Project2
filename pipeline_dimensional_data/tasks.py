import pyodbc
import os

def create_dimensional_db_connection(server, database, username, password):
    """
    Establishes a database connection for dimensional data using given credentials.

    :param server: Server address
    :param database: Database name
    :param username: User name
    :param password: Password
    :return: Connection object or None
    """
    try:
        connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
        connection = pyodbc.connect(connection_string)
        print("Dimensional database connection successful.")
        return connection
    except Exception as e:
        print(f"Failed to connect to dimensional database: {e}")
        return None

def create_dimensional_table(connection, create_table_sql):
    """
    Creates a table in the dimensional database based on the provided SQL command.

    :param connection: Database connection object
    :param create_table_sql: SQL string to create the table
    """
    try:
        cursor = connection.cursor()
        cursor.execute(create_table_sql)
        connection.commit()
        print("Dimensional table created successfully.")
    except Exception as e:
        connection.rollback()
        print(f"Failed to create dimensional table: {e}")


def read_and_execute_sql_script(connection, script_path):
    """
    Reads an SQL script from a file and executes it using the given database connection.

    :param connection: A database connection object
    :param script_path: The path to the .sql file
    """
    with open(script_path, 'r') as file:
        sql_script = file.read()
    execute_sql_script(connection, sql_script)

def execute_sql_script(connection, sql_script):
    """
    Executes an SQL script using the given database connection.

    :param connection: A database connection object
    :param sql_script: A string containing SQL commands
    """
    try:
        cursor = connection.cursor()
        cursor.execute(sql_script)
        connection.commit()
        print("Script executed successfully")
    except Exception as e:
        connection.rollback()
        print(f"An error occurred: {e}")

def process_dimensional_sql_scripts(connection, script_folder):
    """
    Process each SQL script in the specified folder and execute it using the provided database connection.

    :param connection: A database connection object
    :param script_folder: Folder containing SQL scripts
    """
    for filename in os.listdir(script_folder):
        if filename.endswith(".sql"):
            script_path = os.path.join(script_folder, filename)
            read_and_execute_sql_script(connection, script_path)