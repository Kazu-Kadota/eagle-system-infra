data "aws_iam_policy_document" "analysis_person" {
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
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.analysis_person.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_arn,
      "${data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      aws_dynamodb_table.analysis_person.arn,
      "${aws_dynamodb_table.analysis_person.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      data.terraform_remote_state.eagleuser.outputs.dynamodb_company_arn,
      "${data.terraform_remote_state.eagleuser.outputs.dynamodb_company_arn}/index/*"
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
}

module "lambda_analysis_person" {
  source        = "../modules/lambda"
  name          = "${var.project}-analysis-person"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.analysis_person.json
  handler       = "src/controllers/${var.project}/send-request-analysis/person/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                    = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON = aws_dynamodb_table.analysis_person.name
    DYNAMO_TABLE_EAGLEANALYSIS_PEOPLE         = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_name
    DYNAMO_TABLE_EAGLEUSER_COMPANY            = data.terraform_remote_state.eagleuser.outputs.dynamodb_company_name
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG       = data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_name
  }
}
