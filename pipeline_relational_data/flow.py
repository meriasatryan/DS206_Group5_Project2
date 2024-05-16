import configparser
import pyodbc
import utils
from pipeline_relational_data.tasks import process_excel_data
import pipeline_relational_data.config as config


class RelationalDataFlow:
    def __init__(self):
        self.execution_id = utils.generate_uuid()

    def exec(self):
        print("Relational Data Flow: Inside exec() method.")
        config_parser = configparser.ConfigParser()
        config_file_path = config.CONFIG_PATH
        print(config_file_path)

        
        if not config_parser.read(config_file_path):
            print(f"Error: Config file '{config_file_path}' not found or is empty.")
            return False
        
        print("Relational Data Flow: Sections in config file:", config_parser.sections())

        server, database, driver = None, None, None

        if 'DatabaseConfig' in config_parser:
            if 'Server' in config_parser['DatabaseConfig']:
                server = config_parser['DatabaseConfig']['Server']
                print("Relational Data Flow: Server (DatabaseConfig):", server)
            else:
                print("Relational Data Flow: Error: 'Server' key not found in the config section 'DatabaseConfig'.")

            if 'Database' in config_parser['DatabaseConfig']:
                database = config_parser['DatabaseConfig']['Database']
                print("Relational Data Flow: Database (DatabaseConfig):", database)
            else:
                print("Relational Data Flow: Error: 'Database' key not found in the config section 'DatabaseConfig'.")

            if 'Driver' in config_parser['DatabaseConfig']:
                driver = config_parser['DatabaseConfig']['Driver']
                print("Relational Data Flow: Driver (DatabaseConfig):", driver)
            else:
                print("Relational Data Flow: Error: 'Driver' key not found in the config section 'DatabaseConfig'.")
        else:
            print("Relational Data Flow: Error: 'DatabaseConfig' section not found in the config file.")

        if server and database and driver:
            try:
                connection_string = f"DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;"
                connection = pyodbc.connect(connection_string)
                print(connection)
                print("Relational Data Flow: Successfully connected to the database.")

                # Process Excel data and insert into tables
                excel_path = config.EXCEL_PATH
                print(excel_path)
                process_excel_data(excel_path, connection)

                connection.close()
                print("Relational Data Flow: Successfully processed and inserted data.")
            except Exception as e:
                print(f"Relational Data Flow: Error processing data: {e}")
                return False
        else:
            print("Relational Data Flow: Missing required configuration for database connection.")

        print("Relational Data Flow: Exiting exec() method.")
        return True
