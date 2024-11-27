resource "aws_sqs_queue" "eaglerequest_techmize_v2_answer_analysis_vehicle_antt" {
  name                        = "${var.project}-techmize-v2-answer-analysis-vehicle-antt-${terraform.workspace}"
  redrive_policy              = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt_deadletter.arn}\",\"maxReceiveCount\":4}"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue" "eaglerequest_techmize_v2_answer_analysis_vehicle_antt_deadletter" {
  name                        = "${var.project}-techmize-v2-answer-analysis-vehicle-antt-deadletter-${terraform.workspace}"
  message_retention_seconds   = "1209600"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue_policy" "eaglerequest_techmize_v2_answer_analysis_vehicle_antt" {
  queue_url = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.eaglerequest_third_party_workers.arn}"
        }
      }
    }
  ]
}
EOF
}
