data "aws_iam_policy_document" "login" {
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
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.users.arn,
      "${aws_dynamodb_table.users.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      aws_dynamodb_table.company.arn,
      "${aws_dynamodb_table.company.arn}/index/*"
    ]
  }
}

module "lambda_login" {
  source        = "../modules/lambda"
  name          = "${var.project}-login"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.login.json
  handler       = "src/controllers/${var.project}/login/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY         = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_USER    = aws_dynamodb_table.users.name
    DYNAMO_TABLE_EAGLEUSER_COMPANY = aws_dynamodb_table.company.name
  }
}
