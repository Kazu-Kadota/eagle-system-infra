data "aws_iam_policy_document" "worker_techmize_v2_answer_analysis_vehicle_antt" {
  source_policy_documents = [
    data.aws_iam_policy_document.use_case_answer_vehicle_analysis.json
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
      aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn
    ]
  }

  statement {
    actions = [
      "states:SendTaskSuccess",
      "states:SendTaskFailure"
    ]

    resources = [
      aws_sfn_state_machine.sfn_techmize_v2_vehicle_antt.arn
    ]
  }
}

module "lambda_worker_techmize_v2_answer_analysis_vehicle_antt" {
  source        = "../modules/lambda"
  name          = "${var.project}-worker-answer-analysis-vehicle-antt"
  source_bucket = module.global_variables.source_bucket
  project       = var.project
  policy_json   = data.aws_iam_policy_document.worker_techmize_v2_answer_analysis_vehicle_antt.json
  handler       = "src/worker/techmize/v2/answer-analysis/vehicle/antt/index.handler"
  timeout       = 20

  environment_variables = merge(
    local.use_case_answer_vehicle_analysis_environment_variables,
    local.service_techmize_v2_get_response_environment_variables,
    {
      AUTH_ES256_PRIVATE_KEY = data.aws_ssm_parameter.auth_ecdsa_private_key.value
    }
  )
}

# resource "aws_lambda_event_source_mapping" "lambda_worker_techmize_v2_answer_analysis_vehicle_antt" {
#   event_source_arn = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn
#   function_name    = module.lambda_worker_techmize_v2_answer_analysis_vehicle_antt.arn
#   batch_size       = 1
# }
