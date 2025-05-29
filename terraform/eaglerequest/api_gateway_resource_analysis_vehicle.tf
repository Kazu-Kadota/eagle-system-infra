# /analysis/vehicle
resource "aws_api_gateway_resource" "analysis_vehicle" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis.id
  path_part   = "vehicle"
}

# OPTIONS /analysis/vehicle
module "method_options_analysis_vehicle" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle.id
}

# POST /analysis/vehicle
module "method_post_analysis_vehicle" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_analysis_vehicle_default.arn
  resource_id   = aws_api_gateway_resource.analysis_vehicle.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/plate-history
resource "aws_api_gateway_resource" "analysis_vehicle_plate_history" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "plate-history"
}

# OPTIONS /analysis/vehicle/plate-history
module "method_options_analysis_vehicle_plate_history" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_plate_history.id
}

# POST /analysis/vehicle/plate-history
module "method_post_analysis_vehicle_plate_history" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis_vehicle_plate_history.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_plate_history.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/second-driver
resource "aws_api_gateway_resource" "analysis_vehicle_second_driver" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "second-driver"
}

# OPTIONS /analysis/vehicle/second-driver
module "method_options_analysis_vehicle_second_driver" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_second_driver.id
}

# POST /analysis/vehicle/second-driver
module "method_post_analysis_vehicle_second_driver" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis_vehicle_second_driver.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_second_driver.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/antt
resource "aws_api_gateway_resource" "analysis_vehicle_antt" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "antt"
}

# OPTIONS /analysis/vehicle/antt
module "method_options_analysis_vehicle_antt" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_antt.id
}

# POST /analysis/vehicle/antt
module "method_post_analysis_vehicle_antt" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis_vehicle_antt.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_antt.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/basic-data
resource "aws_api_gateway_resource" "analysis_vehicle_basic_data" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "basic-data"
}

# OPTIONS /analysis/vehicle/basic-data
module "method_options_analysis_vehicle_basic_data" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_basic_data.id
}

# POST /analysis/vehicle/basic-data
module "method_post_analysis_vehicle_basic_data" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  # authorizer_id = aws_api_gateway_authorizer.auth.id
  aws_region  = module.global_variables.aws_region
  http_method = "POST"
  lambda_arn  = module.lambda_analysis_vehicle_basic_data.arn
  resource_id = aws_api_gateway_resource.analysis_vehicle_basic_data.id
  rest_api_id = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/change-answer
resource "aws_api_gateway_resource" "analysis_vehicle_change_answer" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "change-answer"
}

# OPTIONS /analysis/vehicle/change-answer
module "method_options_analysis_vehicle_change_answer" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_change_answer.id
}

# POST /analysis/vehicle/change-answer
module "method_post_analysis_vehicle_change_answer" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_change_analysis_answer_vehicle.arn
  resource_id   = aws_api_gateway_resource.analysis_vehicle_change_answer.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

# /analysis/vehicle/delete-waiting
resource "aws_api_gateway_resource" "analysis_vehicle_delete_waiting" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.analysis_vehicle.id
  path_part   = "delete-waiting"
}

# OPTIONS /analysis/vehicle/delete-waiting
module "method_options_analysis_vehicle_delete_waiting" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis_vehicle_delete_waiting.id
}

# POST /analysis/vehicle/delete-waiting
module "method_post_analysis_vehicle_delete_waiting" {
  source        = "../modules/api_gateway_lambda"
  account_id    = module.global_variables.account_id
  authorization = "NONE"
  aws_region    = module.global_variables.aws_region
  http_method   = "POST"
  lambda_arn    = module.lambda_delete_waiting_analysis_vehicle.arn
  resource_id   = aws_api_gateway_resource.analysis_vehicle_delete_waiting.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}
