variable "name" {
  description = "The name of the pipe for naming IAM resources."
  type        = string
}

variable "lambda_arn" {
  description = "The ARN of the Lambda."
  type        = string
}

variable "project" {
  description = "The name of project."
  type        = string
}
