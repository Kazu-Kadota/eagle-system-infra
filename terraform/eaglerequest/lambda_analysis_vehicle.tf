data "aws_iam_policy_document" "analysis_vehicle_default" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_arn,
      "${data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn,
      "${aws_dynamodb_table.analysis_vehicle.arn}/index/*"
    ]
  }
}

module "lambda_analysis_vehicle_default" {
  source        = "../modules/lambda"
  name          = "${var.project}-analysis-vehicle-default"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.analysis_vehicle_default.json
  handler       = "src/controllers/${var.project}/send-request-analysis/vehicle/default/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                  = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE = aws_dynamodb_table.analysis_vehicle.name
    DYNAMO_TABLE_EAGLEANALYSIS_VEHICLES        = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_name
  }
}
