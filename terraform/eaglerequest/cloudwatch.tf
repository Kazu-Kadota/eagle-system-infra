resource "aws_cloudwatch_log_group" "api_gateway_main" {
  name              = "/aws/apigateway/${var.project}-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "analysis" {
  name              = "/aws/lambda/${var.project}-analysis-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "list_people" {
  name              = "/aws/lambda/${var.project}-list-people-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "list_vehicles" {
  name              = "/aws/lambda/${var.project}-list-vehicles-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "get_person" {
  name              = "/aws/lambda/${var.project}-get-person-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "get_vehicle" {
  name              = "/aws/lambda/${var.project}-get-vehicle-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "answer_analysis" {
  name              = "/aws/lambda/${var.project}-answer-analysis-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_query_analysis_by_document_plate" {
  name              = "/aws/lambda/${var.project}-query-analysis-by-document-plate-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_analysis_vehicle_plate_history" {
  name              = "/aws/lambda/${var.project}-analysis-vehicle-plate-history-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_analysis_vehicle_second_driver" {
  name              = "/aws/lambda/${var.project}-analysis-vehicle-second-driver-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_analysis_vehicle_antt" {
  name              = "/aws/lambda/${var.project}-analysis-vehicle-antt-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_analysis_vehicle_basic_data" {
  name              = "/aws/lambda/${var.project}-analysis-vehicle-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_person_basic_data" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-person-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_person_cnh" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-person-cnh-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_person_cnh_v2" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-person-cnh-v2-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_person_process" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-person-process-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_vehicle_antt" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-vehicle-antt-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_worker_techmize_v2_answer_analysis_vehicle_basic_data" {
  name              = "/aws/lambda/${var.project}-worker-answer-analysis-vehicle-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_person_basic_data" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-person-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_person_basic_data" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-person-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_person_cnh_basic" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-person-cnh-basic-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_person_cnh_basic" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-person-cnh-basic-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_person_cnh_status" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-person-cnh-status-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_person_cnh_status" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-person-cnh-status-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_person_process" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-person-process-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_person_process" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-person-process-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_vehicle_antt" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-vehicle-antt-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_vehicle_antt" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-vehicle-antt-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "sfn_techmize_v2_vehicle_basic_data" {
  name              = "/aws/vendedlogs/states/${var.project}-sfn-techmize-v2-vehicle-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "pipe_techmize_v2_vehicle_basic_data" {
  name              = "/aws/vendedlogs/pipes/${var.project}-pipe-techmize-v2-vehicle-basic-data-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}
