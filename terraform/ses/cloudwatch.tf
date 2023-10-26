# resource "aws_cloudwatch_log_group" "login" {
#   name              = "/aws/lambda/${var.project}-login-${terraform.workspace}"
#   retention_in_days = "60"

#   tags = {
#     Service = var.project
#   }
# }