resource "aws_s3_bucket" "eaglerequest_vehicle_analysis_answer" {
  bucket = "${var.project}-vehicle-analysis-answer-${terraform.workspace}"

  tags = {
    Name = var.project
  }
}