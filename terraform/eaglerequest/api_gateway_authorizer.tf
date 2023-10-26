resource "aws_api_gateway_authorizer" "auth" {
  name                             = "jwt"
  rest_api_id                      = aws_api_gateway_rest_api.main.id
  authorizer_uri                   = data.terraform_remote_state.eagleauth.outputs.lambda_auth_invoke_arn
  authorizer_credentials           = aws_iam_role.invocation_role.arn
  type                             = "REQUEST"
  authorizer_result_ttl_in_seconds = 0
}

resource "aws_iam_role" "invocation_role" {
  name = "${var.project}-api-gateway-auth-invocation"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "${var.project}-api-gateway-auth-invocation"
  role = aws_iam_role.invocation_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${data.terraform_remote_state.eagleauth.outputs.lambda_auth_arn}"
    }
  ]
}
EOF
}
