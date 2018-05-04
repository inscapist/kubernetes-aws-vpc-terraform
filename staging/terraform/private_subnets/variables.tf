variable "name" {}

variable "vpc_id" {}

variable "azs" {
  type = "list"
}

variable "private_sn_cidr" {}

variable "tags" {
  type    = "map"
  default = {}
}
