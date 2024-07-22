data "aws_iam_policy_document" "get_vehicle" {
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
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_vehicle.arn,
    ]
  }
}

module "lambda_get_vehicle" {
  source        = "../modules/lambda"
  name          = "${var.project}-get-vehicle"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.get_vehicle.json
  handler       = "src/controllers/${var.project}/consult/analysis/get-vehicle/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE          = aws_dynamodb_table.analysis_vehicle.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = aws_dynamodb_table.finished_analysis_vehicle.name
  }
}
