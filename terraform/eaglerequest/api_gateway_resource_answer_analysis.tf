# /analysis/{analysis_type}
resource "aws_api_gateway_resource" "analysis_analysis_type" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "{analysis_type}"
}

# OPTIONS /analysis/{analysis_type}
module "method_options_analysis_analysis_type" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_analysis_type.id
}

# /analysis/{analysis_type}/{id}
resource "aws_api_gateway_resource" "analysis_analysis_type_id" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_analysis_type.id
  path_part   = "{id}"
}

# OPTIONS /analysis/{analysis_type}/{id}
module "method_options_analysis_id" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_analysis_type_id.id
}

# /analysis/{analysis_type}/{id}/answer
resource "aws_api_gateway_resource" "analysis_analysis_type_id_answer" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_analysis_type_id.id
  path_part   = "answer"
}

# OPTIONS /analysis/{analysis_type}/{id}/answer
module "method_options_analysis_id_answer" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_analysis_type_id_answer.id
}

# POST /analysis/{analysis_type}/{id}/answer
module "method_post_analysis_analysis_type_id_answer" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_answer_analysis.arn
  resource_id = aws_api_gateway_resource.analysis_analysis_type_id_answer.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
