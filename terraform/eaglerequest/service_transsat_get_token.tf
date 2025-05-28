locals {
  service_transsat_get_token_environment_variables = {
    TRANSSAT_API_TOKEN_ENDPOINT = data.aws_ssm_parameter.transsat_api_token_endpoint.value
    TRANSSAT_API_GET_TOKEN_CLIENT_ID = data.aws_ssm_parameter.transsat_api_token_client_id.value
    TRANSSAT_API_GET_TOKEN_CLIENT_SECRET = data.aws_ssm_parameter.transsat_api_token_client_secret.value
    TRANSSAT_API_GET_TOKEN_GRANT_TYPE = data.aws_ssm_parameter.transsat_api_token_grant_type.value
    TRANSSAT_API_GET_TOKEN_USERNAME = data.aws_ssm_parameter.transsat_api_token_username.value
    TRANSSAT_API_GET_TOKEN_PASSWORD = data.aws_ssm_parameter.transsat_api_token_password.value
  }
}
