resource "aws_api_gateway_usage_plan" "eaglerequest" {
  name = var.project

  api_stages {
    api_id = aws_api_gateway_rest_api.main.id
    stage  = aws_api_gateway_stage.main.stage_name
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

resource "aws_api_gateway_api_key" "eaglerequest_synthesis_admin" {
  name    = "${var.project}-synthesis-admin"
  enabled = true
}

resource "aws_api_gateway_usage_plan_key" "eaglerequest_synthesis_admin" {
  key_id        = aws_api_gateway_api_key.eaglerequest_synthesis_admin.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.eaglerequest.id
}

resource "aws_api_gateway_api_key" "eaglerequest_synthesis_transsat" {
  name    = "${var.project}-synthesis-transsat"
  value = data.aws_ssm_parameter.transsat_api_key.value
  enabled = true
}

resource "aws_api_gateway_usage_plan_key" "eaglerequest_synthesis_transsat" {
  key_id        = aws_api_gateway_api_key.eaglerequest_synthesis_transsat.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.eaglerequest.id
}