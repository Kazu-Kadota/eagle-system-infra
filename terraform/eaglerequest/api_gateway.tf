resource "aws_iam_role" "cloudwatch" {
  name = "${var.project}-api-gateway-cloudwatch"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "${var.project}-api-gateway-cloudwatch"
  role = aws_iam_role.cloudwatch.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

resource "aws_api_gateway_rest_api" "main" {
  name = "api-${var.project}-${terraform.workspace}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "dev"

  stage_description = "Deploy em ${timestamp()}"

  depends_on = [
    module.method_get_analysis_list_people,
    module.method_get_analysis_list_vehicles,
    module.method_get_analysis_person_get_person,
    module.method_get_analysis_vehicle_get_vehicle,
    module.method_get_query_analysis_by_document_plate,
    module.method_options_analysis_analysis_type,
    module.method_options_analysis_combo,
    module.method_options_analysis_id_answer,
    module.method_options_analysis_id,
    module.method_options_analysis_list_people,
    module.method_options_analysis_list_vehicles,
    module.method_options_analysis_person_get_person,
    module.method_options_analysis_person,
    module.method_options_analysis_vehicle_get_vehicle,
    module.method_options_analysis_vehicle_plate_history,
    module.method_options_analysis_vehicle_second_driver,
    module.method_options_analysis_vehicle,
    module.method_options_analysis,
    module.method_options_query_analysis_by_document_plate,
    module.method_post_analysis_analysis_type_id_answer,
    module.method_post_analysis_combo,
    module.method_post_analysis_person,
    module.method_post_analysis_vehicle_plate_history,
    module.method_post_analysis_vehicle_second_driver,
    module.method_post_analysis_vehicle,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_gateway_response" "error_unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,x-realm,x-device-token,x-sf-token,x-mpdo-token'",
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,PATCH'",
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [aws_api_gateway_deployment.main]
}

module "api_gateway_log_format" {
  source      = "../modules/api_gateway_log_format"
  domain_name = local.domain_name
  project     = var.project
}

resource "aws_api_gateway_stage" "main" {
  stage_name    = terraform.workspace
  rest_api_id   = aws_api_gateway_rest_api.main.id
  deployment_id = aws_api_gateway_deployment.main.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_main.arn
    format          = module.api_gateway_log_format.json_rendered
  }
}

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = terraform.workspace
  method_path = "*/*"

  settings {
    logging_level   = "OFF"
    metrics_enabled = true
  }

  depends_on = [aws_api_gateway_stage.main]
}
