# /analysis/vehicle/{vehicle_id}
resource "aws_api_gateway_resource" "get_vehicle" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "{vehicle_id}"
}

# OPTIONS /analysis/vehicle/{vehicle_id}
module "method_options_analysis_vehicle_get_vehicle" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.get_vehicle.id
}

# GET /analysis/vehicle/{vehicle_id}
module "method_get_analysis_vehicle_get_vehicle" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "GET"
  lambda_arn  = module.lambda_get_vehicle.arn
  resource_id = aws_api_gateway_resource.get_vehicle.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}
