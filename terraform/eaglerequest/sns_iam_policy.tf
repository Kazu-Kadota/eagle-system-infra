data "aws_iam_policy_document" "role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "main" {
  name               = "${var.project}-sns-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.role.json
}
