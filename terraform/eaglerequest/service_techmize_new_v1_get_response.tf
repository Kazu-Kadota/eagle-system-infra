locals {
  service_techmize_new_v1_get_response_environment_variables = {
    TECHMIZE_API_NEW_V1_REQUEST_GET_RESPONSE_ENDPOINT = data.aws_ssm_parameter.techmize_api_new_v1_request_get_response_endpoint.value
    TECHMIZE_API_NEW_V1_TOKEN                         = data.aws_ssm_parameter.techmize_api_new_v1_token.value
  }
}