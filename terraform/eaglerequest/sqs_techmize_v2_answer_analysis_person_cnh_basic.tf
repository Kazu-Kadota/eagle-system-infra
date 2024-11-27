resource "aws_sqs_queue" "eaglerequest_techmize_v2_answer_analysis_person_cnh_basic" {
  name                        = "${var.project}-techmize-v2-answer-analysis-person-cnh-basic-${terraform.workspace}"
  redrive_policy              = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_cnh_basic_deadletter.arn}\",\"maxReceiveCount\":4}"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue" "eaglerequest_techmize_v2_answer_analysis_person_cnh_basic_deadletter" {
  name                        = "${var.project}-techmize-v2-answer-analysis-person-cnh-basic-deadletter-${terraform.workspace}"
  message_retention_seconds   = "1209600"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue_policy" "eaglerequest_techmize_v2_answer_analysis_person_cnh_basic" {
  queue_url = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_cnh_basic.id
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
        "${aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_cnh_basic.arn}"
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
