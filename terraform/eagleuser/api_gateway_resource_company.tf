# /my-company
resource "aws_api_gateway_resource" "my_company" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "my-company"
}

# OPTIONS /my-company
module "method_options_my_company" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.my_company.id
}

# GET /my-company
module "method_get_my_company" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_my_company.arn
  resource_id   = aws_api_gateway_resource.my_company.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
