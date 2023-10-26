# /analysis/{path_type}
resource "aws_api_gateway_resource" "path_type" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "{path_type}"
}

# OPTIONS /analysis/{path_type}
module "method_options_analysis_path_type" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.path_type.id
}

# POST /analysis/{path_type}/
module "method_post_analysis_path_type" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis.arn
  resource_id = aws_api_gateway_resource.path_type.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
