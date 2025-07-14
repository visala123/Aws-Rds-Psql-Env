variable "aws_region" {}

variable "allocated_storage" {
  type = number
}

variable "db_name" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "username" {}

variable "password" {
  sensitive = true
}

variable "parameter_group_name" {}

variable "skip_final_snapshot" {
  type = bool
}
variable "tags" {
  type = map(string)
}
