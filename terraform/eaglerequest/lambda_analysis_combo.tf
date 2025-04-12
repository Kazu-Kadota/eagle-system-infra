data "aws_iam_policy_document" "analysis_combo" {
  source_policy_documents = [data.aws_iam_policy_document.use_case_publish_techmize_sns_topic_person.json]
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
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn
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
      data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_arn,
      "${data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_arn}/index/*"
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
      aws_dynamodb_table.analysis_vehicle.arn,
      "${aws_dynamodb_table.analysis_vehicle.arn}/index/*"
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

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
    ]

    resources = [
      data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_arn,
      "${data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_arn}/index/*"
    ]
  }
}

module "lambda_analysis_combo" {
  source        = "../modules/lambda"
  name          = "${var.project}-analysis-combo"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.analysis_combo.json
  handler       = "src/controllers/${var.project}/send-request-analysis/combo/index.handler"

  environment_variables = merge(
    local.use_case_publish_techimze_sns_topic_person_environment_variables,
    local.service_techmize_new_v1_store_request_environment_variables,
    {
      AUTH_ES256_PRIVATE_KEY                     = data.aws_ssm_parameter.auth_ecdsa_private_key.value
      DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON  = aws_dynamodb_table.analysis_person.name
      DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE = aws_dynamodb_table.analysis_vehicle.name
      DYNAMO_TABLE_EAGLEANALYSIS_PEOPLE          = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_name
      DYNAMO_TABLE_EAGLEANALYSIS_VEHICLES        = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_name
      DYNAMO_TABLE_EAGLEUSER_COMPANY             = data.terraform_remote_state.eagleuser.outputs.dynamodb_company_name
      DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG        = data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_name
    }
  )
}
