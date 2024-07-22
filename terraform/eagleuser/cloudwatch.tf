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

resource "aws_cloudwatch_log_group" "my_company" {
  name              = "/aws/lambda/${var.project}-my-company-${terraform.workspace}"
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

resource "aws_cloudwatch_log_group" "feature_flag_set" {
  name              = "/aws/lambda/${var.project}-feature-flag-set-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_modify_allowance" {
  name              = "/aws/lambda/${var.project}-feature-flag-modify-allowance-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}
