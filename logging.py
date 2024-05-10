import logging
import os
from datetime import datetime

LOGS_DIR = 'logs'
LOG_FILE_RELATIONAL_DATA_PIPELINE = os.path.join(LOGS_DIR, 'logs_relational_data_pipeline.txt')

# Create logs directory if it doesn't exist
if not os.path.exists(LOGS_DIR):
    os.makedirs(LOGS_DIR)

def setup_logger():
    logger = logging.getLogger('relational_data_pipeline')
    logger.setLevel(logging.DEBUG)

    # Create formatter
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(execution_id)s - %(message)s')

    # Create file handler and set level to DEBUG
    file_handler = logging.FileHandler(LOG_FILE_RELATIONAL_DATA_PIPELINE)
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)

    # Add file handler to logger
    logger.addHandler(file_handler)

    return logger

def log_execution_id(logger, execution_id):
    logger.info("Execution ID: %s", execution_id)

# Example usage:
# logger = setup_logger()
# execution_id = 'our_uuid_here'
# log_execution_id(logger, execution_id)
# logger.info("Our log message here")
