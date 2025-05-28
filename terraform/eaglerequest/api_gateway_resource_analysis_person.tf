# /analysis/person
resource "aws_api_gateway_resource" "analysis_person" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "person"
}

# OPTIONS /analysis/person
module "method_options_analysis_person" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_person.id
}

# POST /analysis/person
module "method_post_analysis_person" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_analysis_person.arn
  resource_id   = aws_api_gateway_resource.analysis_person.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /analysis/person/change-answer
resource "aws_api_gateway_resource" "analysis_person_change_answer" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_person.id
  path_part   = "change-answer"
}

# OPTIONS /analysis/person/change-answer
module "method_options_analysis_person_change_answer" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_person_change_answer.id
}

# POST /analysis/person/change-answer
module "method_post_analysis_person_change_answer" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_change_analysis_answer_person.arn
  resource_id   = aws_api_gateway_resource.analysis_person_change_answer.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /analysis/person/delete-waiting
resource "aws_api_gateway_resource" "analysis_person_delete_waiting" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_person.id
  path_part   = "delete-waiting"
}

# OPTIONS /analysis/person/delete-waiting
module "method_options_analysis_person_delete_waiting" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_person_delete_waiting.id
}

# POST /analysis/person/delete-waiting
module "method_post_analysis_person_delete_waiting" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_delete_waiting_analysis_person.arn
  resource_id   = aws_api_gateway_resource.analysis_person_delete_waiting.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}