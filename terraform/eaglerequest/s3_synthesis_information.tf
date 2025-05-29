resource "aws_s3_bucket" "eaglerequest_synthesis_information" {
  bucket = "${var.project}-synthesis-information-${terraform.workspace}"

  tags = {
    Name = var.project
  }
}