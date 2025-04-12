data "aws_iam_policy_document" "get_person" {
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
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.analysis_person.arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_person.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.eaglerequest_person_analysis_answer.arn,
      "${aws_s3_bucket.eaglerequest_person_analysis_answer.arn}/*"
    ]
  }
}

module "lambda_get_person" {
  source        = "../modules/lambda"
  name          = "${var.project}-get-person"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.get_person.json
  handler       = "src/controllers/${var.project}/consult/analysis/get-person/index.handler"
  timeout       = 30

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                             = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON          = aws_dynamodb_table.analysis_person.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON = aws_dynamodb_table.finished_analysis_person.name
    S3_PERSON_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_person_analysis_answer.bucket
  }
}
