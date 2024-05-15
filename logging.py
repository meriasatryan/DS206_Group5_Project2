import logging
import os
from datetime import datetime

LOGS_DIR = 'logs'
LOG_FILE_RELATIONAL_DATA_PIPELINE = os.path.join(LOGS_DIR, 'logs_relational_data_pipeline.txt')
LOG_FILE_DIMENSIONAL_DATA_PIPELINE = os.path.join(LOGS_DIR, 'logs_dimensional_data_pipeline.txt')

# Create logs directory if it doesn't exist
if not os.path.exists(LOGS_DIR):
    os.makedirs(LOGS_DIR)

def setup_logger(logger_name, log_file):
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.DEBUG)

    # Create formatter
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(execution_id)s - %(message)s')

    file_handler = logging.FileHandler(log_file)
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)

    # Add file handler to logger
    logger.addHandler(file_handler)

    return logger

def log_execution_id(logger, execution_id):
    logger.info("Execution ID: %s", execution_id)