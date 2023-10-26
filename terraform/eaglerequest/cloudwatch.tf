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
