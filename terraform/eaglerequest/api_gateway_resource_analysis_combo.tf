# /analysis/combo
resource "aws_api_gateway_resource" "analysis_combo" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "combo"
}

# OPTIONS /analysis/combo
module "method_options_analysis_combo" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_combo.id
}

# POST /analysis/combo
module "method_post_analysis_combo" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_analysis_combo.arn
  resource_id   = aws_api_gateway_resource.analysis_combo.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}