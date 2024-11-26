data "aws_iam_policy_document" "answer_analysis" {
  source_policy_documents = [
    data.aws_iam_policy_document.use_case_answer_person_analysis.json,
    data.aws_iam_policy_document.use_case_answer_vehicle_analysis.json
  ]
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

module "lambda_answer_analysis" {
  source        = "../modules/lambda"
  name          = "${var.project}-answer-analysis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.answer_analysis.json
  handler       = "src/controllers/${var.project}/send-answer/index.handler"

  environment_variables = merge(
    local.use_case_answer_person_analysis_environment_variables,
    local.use_case_answer_vehicle_analysis_environment_variables,
    {
      AUTH_ES256_PRIVATE_KEY = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    }
  )
}
