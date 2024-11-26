resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_vehicle_basic_data" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_basic_data.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "vehicle": {
      "basic-data": {
        "cpf": [{"exists": true}],
        "licenseplate": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}

resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_antt" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_vehicle_antt.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "vehicle": {
      "antt": {
        "cpf": [{"exists": true}],
        "licenseplate": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}
