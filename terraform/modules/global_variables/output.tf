data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = "us-east-1"
}

output "aws_profile" {
  value = "eagle-back-${terraform.workspace}"
}

output "domain_name" {
  value = "api.systemeagle.com.br"
}

output "source_bucket" {
  value = "eagleinfra-src-${terraform.workspace}"
}

output "state_region" {
  value = "us-east-1"
}

output "state_bucket" {
  value = "eagleinfra-${terraform.workspace}"
}
