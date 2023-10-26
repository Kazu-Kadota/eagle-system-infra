data "aws_iam_policy_document" "reset_password" {
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
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.users.arn,
      "${aws_dynamodb_table.users.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:DeleteItem"
    ]

    resources = [aws_dynamodb_table.recovery_password.arn]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [aws_dynamodb_table.password_history.arn]
  }
}

module "lambda_reset_password" {
  source        = "../modules/lambda"
  name          = "${var.project}-reset-password"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.reset_password.json
  handler       = "src/controllers/${var.project}/reset-password/index.handler"

  environment_variables = {
    DYNAMO_TABLE_EAGLEUSER_USER              = aws_dynamodb_table.users.name
    DYNAMO_TABLE_EAGLEUSER_RECOVERY_PASSWORD = aws_dynamodb_table.recovery_password.name
    DYNAMO_TABLE_EAGLEUSER_PASSWORD_HISTORY  = aws_dynamodb_table.password_history.name
  }
}
