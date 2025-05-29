data "aws_iam_policy_document" "operator_companies_access_list" {
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
      aws_dynamodb_table.operator_companies_access.arn,
    ]
  }
}

module "lambda_operator_companies_access_list" {
  source        = "../modules/lambda"
  name          = "${var.project}-operator-companies-access-list"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.operator_companies_access_list.json
  handler       = "src/controllers/${var.project}/operator-companies-access/list/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY         = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_OPERATOR_COMPANIES_ACCESS = aws_dynamodb_table.operator_companies_access.name
  }
}
