# /analysis
resource "aws_api_gateway_resource" "analysis" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "analysis"
}

# OPTIONS /analysis
module "method_options_analysis" {
  source      = "../modules/api_gateway_options"
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.analysis.id
}

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
