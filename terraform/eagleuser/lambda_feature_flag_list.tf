data "aws_iam_policy_document" "feature_flag_list" {
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
      "dynamodb:Query",
    ]

    resources = [
      aws_dynamodb_table.feature_flag.arn,
      "${aws_dynamodb_table.feature_flag.arn}/index/*",
    ]
  }
}

module "lambda_feature_flag_list" {
  source        = "../modules/lambda"
  name          = "${var.project}-feature-flag-list"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.feature_flag_list.json
  handler       = "src/controllers/${var.project}/feature-flag/list/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG = aws_dynamodb_table.feature_flag.name
  }
}
