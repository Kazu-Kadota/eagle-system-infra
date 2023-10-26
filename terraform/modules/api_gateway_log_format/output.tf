output "json_rendered" {
  value = replace(data.template_file.log_format.rendered, var.regex, "")
}
