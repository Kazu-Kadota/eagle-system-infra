resource "aws_s3_bucket" "eaglerequest_person_analysis_answer" {
  bucket = "${var.project}-person-analysis-answer-${terraform.workspace}"

  tags = {
    Name = var.project
  }
}