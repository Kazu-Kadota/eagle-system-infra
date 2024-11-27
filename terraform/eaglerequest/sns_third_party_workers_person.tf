resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_person_basic_data" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_basic_data.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "person": {
      "basic-data": {
        "cpf": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}

resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_person_cnh_basic" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_cnh_basic.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "person": {
      "cnh-basic": {
        "cpf": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}

resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_person_cnh_status" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_cnh_status.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "person": {
      "cnh-status": {
        "cpf": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}

resource "aws_sns_topic_subscription" "eaglerequest_techmize_v2_answer_analysis_person_process" {
  topic_arn            = aws_sns_topic.eaglerequest_third_party_workers.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.eaglerequest_techmize_v2_answer_analysis_person_process.arn
  raw_message_delivery = true
  filter_policy_scope  = "MessageBody"
  filter_policy        = <<EOF
  {
    "person": {
      "process": {
        "cpf": [{"exists": true}],
        "type_request": [{"exists": true}],
        "protocol": [{"exists": true}]
      }
    }
  }
EOF
}
