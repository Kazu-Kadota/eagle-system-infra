variable "project" {
  default = "eaglerequest"
}

variable "route53_zone_map" {
  type = map(string)

  default = {
    sdx = "sdx.eaglesystem.com.br."
    prd = "eaglesystem.com.br."
  }
}

variable "domain_name_map" {
  type = map(string)

  default = {
    sdx = "request.api.sdx.eaglesystem.com.br"
    prd = "request.api.eaglesystem.com.br"
  }
}


locals {
  domain_name       = lookup(var.domain_name_map, terraform.workspace, "sdx")
  route53_zone_name = lookup(var.route53_zone_map, terraform.workspace, "sdx")
}
