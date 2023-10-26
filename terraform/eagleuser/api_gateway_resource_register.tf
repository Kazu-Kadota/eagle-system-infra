# /register
resource "aws_api_gateway_resource" "register" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "register"
}

# OPTIONS /register
module "method_options_register" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.register.id
}

# /register/user
resource "aws_api_gateway_resource" "register_user" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.register.id
  path_part   = "user"
}

# OPTIONS /register/user
module "method_options_register_user" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.register_user.id
}

# POST /register/user
module "method_post_register_user" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_register_user.arn
  resource_id = aws_api_gateway_resource.register_user.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /register/company
resource "aws_api_gateway_resource" "register_company" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.register.id
  path_part   = "company"
}

# OPTIONS /register/company
module "method_options_register_company" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.register_company.id
}

# POST /register/company
module "method_post_register_company" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_register_company.arn
  resource_id = aws_api_gateway_resource.register_company.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
