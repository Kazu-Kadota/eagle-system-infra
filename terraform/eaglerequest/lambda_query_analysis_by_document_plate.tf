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
  }
}
