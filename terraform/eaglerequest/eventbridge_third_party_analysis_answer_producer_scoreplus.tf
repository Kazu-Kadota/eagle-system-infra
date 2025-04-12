resource "aws_iam_role" "eaglerequest_scoreplus_events_bridge_role" {
  name = "${var.project}-scoreplus-events-bridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "eaglerequest_scoreplus_put_events_policy" {
  name = "${var.project}-put-events-to-scoreplus"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "events:PutEvents"
      Resource = "arn:aws:events:us-east-1:${data.aws_ssm_parameter.scoreplus_aws_account_id.value}:event-bus/${data.aws_ssm_parameter.scoreplus_event_bus_requestplus_third_party_analysis_answer_consumer.value}"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eaglerequest_scoreplus_put_events_attachment" {
  role       = aws_iam_role.eaglerequest_scoreplus_events_bridge_role.name
  policy_arn = aws_iam_policy.eaglerequest_scoreplus_put_events_policy.arn
}

resource "aws_cloudwatch_event_rule" "eaglerequest_forward_person_analysis_to_scoreplus" {
  name           = "${var.project}-forward-person_analysis-to-scoreplus-${terraform.workspace}"
  description    = "Forwards person analysis answer to Scoreplus"
  event_bus_name = aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.name

  event_pattern = jsonencode({
    "source" : ["eaglesystem"],
    "detail-type" : ["PersonPresignedURLGenerated"]
  })
}

resource "aws_cloudwatch_event_target" "eaglerequest_scoreplus_person_analysis_answer_consumer_event_bus_target" {
  rule           = aws_cloudwatch_event_rule.eaglerequest_forward_person_analysis_to_scoreplus.name
  event_bus_name = aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.name

  role_arn = aws_iam_role.eaglerequest_scoreplus_events_bridge_role.arn
  arn      = "arn:aws:events:us-east-1:${data.aws_ssm_parameter.scoreplus_aws_account_id.value}:event-bus/${data.aws_ssm_parameter.scoreplus_event_bus_requestplus_third_party_analysis_answer_consumer.value}"

  dead_letter_config {
    arn = aws_sqs_queue.eaglerequest_scoreplus_person_analysis_answer_producer_deadletter.arn
  }
}

resource "aws_cloudwatch_event_rule" "eaglerequest_forward_vehicle_analysis_to_scoreplus" {
  name           = "${var.project}-forward-vehicle_analysis-to-scoreplus-${terraform.workspace}"
  description    = "Forwards vehicle analysis answer to Scoreplus"
  event_bus_name = aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.name

  event_pattern = jsonencode({
    "source" : ["eaglesystem"],
    "detail-type" : ["VehiclePresignedURLGenerated"]
  })
}

resource "aws_cloudwatch_event_target" "eaglerequest_scoreplus_vehicle_analysis_answer_consumer_event_bus_target" {
  rule           = aws_cloudwatch_event_rule.eaglerequest_forward_vehicle_analysis_to_scoreplus.name
  event_bus_name = aws_cloudwatch_event_bus.eaglerequest_third_party_analysis_answer_producer.name

  role_arn = aws_iam_role.eaglerequest_scoreplus_events_bridge_role.arn
  arn      = "arn:aws:events:us-east-1:${data.aws_ssm_parameter.scoreplus_aws_account_id.value}:event-bus/${data.aws_ssm_parameter.scoreplus_event_bus_requestplus_third_party_analysis_answer_consumer.value}"

  dead_letter_config {
    arn = aws_sqs_queue.eaglerequest_scoreplus_vehicle_analysis_answer_producer_deadletter.arn
  }
}
