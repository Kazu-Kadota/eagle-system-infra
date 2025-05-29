data "aws_iam_policy_document" "feature_flag_delete" {
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
      "dynamodb:DeleteItem",
    ]

    resources = [
      aws_dynamodb_table.feature_flag.arn,
    ]
  }
}

module "lambda_feature_flag_delete" {
  source        = "../modules/lambda"
  name          = "${var.project}-feature-flag-delete"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.feature_flag_delete.json
  handler       = "src/controllers/${var.project}/feature-flag/delete/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG = aws_dynamodb_table.feature_flag.name
  }
}
