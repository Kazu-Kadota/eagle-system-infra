resource "aws_iam_role" "main" {
  name = "pipe-sqs-sfn-${var.project}-${var.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "pipes.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "pipe_policy" {
  name = "pipe-${var.project}-${var.name}-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect = "Allow",
        Resource = ["*"]
      },
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect = "Allow",
        Resource = var.sqs_arn
      },
      {
        Action = [
          "states:StartExecution"
        ],
        Effect = "Allow",
        Resource = "arn:aws:states:${var.aws_region}:${var.account_id}:stateMachine:${var.project}-${var.name}-${terraform.workspace}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "main_attachment" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.pipe_policy.arn
}