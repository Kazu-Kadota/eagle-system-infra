data "aws_iam_policy_document" "analysis_synthesis" {
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
      data.terraform_remote_state.eagleuser.outputs.dynamodb_company_arn,
      "${data.terraform_remote_state.eagleuser.outputs.dynamodb_company_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query",
    ]

    resources = [
      data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_arn,
      "${data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_person.arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_vehicle.arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.eaglerequest_synthesis_information.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.synthesis.arn
    ]
  }
}

module "lambda_analysis_synthesis" {
  source        = "../modules/lambda"
  name          = "${var.project}-analysis-synthesis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.analysis_synthesis.json
  handler       = "src/controllers/${var.project}/send-request-analysis/synthesis/index.handler"

  environment_variables = merge(
    local.service_transsat_send_request_synthesis_environment_variables,
    {
      AUTH_ES256_PRIVATE_KEY                              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
      DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON  = aws_dynamodb_table.finished_analysis_person.name
      DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = aws_dynamodb_table.finished_analysis_vehicle.name
      DYNAMO_TABLE_EAGLEREQUEST_SYNTHESIS                 = aws_dynamodb_table.synthesis.name
      DYNAMO_TABLE_EAGLEUSER_COMPANY                      = data.terraform_remote_state.eagleuser.outputs.dynamodb_company_name
      DYNAMO_TABLE_EAGLEUSER_FEATURE_FLAG                 = data.terraform_remote_state.eagleuser.outputs.dynamodb_feature_flag_name
      S3_SYNTHESIS_INFORMATION                            = aws_s3_bucket.eaglerequest_synthesis_information.bucket
    }
  )
}
