variable "regex" {
  # terraform não aceita \s na ver 11.13
  default = "/(\r\n)+|\r+|\n+|\t+| +/"
}

data "template_file" "log_format" {
  template = file("${path.module}/log_format.json")
  vars = {
    domain_name = var.domain_name
    project     = var.project
  }
}
