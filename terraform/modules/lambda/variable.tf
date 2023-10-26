variable "name" {
  type = string
}

variable "source_bucket" {
  type = string
}

variable "project" {
  type = string
}

variable "policy_json" {
  type = string
}

variable "environment_variables" {
  default = {
    SYSTEMEAGLE = "1"
  }
}

variable "timeout" {
  default = "5"
}

variable "memory_size" {
  default = "1024"
}

variable "handler" {
  default = ""
}

variable "subnet_ids" {
  default = []
}

variable "security_group_ids" {
  default = []
}

variable "layers" {
  default = []
}

variable "runtime" {
  default = "nodejs16.x"
}

variable "concurrent_executions" {
  default = "-1"
}
