data "aws_iam_policy_document" "list_companies" {
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
    ]

    resources = [
      aws_dynamodb_table.operator_companies_access.arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      aws_dynamodb_table.company.arn,
      "${aws_dynamodb_table.company.arn}/index/*",
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.feature_flag.arn,
      "${aws_dynamodb_table.feature_flag.arn}/index/*",
    ]
  }
}

module "lambda_list_companies" {
  source        = "../modules/lambda"
  name          = "${var.project}-list-companies"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.list_companies.json
  handler       = "src/controllers/${var.project}/list-companies/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY         = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_COMPANY = aws_dynamodb_table.company.name
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG = aws_dynamodb_table.feature_flag.name
    DYNAMO_TABLE_EAGLEUSER_OPERATOR_COMPANIES_ACCESS = aws_dynamodb_table.operator_companies_access.name
  }
}
