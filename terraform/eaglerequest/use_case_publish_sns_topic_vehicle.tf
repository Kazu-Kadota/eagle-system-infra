data "aws_iam_policy_document" "use_case_publish_techmize_sns_topic_vehicle" {
  statement {
    actions = [
      "sns:Publish"
    ]

    resources = [aws_sns_topic.eaglerequest_third_party_workers.arn]
  }
}

locals {
  use_case_publish_techimze_sns_topic_vehicle_environment_variables = {
    SNS_EAGLEREQUEST_THIRD_PARTY_WORKERS_ARN = aws_sns_topic.eaglerequest_third_party_workers.arn
  }
}