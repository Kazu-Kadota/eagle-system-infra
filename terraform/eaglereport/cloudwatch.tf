resource "aws_cloudwatch_log_group" "api_gateway_main" {
  name              = "/aws/apigateway/${var.project}-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_analysis" {
  name              = "/aws/lambda/${var.project}-analysis-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}
