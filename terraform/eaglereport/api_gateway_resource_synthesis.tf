# /synthesis
resource "aws_api_gateway_resource" "synthesis" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "synthesis"
}

# OPTIONS /synthesis
module "method_options_synthesis" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.synthesis.id
}

# GET /synthesis
module "method_get_synthesis" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_synthesis.arn
  resource_id = aws_api_gateway_resource.synthesis.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
