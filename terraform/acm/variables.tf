variable "certificate" {
  type = map(any)

  default = {
    sdx    = "sdx.systemeagle.com.br"
    prd    = "systemeagle.com.br"
  }
}

variable "alternative_names" {
  default = {
    sdx = [
      "*.sdx.systemeagle.com.br",
      "*.api.sdx.systemeagle.com.br",
    ]
    prd = [
      "*.systemeagle.com.br",
      "*.api.systemeagle.com.br",
    ]
  }
}

locals {
  certificate       = lookup(var.certificate, terraform.workspace, "sdx")
  alternative_names = lookup(var.alternative_names, terraform.workspace, "sdx")
}
