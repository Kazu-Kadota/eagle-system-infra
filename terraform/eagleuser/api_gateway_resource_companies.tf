# /companies
resource "aws_api_gateway_resource" "list_companies" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "companies"
}

# OPTIONS /companies
module "method_options_list_companies" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.list_companies.id
}

# GET /companies
module "method_get_list_companies" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_list_companies.arn
  resource_id   = aws_api_gateway_resource.list_companies.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
