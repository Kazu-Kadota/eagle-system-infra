data "aws_iam_policy_document" "list_people" {
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
      "dynamodb:Scan"
    ]

    resources = [
      aws_dynamodb_table.analysis_person.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
    ]

    resources = [
      data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_arn,
    ]
  }
}

module "lambda_list_people" {
  source        = "../modules/lambda"
  name          = "${var.project}-list-people"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.list_people.json
  handler       = "src/controllers/${var.project}/consult/analysis/list-people/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                    = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON = aws_dynamodb_table.analysis_person.name
    DYNAMO_TABLE_EAGLEUSER_OPERATOR_COMPANIES_ACCESS            = data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_name
  }
}
