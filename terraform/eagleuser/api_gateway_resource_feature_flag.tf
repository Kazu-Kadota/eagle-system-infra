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

# /feature-flag/set
resource "aws_api_gateway_resource" "feature_flag_set" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag.id
  path_part   = "set"
}

# OPTIONS /feature-flag/set
module "method_options_feature_flag_set" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_set.id
}

# PUT /feature-flag/set
module "method_put_feature_flag_set" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "PUT"
  lambda_arn    = module.lambda_feature_flag_set.arn
  resource_id   = aws_api_gateway_resource.feature_flag_set.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /feature-flag/modify-allowance
resource "aws_api_gateway_resource" "feature_flag_modify_allowance" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.feature_flag.id
  path_part   = "modify-allowance"
}

# OPTIONS /feature-flag/modify-allowance
module "method_options_feature_flag_modify_allowance" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.feature_flag_modify_allowance.id
}

# POST /feature-flag/modify-allowance
module "method_post_feature_flag_modify_allowance" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_feature_flag_modify_allowance.arn
  resource_id   = aws_api_gateway_resource.feature_flag_modify_allowance.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
