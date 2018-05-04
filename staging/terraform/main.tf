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

module "public_subnets" {
  source         = "./public_subnets"
  name           = "${var.name}"
  vpc_id         = "${module.vpc.vpc_id}"
  azs            = "${var.azs}"
  public_sn_cidr = "${cidrsubnet(var.vpc_cidr, 2, 0)}"

  tags {
    Terraformed = "true"
  }
}

module "private_subnets" {
  source          = "./private_subnets"
  name            = "${var.name}"
  vpc_id          = "${module.vpc.vpc_id}"
  azs             = "${var.azs}"
  private_sn_cidr = "${cidrsubnet(var.vpc_cidr, 2, 2)}"

  tags {
    Terraformed = "true"
  }
}
