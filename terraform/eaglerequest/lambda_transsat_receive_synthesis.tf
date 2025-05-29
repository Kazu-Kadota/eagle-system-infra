data "aws_iam_policy_document" "transsat_receive_synthesis" {
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
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.eaglerequest_synthesis_information.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.synthesis.arn
    ]
  }
}

module "lambda_transsat_receive_synthesis" {
  source        = "../modules/lambda"
  name          = "${var.project}-transsat-receive-synthesis"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.transsat_receive_synthesis.json
  handler       = "src/controllers/${var.project}/transsat-receive-synthesis/index.handler"

  environment_variables = {
    AUTH_ES256_PRIVATE_KEY              = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    S3_SYNTHESIS_INFORMATION            = aws_s3_bucket.eaglerequest_synthesis_information.bucket
    DYNAMO_TABLE_EAGLEREQUEST_SYNTHESIS = aws_dynamodb_table.synthesis.name
  }
}
