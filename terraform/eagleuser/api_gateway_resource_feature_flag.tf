# /feature-flag
resource "aws_api_gateway_resource" "feature_flag" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "feature-flag"
}

# OPTIONS /feature-flag
module "method_options_feature_flag" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag.id
}

# /feature-flag/company
resource "aws_api_gateway_resource" "feature_flag_company" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag.id
  path_part   = "company"
}

# OPTIONS /feature-flag/company
module "method_options_feature_flag_company" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_company.id
}

# GET /feature-flag/company
module "method_get_feature_flag_company" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_feature_flag_list.arn
  resource_id   = aws_api_gateway_resource.feature_flag_company.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# POST /feature-flag/company
module "method_post_feature_flag_company" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_feature_flag_update.arn
  resource_id   = aws_api_gateway_resource.feature_flag_company.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# PUT /feature-flag/company
module "method_put_feature_flag_company" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "PUT"
  lambda_arn    = module.lambda_feature_flag_set.arn
  resource_id   = aws_api_gateway_resource.feature_flag_company.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /feature-flag/company/delete
resource "aws_api_gateway_resource" "feature_flag_company_delete" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag_company.id
  path_part   = "delete"
}

# OPTIONS /feature-flag/company/delete
module "method_options_feature_flag_company_delete" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_company_delete.id
}

# POST /feature-flag/company/delete
module "method_post_feature_flag_company_delete" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_feature_flag_delete.arn
  resource_id   = aws_api_gateway_resource.feature_flag_company_delete.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /feature-flag/bff
resource "aws_api_gateway_resource" "feature_flag_bff" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag.id
  path_part   = "bff"
}

# OPTIONS /feature-flag/bff
module "method_options_feature_flag_bff" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_bff.id
}

# GET /feature-flag/bff
module "method_get_feature_flag_bff" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "GET"
  lambda_arn    = module.lambda_feature_flag_bff_list.arn
  resource_id   = aws_api_gateway_resource.feature_flag_bff.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# POST /feature-flag/bff
module "method_post_feature_flag_bff" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_feature_flag_bff_update.arn
  resource_id   = aws_api_gateway_resource.feature_flag_bff.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# PUT /feature-flag/bff
module "method_put_feature_flag_bff" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "PUT"
  lambda_arn    = module.lambda_feature_flag_bff_set.arn
  resource_id   = aws_api_gateway_resource.feature_flag_bff.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /feature-flag/bff/delete
resource "aws_api_gateway_resource" "feature_flag_bff_delete" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag_bff.id
  path_part   = "delete"
}

# OPTIONS /feature-flag/bff/delete
module "method_options_feature_flag_bff_delete" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_bff_delete.id
}

# POST /feature-flag/bff/delete
module "method_post_feature_flag_bff_delete" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_feature_flag_bff_delete.arn
  resource_id   = aws_api_gateway_resource.feature_flag_bff_delete.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
