data "aws_iam_policy_document" "use_case_answer_person_analysis" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
    ]

    resources = [
      aws_dynamodb_table.analysis_person.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_arn
    ]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_person.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.eaglerequest_person_analysis_answer.arn}/*"
    ]
  }
}

locals {
  use_case_answer_person_analysis_environment_variables = {
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON          = aws_dynamodb_table.analysis_person.name
    DYNAMO_TABLE_EAGLEANALYSIS_PEOPLE                  = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_people_name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON = aws_dynamodb_table.finished_analysis_person.name
    S3_PERSON_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_person_analysis_answer.bucket
  }
}