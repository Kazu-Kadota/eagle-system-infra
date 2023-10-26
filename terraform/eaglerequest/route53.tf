data "aws_route53_zone" "eagle" {
  name         = local.route53_zone_name
  private_zone = false
}

resource "aws_api_gateway_domain_name" "api" {
  regional_certificate_arn = data.terraform_remote_state.acm.outputs.eagle_certificate_arn
  domain_name              = local.domain_name
  security_policy          = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "api" {
  name    = aws_api_gateway_domain_name.api.domain_name
  type    = "CNAME"
  zone_id = data.aws_route53_zone.eagle.zone_id
  ttl     = "300"
  records = [
    "${aws_api_gateway_domain_name.api.regional_domain_name}"
  ]
}

resource "aws_api_gateway_base_path_mapping" "api" {
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = terraform.workspace
  domain_name = local.domain_name

  depends_on = [aws_api_gateway_stage.main]
}
