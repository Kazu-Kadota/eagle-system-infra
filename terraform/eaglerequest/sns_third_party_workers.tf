resource "aws_sns_topic" "eaglerequest_third_party_workers" {
  name                             = "${var.project}-third-party-workers"
  sqs_success_feedback_role_arn    = aws_iam_role.main.arn
  sqs_failure_feedback_role_arn    = aws_iam_role.main.arn
  sqs_success_feedback_sample_rate = 100
}
