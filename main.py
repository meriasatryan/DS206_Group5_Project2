import logger
import os
import uuid  # Import the UUID module
from pipeline_relational_data.flow import RelationalDataFlow
from pipeline_dimensional_data.flow import DimensionalDataFlow



def main():
    LOGS_DIR = './logs'
    LOG_FILE_RELATIONAL_DATA_PIPELINE = os.path.join(LOGS_DIR, 'logs_relational_data_pipeline.txt')
    LOG_FILE_DIMENSIONAL_DATA_PIPELINE = os.path.join(LOGS_DIR, 'logs_dimensional_data_pipeline.txt')

    # Set up logger for relational data pipeline
    relational_logger = logger.setup_logger('relational_data_pipeline', LOG_FILE_RELATIONAL_DATA_PIPELINE)

    # Set up logger for dimensional data pipeline
    dimensional_logger = logger.setup_logger('dimensional_data_pipeline', LOG_FILE_DIMENSIONAL_DATA_PIPELINE)

    try:
        relational_logger.info("Starting Relational Data Flow execution.")
        relational_flow_instance = RelationalDataFlow()
        relational_filled = relational_flow_instance.exec()
        if relational_filled:
            relational_logger.info("Relational Data Flow: Database tables filled successfully.")
            print("Relational Data Flow: Database tables filled successfully.")
        else:
            relational_logger.info("Relational Data Flow: Database tables not filled.")
            print("Relational Data Flow: Database tables not filled.")

        dimensional_logger.info("Starting Dimensional Data Flow execution.")
        dimensional_flow_instance = DimensionalDataFlow()
        dimensional_filled = dimensional_flow_instance.exec()
        if dimensional_filled:
            dimensional_logger.info("Dimensional Data Flow: Database tables filled successfully.")
            print("Dimensional Data Flow: Database tables filled successfully.")
        else:
            dimensional_logger.info("Dimensional Data Flow: Database tables not filled.")
            print("Dimensional Data Flow: Database tables not filled.")
    except Exception as e:
        # Handle exceptions
        relational_logger.error(f"An error occurred during execution: {e}")
        dimensional_logger.error(f"An error occurred during execution: {e}")

if __name__ == "__main__":
    main()
