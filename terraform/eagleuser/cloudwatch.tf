resource "aws_cloudwatch_log_group" "login" {
  name              = "/aws/lambda/${var.project}-login-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "api_gateway_main" {
  name              = "/aws/apigateway/${var.project}-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "register_user" {
  name              = "/aws/lambda/${var.project}-register-user-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "register_company" {
  name              = "/aws/lambda/${var.project}-register-company-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "list_companies" {
  name              = "/aws/lambda/${var.project}-list-companies-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "change_password" {
  name              = "/aws/lambda/${var.project}-change-password-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "recovery_password" {
  name              = "/aws/lambda/${var.project}-recovery-password-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "reset_password" {
  name              = "/aws/lambda/${var.project}-reset-password-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}
