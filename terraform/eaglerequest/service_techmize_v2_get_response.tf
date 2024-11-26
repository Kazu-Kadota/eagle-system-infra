locals {
  service_techmize_v2_get_response_environment_variables = {
    TECHMIZE_API_V2_DATA_SOURCE_GET_RESPONSE_ENDPOINT = data.aws_ssm_parameter.techmize_api_v2_data_source_get_response_endpoint.value
    TECHMIZE_API_V2_TOKEN                             = data.aws_ssm_parameter.techmize_api_v2_token.value
  }
}