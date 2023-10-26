# /analysis/people
resource "aws_api_gateway_resource" "list_people" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "people"
}

# OPTIONS /analysis/people
module "method_options_analysis_list_people" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.list_people.id
}

# GET /analysis/people
module "method_get_analysis_list_people" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_list_people.arn
  resource_id = aws_api_gateway_resource.list_people.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
