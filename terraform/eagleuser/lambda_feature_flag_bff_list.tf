data "aws_iam_policy_document" "feature_flag_bff_list" {
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
      "dynamodb:Scan",
    ]

    resources = [
      aws_dynamodb_table.feature_flag_bff.arn,
      "${aws_dynamodb_table.feature_flag_bff.arn}/index/*",
    ]
  }
}

module "lambda_feature_flag_bff_list" {
  source        = "../modules/lambda"
  name          = "${var.project}-feature-flag-bff-list"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.feature_flag_bff_list.json
  handler       = "src/controllers/${var.project}/feature-flag/bff/list/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG_BFF = aws_dynamodb_table.feature_flag_bff.name
  }
}
