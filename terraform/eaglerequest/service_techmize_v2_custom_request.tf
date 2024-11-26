locals {
  service_techmize_v2_custom_request_environment_variables = {
    TECHMIZE_API_V2_DATA_SOURCE_CUSTOM_REQUEST_ENDPOINT = data.aws_ssm_parameter.techmize_api_v2_data_source_custom_request_endpoint.value
    TECHMIZE_API_V2_TOKEN                               = data.aws_ssm_parameter.techmize_api_v2_token.value
  }
}