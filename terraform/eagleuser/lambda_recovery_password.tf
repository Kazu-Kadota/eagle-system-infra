data "aws_iam_policy_document" "recovery_password" {
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
      "dynamodb:PutItem"
    ]

    resources = [aws_dynamodb_table.recovery_password.arn]
  }

  statement {
    actions = [
      "ses:SendEmail"
    ]

    resources = [data.terraform_remote_state.ses.outputs.ses_email_identity_arn]
  }
}

module "lambda_recovery_password" {
  source        = "../modules/lambda"
  name          = "${var.project}-recovery-password"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.recovery_password.json
  handler       = "src/controllers/${var.project}/recovery-password/index.handler"

  environment_variables = {
    DYNAMO_TABLE_EAGLEUSER_USER              = aws_dynamodb_table.users.name
    DYNAMO_TABLE_EAGLEUSER_RECOVERY_PASSWORD = aws_dynamodb_table.recovery_password.name
    USER_RECOVERY_KEY_URL                 = "${local.url_name}/redefinir-senha"
    SYSTEMEAGLE_EMAIL                        = local.source_email_name
  }
}
