data "aws_iam_policy_document" "analysis" {
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
      data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_person_arn,
      "${data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_person_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_person_arn,
      "${data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_person_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_vehicle_arn,
      "${data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_vehicle_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_vehicle_arn,
      "${data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_vehicle_arn}/index/*"
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

module "lambda_analysis" {
  source        = "../modules/lambda"
  name          = "${var.project}-analysis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.analysis.json
  handler       = "src/controllers/${var.project}/generate-analysis-request/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                           = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON          = data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_person_name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON  = data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_person_name
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE          = data.terraform_remote_state.eaglerequest.outputs.dynamodb_analysis_vehicle_name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = data.terraform_remote_state.eaglerequest.outputs.dynamodb_finished_analysis_vehicle_name
    DYNAMO_TABLE_EAGLEUSER_COMPANY          = data.terraform_remote_state.eagleuser.outputs.dynamodb_company_name
    DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG          = data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_name
  }
}
