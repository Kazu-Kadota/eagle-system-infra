resource "aws_sqs_queue" "eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data" {
  name                        = "${var.project}-techmize-new-v1-answer-analysis-vehicle-basic-data-${terraform.workspace}"
  redrive_policy              = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data_deadletter.arn}\",\"maxReceiveCount\":4}"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue" "eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data_deadletter" {
  name                        = "${var.project}-techmize-new-v1-answer-analysis-vehicle-basic-data-deadletter-${terraform.workspace}"
  message_retention_seconds   = "1209600"
  fifo_queue                  = false
  content_based_deduplication = false

  tags = {
    Service = var.project
  }
}

resource "aws_sqs_queue_policy" "eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data" {
  queue_url = aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data.id
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
        "${aws_sqs_queue.eaglerequest_techmize_new_v1_answer_analysis_vehicle_basic_data.arn}"
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
