provider "aws" {
  region  = "ap-southeast-1"
  version = "~> 1.17"
}

module "vpc" {
  source   = "./vpc"
  name     = "${var.name}"
  vpc_cidr = "${var.vpc_cidr}"

  tags {
    Terraformed = "true"
  }
}

locals {
  public_sn_cidr  = "${cidrsubnet(var.vpc_cidr, 2, 0)}"
  private_sn_cidr = "${cidrsubnet(var.vpc_cidr, 2, 2)}"
}
