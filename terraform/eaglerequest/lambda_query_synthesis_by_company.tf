data "aws_iam_policy_document" "query_synthesis_by_company" {
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
      data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_arn,
      "${data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_arn}/index/*",
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
    ]

    resources = [
      data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.synthesis.arn,
      "${aws_dynamodb_table.synthesis.arn}/index/*",
    ]
  }
}

module "lambda_query_synthesis_by_company" {
  source        = "../modules/lambda"
  name          = "${var.project}-query-synthesis-by-company"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.query_synthesis_by_company.json
  handler       = "src/controllers/${var.project}/consult/synthesis/query-by-company/index.handler"
  timeout       = 30

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEUSER_COMPANY            = data.terraform_remote_state.eagleuser.outputs.dynamodb_company_name
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG            = data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_name
    DYNAMO_TABLE_EAGLEREQUEST_SYNTHESIS = aws_dynamodb_table.synthesis.name
    S3_SYNTHESIS_INFORMATION            = aws_s3_bucket.eaglerequest_synthesis_information.bucket
  }
}
