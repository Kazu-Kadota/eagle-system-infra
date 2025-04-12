module "pipes_sqs_step_function_role_techmize_new_v1_person_basic_data" {
  source     = "../modules/pipes_sqs_step_function_role"
  name       = "techmize-new-v1-person-basic-data"
  sqs_arn    = aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_person_basic_data.arn
  account_id = module.global_variables.account_id
  project    = var.project
  aws_region = module.global_variables.aws_region
}

module "sfn_role_techmize_new_v1_person_basic_data" {
  source     = "../modules/step_function_role"
  name       = "techmize-new-v1-person-basic-data"
  lambda_arn = module.lambda_worker_techmize_new_v1_answer_analysis_person_basic_data.arn
  project    = var.project
}

resource "aws_sfn_state_machine" "sfn_techmize_new_v1_person_basic_data" {
  name     = "techmize-new-v1-person-basic-data-${terraform.workspace}"
  role_arn = module.sfn_role_techmize_new_v1_person_basic_data.step_function_role_arn

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
        Type     = "Task",
        Resource = "arn:aws:states:::lambda:invoke.waitForTaskToken",
        Parameters = {
          FunctionName   = "${module.lambda_worker_techmize_new_v1_answer_analysis_person_basic_data.arn}",
          InvocationType = "Event"
          Payload = {
            "Records.$"   = "$"
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
    log_destination        = "${aws_cloudwatch_log_group.sfn_techmize_new_v1_person_basic_data.arn}:*"
    include_execution_data = true
    level                  = "ERROR"
  }
}

resource "aws_pipes_pipe" "techmize_new_v1_person_basic_data" {
  name     = "techmize-new-v1-person-basic-data-${terraform.workspace}"
  role_arn = module.pipes_sqs_step_function_role_techmize_new_v1_person_basic_data.role_arn
  source   = aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_person_basic_data.arn

  log_configuration {
    level = "ERROR"
    cloudwatch_logs_log_destination {
      log_group_arn = aws_cloudwatch_log_group.pipe_techmize_new_v1_person_basic_data.arn
    }
  }

  source_parameters {
    sqs_queue_parameters {
      batch_size = 1
    }
  }

  target = aws_sfn_state_machine.sfn_techmize_new_v1_person_basic_data.arn

  target_parameters {
    step_function_state_machine_parameters {
      invocation_type = "FIRE_AND_FORGET"
    }
  }
}