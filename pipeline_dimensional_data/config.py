# Configuration for dimensional data pipeline

# Database name
database_name = 'ORDERS_DIMENSIONAL_DB'

# Relational table names
table_names = {
    'DimCategories': 'DimCategories',
    'DimCustomers': 'DimCustomers',
    'DimEmployees': 'DimEmployees',
    'DimProducts': 'DimProducts',
    'DimRegion': 'DimRegion',
    'DimShippers': 'DimShippers',
    'DimSuppliers': 'DimSuppliers',
    'DimTerritories': 'DimTerritories',
    'FactOrders': 'FactOrders'
}
CONFIG_PATH = '.\sql_server_config.cfg'

