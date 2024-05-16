import os
import pipeline_dimensional_data.tasks as tasks
import configparser
import utils
import pyodbc
import pipeline_dimensional_data.config as config

class DimensionalDataFlow:
    def __init__(self):
        self.execution_id = utils.generate_uuid()

    def exec(self):
        print("Dimensional Data Flow: Inside exec() method.")
        config_parser = configparser.ConfigParser()
        config_file_path = config.CONFIG_PATH
        
        if not config_parser.read(config_file_path):
            print(f"Error: Config file '{config_file_path}' not found or is empty.")
            return False
        
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
                connection_string = f"DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;"
                connection = pyodbc.connect(connection_string)
                print(connection)
                print("Dimensional Data Flow: Successfully connected to the database.")

                # Example of processing tasks (replace with actual task calls)
                tasks.populate_dimension_tables(connection)
                tasks.populate_fact_tables(connection)

                connection.close()
                print("Dimensional Data Flow: Successfully processed and inserted data.")
            except Exception as e:
                print(f"Dimensional Data Flow: Error processing data: {e}")
                return False
        else:
            print("Dimensional Data Flow: Missing required configuration for database connection.")

        print("Dimensional Data Flow: Exiting exec() method.")
        return True


