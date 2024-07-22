data "aws_iam_policy_document" "my_company" {
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
      aws_dynamodb_table.company.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:Scan"
    ]

    resources = [
      aws_dynamodb_table.feature_flag.arn
    ]
  }
}

module "lambda_my_company" {
  source        = "../modules/lambda"
  name          = "${var.project}-my-company"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.my_company.json
  handler       = "src/controllers/${var.project}/my-company/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_COMPANY      = aws_dynamodb_table.company.name
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG = aws_dynamodb_table.feature_flag.name
  }
}
