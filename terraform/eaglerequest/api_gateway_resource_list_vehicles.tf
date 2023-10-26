# /analysis/vehicles
resource "aws_api_gateway_resource" "list_vehicles" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "vehicles"
}

# OPTIONS /analysis/vehicles
module "method_options_analysis_list_vehicles" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.list_vehicles.id
}

# GET /analysis/vehicles
module "method_get_analysis_list_vehicles" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_list_vehicles.arn
  resource_id = aws_api_gateway_resource.list_vehicles.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
