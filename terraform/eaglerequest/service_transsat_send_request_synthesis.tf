locals {
  service_transsat_send_request_synthesis_environment_variables = merge(
    local.service_transsat_get_token_environment_variables,
    {
      TRANSSAT_API_SYNTHESIS_ENDPOINT = data.aws_ssm_parameter.transsat_api_synthesis_endpoint.value
      TRANSSAT_API_POSTBACK_URL       = data.aws_ssm_parameter.transsat_api_postback_url.value
    }
  )
}
