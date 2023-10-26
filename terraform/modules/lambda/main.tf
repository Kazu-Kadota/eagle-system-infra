module "lambda_role" {
  source      = "../lambda_role"
  name        = "${var.name}-${terraform.workspace}"
  policy_json = var.policy_json
}

resource "aws_lambda_function" "main" {
  function_name                  = "${var.name}-${terraform.workspace}"
  role                           = module.lambda_role.arn
  handler                        = var.handler == "" ? "src/${var.name}.handler" : var.handler
  runtime                        = var.runtime
  s3_bucket                      = var.source_bucket
  s3_key                         = "deploy/${var.name}-${terraform.workspace}/latest.zip"
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  layers                         = var.layers
  architectures                  = ["arm64"]
  reserved_concurrent_executions = terraform.workspace == "prd" ? var.concurrent_executions : "-1"

  tags = {
    Service = var.project
  }

  environment {
    variables = merge(var.environment_variables, {
      APPLICATION : var.project,
      SERVICE : var.name,
      STAGE : terraform.workspace,
      NODE_OPTIONS : "--enable-source-maps"
    })
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}
