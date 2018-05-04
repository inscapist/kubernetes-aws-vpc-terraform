variable "name" {
  default = "k8i.intelllex.se"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "azs" {
  default = ["ap-southeast-1a", "ap-southeast-1c", "ap-southeast-1d"]
  type    = "list"
}

variable "env" {
  default = "staging"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
