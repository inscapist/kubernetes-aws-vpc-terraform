variable "name" {
  default = "k8i.intelllex.se"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "azs" {
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  type    = "list"
}

variable "env" {
  default = "st"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
