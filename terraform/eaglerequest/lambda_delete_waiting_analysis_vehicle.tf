data "aws_iam_policy_document" "delete_waiting_analysis_vehicle" {
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
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn,
    ]
  }
}

module "lambda_delete_waiting_analysis_vehicle" {
  source        = "../modules/lambda"
  name          = "${var.project}-delete-waiting-analysis-vehicle"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.delete_waiting_analysis_vehicle.json
  handler       = "src/controllers/${var.project}/delete-waiting-analysis/vehicle/index.handler"
  timeout       = 10

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                             = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE = aws_dynamodb_table.analysis_vehicle.name
  }
}
