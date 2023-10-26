data "aws_route53_zone" "eagle" {
  name         = local.certificate
  private_zone = false
}

resource "aws_acm_certificate" "eagle" {
  domain_name               = local.certificate
  validation_method         = "DNS"
  subject_alternative_names = local.alternative_names
}

resource "aws_route53_record" "eagle" {
  for_each = {
    for dvo in aws_acm_certificate.eagle.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.eagle.zone_id
}
