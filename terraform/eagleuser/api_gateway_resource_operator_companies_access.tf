# /operator-companies-access
resource "aws_api_gateway_resource" "operator_companies_access" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "operator-companies-access"
}

# OPTIONS /operator-companies-access
module "method_options_operator_companies_access" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.operator_companies_access.id
}

# POST /operator-companies-access
module "method_post_operator_companies_access" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_operator_companies_access_register_companies.arn
  resource_id   = aws_api_gateway_resource.operator_companies_access.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# GET /operator-companies-access
module "method_get_operator_companies_access" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_operator_companies_access_get.arn
  resource_id   = aws_api_gateway_resource.operator_companies_access.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /operator-companies-access/list
resource "aws_api_gateway_resource" "operator_companies_access_list" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.operator_companies_access.id
  path_part   = "list"
}

# OPTIONS /operator-companies-access/list
module "method_options_operator_companies_access_list" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.operator_companies_access_list.id
}

# GET /operator-companies-access/list
module "method_get_operator_companies_access_list" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_operator_companies_access_list.arn
  resource_id   = aws_api_gateway_resource.operator_companies_access_list.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /operator-companies-access/delete-companies
resource "aws_api_gateway_resource" "operator_companies_access_delete_companies" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.operator_companies_access.id
  path_part   = "delete-companies"
}

# OPTIONS /operator-companies-access/delete-companies
module "method_options_operator_companies_access_delete_companies" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.operator_companies_access_delete_companies.id
}

# POST /operator-companies-access/delete-companies
module "method_post_operator_companies_access_delete_companies" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_operator_companies_access_delete_companies.arn
  resource_id   = aws_api_gateway_resource.operator_companies_access_delete_companies.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /operator-companies-access/delete-users
resource "aws_api_gateway_resource" "operator_companies_access_delete_users" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.operator_companies_access.id
  path_part   = "delete-users"
}

# OPTIONS /operator-companies-access/delete-users
module "method_options_operator_companies_access_delete_users" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.operator_companies_access_delete_users.id
}

# POST /operator-companies-access/delete-users
module "method_post_operator_companies_access_delete_users" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_operator_companies_access_delete_users.arn
  resource_id   = aws_api_gateway_resource.operator_companies_access_delete_users.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
