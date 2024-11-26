variable "name" {
  description = "The name of the pipe for naming IAM resources."
  type        = string
}

variable "sqs_arn" {
  description = "The ARN of the SQS queue."
  type        = string
}

variable "account_id" {
  description = "The account ID."
  type        = string
}

variable "project" {
  description = "The name of project."
  type        = string
}

variable "aws_region" {
  description = "The name of project."
  type        = string
}
