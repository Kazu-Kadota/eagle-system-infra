# /{path_type}
resource "aws_api_gateway_resource" "path_type" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "{path_type}"
}

# OPTIONS /{path_type}
module "method_options_query_analysis_by_document_plate" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.path_type.id
}

# GET /{path_type}
module "method_get_query_analysis_by_document_plate" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_query_analysis_by_document_plate.arn
  resource_id = aws_api_gateway_resource.path_type.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
