data "aws_iam_policy_document" "list_vehicles" {
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
      "dynamodb:Scan"
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn
    ]
  }
}

module "lambda_list_vehicles" {
  source        = "../modules/lambda"
  name          = "${var.project}-list-vehicles"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.list_vehicles.json
  handler       = "src/controllers/${var.project}/consult/analysis/list-vehicles/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                     = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE = aws_dynamodb_table.analysis_vehicle.name
  }
}
