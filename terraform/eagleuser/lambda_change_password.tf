data "aws_iam_policy_document" "change_password" {
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
      "dynamodb:UpdateItem"
    ]

    resources = [aws_dynamodb_table.users.arn]
  }
}

module "lambda_change_password" {
  source        = "../modules/lambda"
  name          = "${var.project}-change-password"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.change_password.json
  handler       = "src/controllers/${var.project}/change-password/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY   = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_USER = aws_dynamodb_table.users.name
  }
}
