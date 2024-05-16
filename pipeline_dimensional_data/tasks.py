
import pyodbc
import configparser
import pipeline_dimensional_data.config as config

def read_sql_script(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def execute_sql_script(connection, sql_script):
    cursor = connection.cursor()
    cursor.execute(sql_script)
    connection.commit()

def get_db_connection():
    config_file_path = config.CONFIG_PATH
    config_parser = configparser.ConfigParser(config_file_path)
    print("Dimensional Data Flow: Sections in config file:", config_parser.sections())
    server, database, driver = None, None, None

    if 'DatabaseConfig2' in config_parser:
        if 'Server' in config_parser['DatabaseConfig2']:
            server = config_parser['DatabaseConfig2']['Server']
            print("Dimensional Data Flow: Server (DatabaseConfig2):", server)
        else:
            print("Dimensional Data Flow: Error: 'Server' key not found in the config section 'DatabaseConfig2'.")

        if 'Database' in config_parser['DatabaseConfig2']:
            database = config_parser['DatabaseConfig2']['Database']
            print("Dimensional Data Flow: Database (DatabaseConfig2):", database)
        else:
            print("Dimensional Data Flow: Error: 'Database' key not found in the config section 'DatabaseConfig2'.")

        if 'Driver' in config_parser['DatabaseConfig2']:
            driver = config_parser['DatabaseConfig2']['Driver']
            print("Dimensional Data Flow: Driver (DatabaseConfig2):", driver)
        else:
            print("Dimensional Data Flow: Error: 'Driver' key not found in the config section 'DatabaseConfig2'.")
    else:
        print("Dimensional Data Flow: Error: 'DatabaseConfig2' section not found in the config file.")

    if server and database and driver:
        try:
            connection_string = f'DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
            connection = pyodbc.connect(connection_string)
            print("INFO: create_db_connection: Database connection successful.")
            return connection
        except Exception as e:
            print(f"ERROR: create_db_connection: Failed to connect to database: {e}")
            return None

def create_dimensional_database():
    connection = get_db_connection()
    create_tables_script = read_sql_script('infrastructure_initiation/dimensional_db_table_creation.sql')
    execute_sql_script(connection, create_tables_script)
    connection.close()

def populate_dimension_tables(connection):
    # connection = get_db_connection()
    print(f"{connection} was sucsedsisa")
    dimension_tables = [
        'categories', 'customers', 'employees', 
        'products', 'region', 'shippers', 
        'suppliers', 'territories'
    ]
    for table_name in dimension_tables:
        print(table_name)
        ingest_script = read_sql_script(f'pipeline_dimensional_data/queries/update_dim_{table_name}.sql')
        execute_sql_script(connection, ingest_script)

def populate_fact_tables(conection):
    fact_tables = ['FactOrders']
    for table_name in fact_tables:
        print(table_name)
        ingest_script = read_sql_script(f'pipeline_dimensional_data/queries/update_fact_{table_name}.sql')
        execute_sql_script(conection, ingest_script)
