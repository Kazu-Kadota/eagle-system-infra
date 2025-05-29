data "aws_iam_policy_document" "get_vehicle" {
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
      aws_dynamodb_table.analysis_vehicle.arn,
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.finished_analysis_vehicle.arn,
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

module "lambda_get_vehicle" {
  source        = "../modules/lambda"
  name          = "${var.project}-get-vehicle"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.get_vehicle.json
  handler       = "src/controllers/${var.project}/consult/analysis/get-vehicle/index.handler"
  timeout       = 30

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY                              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_ANALYSIS_VEHICLE          = aws_dynamodb_table.analysis_vehicle.name
    DYNAMO_TABLE_EAGLEREQUEST_FINISHED_ANALYSIS_VEHICLE = aws_dynamodb_table.finished_analysis_vehicle.name
    DYNAMO_TABLE_EAGLEUSER_OPERATOR_COMPANIES_ACCESS            = data.terraform_remote_state.eagleuser.outputs.dynamodb_operator_companies_access_name
    S3_VEHICLE_ANALYSIS_ANSWER                          = aws_s3_bucket.eaglerequest_vehicle_analysis_answer.bucket
  }
}
