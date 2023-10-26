# /analysis/person/{person_id}
resource "aws_api_gateway_resource" "get_person" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_person.id
  path_part   = "{person_id}"
}

# OPTIONS /analysis/person/{person_id}
module "method_options_analysis_person_get_person" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.get_person.id
}

# GET /analysis/person/{person_id}
module "method_get_analysis_person_get_person" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_get_person.arn
  resource_id = aws_api_gateway_resource.get_person.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
