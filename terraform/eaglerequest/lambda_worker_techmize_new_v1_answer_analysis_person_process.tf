data "aws_iam_policy_document" "worker_techmize_new_v1_answer_analysis_person_process" {
  source_policy_documents = [
    data.aws_iam_policy_document.use_case_answer_person_analysis.json
  ]

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
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:SentMessage",
    ]

    resources = [
      aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_person_process.arn
    ]
  }

  statement {
    actions = [
      "states:SendTaskSuccess",
      "states:SendTaskFailure"
    ]

    resources = [
      aws_sfn_state_machine.sfn_techmize_new_v1_person_process.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem"
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

  statement {
    actions = [
      "events:PutEvents"
    ]

    resources = [
      aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.arn
    ]
  }
}

module "lambda_worker_techmize_new_v1_answer_analysis_person_process" {
  source        = "../modules/lambda"
  name          = "${var.project}-worker-answer-analysis-person-process"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.worker_techmize_new_v1_answer_analysis_person_process.json
  handler       = "src/worker/techmize/new-v1/answer-analysis/person/process/index.handler"
  timeout       = 60

  environment_variables = merge(
    local.use_case_answer_person_analysis_environment_variables,
    local.service_techmize_new_v1_get_response_environment_variables,
    {
      AUTH_ES256_PRIVATE_KEY                         = data.aws_ssm_parameter.auth_ecdsa_private_key.value
      S3_PERSON_ANALYSIS_ANSWER                      = aws_s3_bucket.eaglerequest_person_analysis_answer.bucket
      EVENTBRIDGE_ANALYSIS_ANSWER_PRODUCER_PUT_EVENT = aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.name
      REQUEST_INFORMATION_THIRD_PARTY                = terraform.workspace == "prd" ? true : true
    }
  )
}

# resource "aws_lambda_event_source_mapping" "lambda_worker_techmize_new_v1_answer_analysis_person_process" {
#   event_source_arn = aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_person_process.arn
#   function_name    = module.lambda_worker_techmize_new_v1_answer_analysis_person_process.arn
#   batch_size       = 1
# }
