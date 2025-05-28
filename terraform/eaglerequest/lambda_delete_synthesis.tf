data "aws_iam_policy_document" "delete_synthesis" {
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
      "dynamodb:DeleteItem",
    ]

    resources = [
      aws_dynamodb_table.synthesis.arn,
    ]
  }
}

module "lambda_delete_synthesis" {
  source        = "../modules/lambda"
  name          = "${var.project}-delete-synthesis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.delete_synthesis.json
  handler       = "src/controllers/${var.project}/delete-synthesis/index.handler"
  timeout       = 10

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                             = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_SYNTHESIS                 = aws_dynamodb_table.synthesis.name
  }
}
