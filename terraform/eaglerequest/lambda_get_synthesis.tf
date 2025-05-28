data "aws_iam_policy_document" "get_synthesis" {
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
      aws_dynamodb_table.synthesis.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.eaglerequest_synthesis_information.arn,
      "${aws_s3_bucket.eaglerequest_synthesis_information.arn}/*"
    ]
  }
}

module "lambda_get_synthesis" {
  source        = "../modules/lambda"
  name          = "${var.project}-get-synthesis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.get_synthesis.json
  handler       = "src/controllers/${var.project}/consult/synthesis/get/index.handler"
  timeout       = 30

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    DYNAMO_TABLE_EAGLEREQUEST_SYNTHESIS = aws_dynamodb_table.synthesis.name
    S3_SYNTHESIS_INFORMATION            = aws_s3_bucket.eaglerequest_synthesis_information.bucket
  }
}
