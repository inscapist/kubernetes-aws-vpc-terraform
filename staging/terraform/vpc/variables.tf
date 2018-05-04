variable "name" {}

variable "env" {}

variable "vpc_cidr" {}

variable "tags" {
  type    = "map"
  default = {}
}
