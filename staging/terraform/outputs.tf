output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  value = "${module.public_subnets.public_subnet_ids}"
}

output "private_subnets" {
  value = "${module.private_subnets.private_subnet_ids}"
}

output "nat_gateway_ids" {
  value = "${module.public_subnets.nat_gateway_ids}"
}
