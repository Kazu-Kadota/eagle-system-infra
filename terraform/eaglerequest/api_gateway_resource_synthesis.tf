# /synthesis
resource "aws_api_gateway_resource" "synthesis" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "synthesis"
}

# OPTIONS /synthesis
module "method_options_synthesis" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.synthesis.id
}

# POST /synthesis
module "method_post_analysis_synthesis" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis_vehicle_basic_data.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_basic_data.id // Resource está errado
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# GET /synthesis
module "method_get_analysis_synthesis" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_analysis_vehicle_basic_data.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_basic_data.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /synthesis/receive
resource "aws_api_gateway_resource" "synthesis_receive" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.synthesis.id
  path_part   = "receive"
}

# OPTIONS /synthesis/receive
module "method_options_synthesis_receive" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.synthesis_receive.id
}

# POST /synthesis/receive
module "method_post_synthesis_receive" {
  source           = "../modules/api_gateway_lambda"
  account_id       = module.global_variables.account_id
  authorization    = "NONE"
  aws_region       = module.global_variables.aws_region
  api_key_required = true
  http_method      = "POST"
  lambda_arn       = module.lambda_analysis_vehicle_basic_data.arn
  resource_id      = aws_api_gateway_resource.synthesis_receive.id
  rest_api_id      = aws_api_gateway_rest_api.main.id
}
