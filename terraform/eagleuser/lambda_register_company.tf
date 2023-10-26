data "aws_iam_policy_document" "register_company" {
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
      aws_dynamodb_table.company.arn,
      "${aws_dynamodb_table.company.arn}/index/*"
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

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.company.arn
    ]
  }
}

module "lambda_register_company" {
  source        = "../modules/lambda"
  name          = "${var.project}-register-company"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.register_company.json
  handler       = "src/controllers/${var.project}/register/company/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY      = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_COMPANY = aws_dynamodb_table.company.name
  }
}
