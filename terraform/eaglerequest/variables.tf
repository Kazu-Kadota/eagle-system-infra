variable "project" {
  default = "eaglerequest"
}

variable "route53_zone_map" {
  type = map(string)

  default = {
    sdx = "sdx.systemeagle.com.br."
    prd = "systemeagle.com.br."
  }
}

variable "domain_name_map" {
  type = map(string)

  default = {
    sdx = "request.api.sdx.systemeagle.com.br"
    prd = "request.api.systemeagle.com.br"
  }
}

locals {
  domain_name       = lookup(var.domain_name_map, terraform.workspace, "sdx")
  route53_zone_name = lookup(var.route53_zone_map, terraform.workspace, "sdx")
}
