data "aws_availability_zone" "az" {
  count = "${length(var.azs)}"
  name  = "${var.azs[count.index]}"
}

locals {
  az_suffix_num = {
    a = 0
    b = 1
    c = 2
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${cidrsubnet(var.public_sn_cidr, 2, local.az_suffix_num[data.aws_availability_zone.az.*.name_suffix[count.index]])}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(map("Name", "${var.name}-sn-public-${data.aws_availability_zone.az.*.name_suffix[count.index]}"), var.tags)}"
}
