import os
import tasks
import utils
import config 

class DimensionalDataFlow:
    def __init__(self):
        self.execution_id = utils.generate_uuid()

    def exec(self):
        db_conf = utils.get_sql_config(config.sql_server_config, "DatabaseConfig")
        server = db_conf['host']
        database = db_conf['database']
        username = db_conf['user']
        password = db_conf['password']
        conn_DD = tasks.create_dimensional_db_connection(server, database, username, password)
        self.update_dimensional_tables(conn_DD)

    def update_dimensional_tables(connection):
        """Update dimensional tables based on SQL scripts."""
        script_folder = 'pipeline_dimensional_data/queries/'
        sql_files = [
            'update_dim_categories.sql',
            'update_dim_customers.sql',
            'update_dim_employees.sql',
            'update_dim_products.sql',
            'update_dim_region.sql',
            'update_dim_shippers.sql',
            'update_dim_suppliers.sql',
            'update_dim_territories.sql',
            'update_dim_orders.sql',
        ]
        for sql_file in sql_files:
            script_path = os.path.join(script_folder, sql_file)
            tasks.read_and_execute_sql_script(connection, script_path)


        