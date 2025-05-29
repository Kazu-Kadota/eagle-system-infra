# /users
resource "aws_api_gateway_resource" "list_users" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "users"
}

# OPTIONS /users
module "method_options_list_users" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.list_users.id
}

# GET /users
module "method_get_list_users" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_list_users.arn
  resource_id   = aws_api_gateway_resource.list_users.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
