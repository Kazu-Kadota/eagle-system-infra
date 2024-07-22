output "dynamodb_users_arn" {
  value = aws_dynamodb_table.users.arn
}

output "dynamodb_users_name" {
  value = aws_dynamodb_table.users.name
}

output "dynamodb_company_arn" {
  value = aws_dynamodb_table.company.arn
}

output "dynamodb_company_name" {
  value = aws_dynamodb_table.company.name
}

output "dynamodb_feature_flag_arn" {
  value = aws_dynamodb_table.feature_flag.arn
}

output "dynamodb_feature_flag_name" {
  value = aws_dynamodb_table.feature_flag.name
}
