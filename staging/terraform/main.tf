terraform {
  backend "s3" {
    bucket = "intelllex-se-tfstate"
    key    = "k8i.tfstate"
    region = "ap-southeast-1"
  }
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

module "public-route-table" {
  source              = "./public-route-table"
  name                = "${var.name}"
  vpc_id              = "${module.vpc.vpc_id}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  public_subnet_ids   = "${module.public_subnets.public_subnet_ids}"

  tags {
    Terraformed = "true"
  }
}

module "private-route-table" {
  source             = "./private-route-table"
  name               = "${var.name}"
  vpc_id             = "${module.vpc.vpc_id}"
  private_subnet_ids = "${module.private_subnets.private_subnet_ids}"
  nat_gateway_ids    = "${module.public_subnets.nat_gateway_ids}"
  azs                = "${var.azs}"

  tags {
    Terraformed = "true"
  }
}

module "kubernetes-by-kops" {
  source = "./k8s"
}
