data "aws_iam_policy_document" "auth" {
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
}

module "lambda_auth" {
  source        = "../modules/lambda"
  name          = "${var.project}-auth"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.auth.json
  handler       = "src/auth/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY = data.aws_ssm_parameter.auth_ecdsa_private_key.value
  }
}
