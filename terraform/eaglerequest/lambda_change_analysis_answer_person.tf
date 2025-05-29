data "aws_iam_policy_document" "change_analysis_answer_person" {
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
      "dynamodb:UpdateItem",
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_person.arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.eaglerequest_person_analysis_answer.arn,
      "${aws_s3_bucket.eaglerequest_person_analysis_answer.arn}/*"
    ]
  }
}

module "lambda_change_analysis_answer_person" {
  source        = "../modules/lambda"
  name          = "${var.project}-change-analysis-answer-person"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.change_analysis_answer_person.json
  handler       = "src/controllers/${var.project}/change-analysis-answer/person/index.handler"
  timeout       = 10

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                             = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON = aws_dynamodb_table.finished_analysis_person.name
    S3_PERSON_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_person_analysis_answer.bucket
  }
}
