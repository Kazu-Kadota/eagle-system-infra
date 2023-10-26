resource "aws_cloudwatch_log_group" "auth" {
  name              = "/aws/lambda/${var.project}-auth-${terraform.workspace}"
  retention_in_days = "365"

  tags = {
    Service = var.project
  }
}
