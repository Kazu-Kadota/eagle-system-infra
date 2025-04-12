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

resource "aws_api_gateway_api_key" "eaglerequest_synthesis" {
  name    = "${var.project}-synthesis"
  enabled = true
}

resource "aws_api_gateway_usage_plan_key" "eaglerequest_synthesis" {
  key_id        = aws_api_gateway_api_key.eaglerequest_synthesis.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.eaglerequest.id
}