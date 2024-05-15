import logging
import logging_utils

relational_logger = logging_utils.setup_logger('relational_data_pipeline', logging_utils.LOG_FILE_RELATIONAL_DATA_PIPELINE)
dimensional_logger = logging_utils.setup_logger('dimensional_data_pipeline', logging_utils.LOG_FILE_DIMENSIONAL_DATA_PIPELINE)

# Example usage:
# execution_id = 'our_uuid_here'
# logging_utils.log_execution_id(relational_logger, execution_id)
# logging_utils.log_execution_id(dimensional_logger, execution_id)
