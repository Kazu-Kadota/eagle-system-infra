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

resource "aws_cloudwatch_log_group" "feature_flag_update" {
  name              = "/aws/lambda/${var.project}-feature-flag-update-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "operator_companies_access_register_companies" {
  name              = "/aws/lambda/${var.project}-operator-companies-access-register-companies-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "operator_companies_access_delete_companies" {
  name              = "/aws/lambda/${var.project}-operator-companies-access-delete-companies-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "operator_companies_access_delete_users" {
  name              = "/aws/lambda/${var.project}-operator-companies-access-delete-users-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "list_users" {
  name              = "/aws/lambda/${var.project}-list-users-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_list" {
  name              = "/aws/lambda/${var.project}-feature-flag-list-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_delete" {
  name              = "/aws/lambda/${var.project}-feature-flag-delete-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_bff_set" {
  name              = "/aws/lambda/${var.project}-feature-flag-bff-set-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_bff_update" {
  name              = "/aws/lambda/${var.project}-feature-flag-bff-update-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_bff_list" {
  name              = "/aws/lambda/${var.project}-feature-flag-bff-list-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "feature_flag_bff_delete" {
  name              = "/aws/lambda/${var.project}-feature-flag-bff-delete-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_operator_companies_access_get" {
  name              = "/aws/lambda/${var.project}-operator-companies-access-get-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}

resource "aws_cloudwatch_log_group" "lambda_operator_companies_access_list" {
  name              = "/aws/lambda/${var.project}-operator-companies-access-list-${terraform.workspace}"
  retention_in_days = "60"

  tags = {
    Service = var.project
  }
}
