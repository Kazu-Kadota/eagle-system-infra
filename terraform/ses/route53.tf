data "aws_route53_zone" "eaglesystem" {
  name         = local.route53_zone_name
  private_zone = false
}