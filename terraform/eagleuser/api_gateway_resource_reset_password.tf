# /reset-password
resource "aws_api_gateway_resource" "reset_password" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "reset-password"
}

# OPTIONS /reset-password
module "method_options_reset_password" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.reset_password.id
}

# POST /reset-password
module "method_post_reset_password" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_reset_password.arn
  resource_id   = aws_api_gateway_resource.reset_password.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
