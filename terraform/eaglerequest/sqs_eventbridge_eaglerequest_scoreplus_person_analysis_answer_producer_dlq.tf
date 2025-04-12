resource "aws_sqs_queue" "eaglerequest_scoreplus_person_analysis_answer_producer_deadletter" {
  name                        = "${var.project}-scoreplus-person-analysis-answer-producer-deadletter-${terraform.workspace}"
  message_retention_seconds   = "1209600"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue_policy" "eaglerequest_scoreplus_person_analysis_answer_producer" {
  queue_url = aws_sqs_queue.eaglerequest_scoreplus_person_analysis_answer_producer_deadletter.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.eaglerequest_scoreplus_person_analysis_answer_producer_deadletter.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.arn}"
        }
      }
    }
  ]
}
EOF
}
