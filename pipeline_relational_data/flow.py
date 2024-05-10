import tasks
import configparser

class RelationalDataFlow:
    def __init__(self):
        self.execution_id = utils.generate_uuid() 

    def exec(self):
        db_conf = utils.get_sql_config(config.sql_server_config, "DatabaseConfig")
        server, database, username, password 
        db_host = db_config['host']
        db_name = db_config['database']
        db_user = db_config['user']
        db_password = db_config['password']
        conn_ER = tasks.create_db_connection(db_host, database, username, password)

        excel_path = 'raw_data_source.xlsx'
        output_dir = 'pipeline_relational_data/queries/'

        process_excel_data(excel_path, output_dir)

        

