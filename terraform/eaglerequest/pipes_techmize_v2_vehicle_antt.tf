module "pipes_sqs_step_function_role_techmize_v2_vehicle_antt" {
  source     = "../modules/pipes_sqs_step_function_role"
  name       = "techmize-v2-vehicle-antt"
  sqs_arn    = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn
  account_id = module.global_variables.account_id
  project    = var.project
  aws_region = module.global_variables.aws_region
}

module "sfn_role_techmize_v2_vehicle_antt" {
  source     = "../modules/step_function_role"
  name       = "techmize-v2-vehicle-antt"
  lambda_arn = module.lambda_worker_techmize_v2_answer_analysis_vehicle_antt.arn
  project    = var.project
}

resource "aws_sfn_state_machine" "sfn_techmize_v2_vehicle_antt" {
  name     = "${var.project}-techmize-v2-vehicle-antt-${terraform.workspace}"
  role_arn = module.sfn_role_techmize_v2_vehicle_antt.step_function_role_arn

  definition = jsonencode({
    Comment = "State machine to handle SQS job retries until techmize person basic data response is success.",
    StartAt = "Wait Before Checking",
    States = {
      "Wait Before Checking" = {
        Type    = "Wait",
        Seconds = 60,
        Next    = "Check Job Status"
      },
      "Check Job Status" = {
        Type       = "Task",
        Resource   = "arn:aws:states:::lambda:invoke.waitForTaskToken",
        Parameters = {
          FunctionName = "${module.lambda_worker_techmize_v2_answer_analysis_vehicle_antt.arn}",
          InvocationType = "Event"
          Payload = {
            "Records.$" = "$"
            "taskToken.$" = "$$.Task.Token"
          }
        },
        ResultPath = "$",
        Next       = "Job Completed?"
      },
      "Job Completed?" = {
        Type = "Choice",
        Choices = [
          {
            Variable     = "$[0].message",
            StringEquals = "A consulta está sendo processada. Tente novamente mais tarde!",
            Next         = "Wait Before Checking"
          }
        ],
        Default = "Success"
      },
      "Success" = {
        Type = "Succeed"
      }
    }
  })

  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.sfn_techmize_v2_vehicle_antt.arn}:*"
    include_execution_data = true
    level                  = "ERROR"
  }
}

resource "aws_pipes_pipe" "techmize_v2_vehicle_antt" {
  name     = "${var.project}-techmize-v2-vehicle-antt-${terraform.workspace}"
  role_arn = module.pipes_sqs_step_function_role_techmize_v2_vehicle_antt.role_arn
  source   = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn

  log_configuration {
    level = "ERROR"
    cloudwatch_logs_log_destination {
      log_group_arn = aws_cloudwatch_log_group.pipe_techmize_v2_vehicle_antt.arn
    }
  }

  source_parameters {
    sqs_queue_parameters {
      batch_size = 1
    }
  }

  target = aws_sfn_state_machine.sfn_techmize_v2_vehicle_antt.arn

  target_parameters {
    step_function_state_machine_parameters {
      invocation_type = "FIRE_AND_FORGET"
    }
  }
}