data "aws_iam_policy_document" "query_analysis_by_document_plate" {
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
      aws_dynamodb_table.analysis_person.arn,
      "${aws_dynamodb_table.analysis_person.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.analysis_vehicle.arn,
      "${aws_dynamodb_table.analysis_vehicle.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_person.arn,
      "${aws_dynamodb_table.finished_analysis_person.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_vehicle.arn,
      "${aws_dynamodb_table.finished_analysis_vehicle.arn}/index/*"
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

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.eaglerequest_vehicle_analysis_answer.arn,
      "${aws_s3_bucket.eaglerequest_vehicle_analysis_answer.arn}/*"
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

module "lambda_query_analysis_by_document_plate" {
  source        = "../modules/lambda"
  name          = "${var.project}-query-analysis-by-document-plate"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.query_analysis_by_document_plate.json
  handler       = "src/controllers/${var.project}/consult/query-analysis-by-document-plate/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_PERSON           = aws_dynamodb_table.analysis_person.name
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE          = aws_dynamodb_table.analysis_vehicle.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_PERSON  = aws_dynamodb_table.finished_analysis_person.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = aws_dynamodb_table.finished_analysis_vehicle.name
    DYNAMO_TABLE_EAGLEUSER_OPERATOR_COMPANIES_ACCESS            = data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_name
    S3_PERSON_ANALYSIS_ANSWER                           = aws_s3_bucket.eaglerequest_person_analysis_answer.bucket
    S3_VEHICLE_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_vehicle_analysis_answer.bucket
  }
}
