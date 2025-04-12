resource "aws_cloudwatch_event_bus" "eaglerequest_third_party_analysis_answer_producer" {
  name = "${var.project}-third-party-analysis-answer-producer-${terraform.workspace}"
}
