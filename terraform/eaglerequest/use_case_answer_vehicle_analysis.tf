data "aws_iam_policy_document" "use_case_answer_vehicle_analysis" {

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
    ]

    resources = [
      data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_arn
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_vehicle.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.eaglerequest_vehicle_analysis_answer.arn}/*"
    ]
  }
}

locals {
  use_case_answer_vehicle_analysis_environment_variables = {
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE          = aws_dynamodb_table.analysis_vehicle.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = aws_dynamodb_table.finished_analysis_vehicle.name
    DYNAMO_TABLE_EAGLEANALYSIS_VEHICLES                 = data.terraform_remote_state.eagleanalysis.outputs.dynamodb_vehicles_name
    S3_VEHICLE_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_vehicle_analysis_answer.bucket

  }
}