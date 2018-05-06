#!/bin/sh

export NAME=k8i.intelllex.se
export KOPS_STATE_STORE=s3://intelllex-se-kops-state
export TERRAFORM_OUTPUT_LOCATION=../terraform/k8s

kops edit cluster ${NAME}

: '
There should be one Private type subnet and one Utility (public) type subnet in each availability zone. 
We need to modify this section by replacing each cidr with the corresponding existing subnet ID for that region. 
For the Private subnets, we also need to specify our NAT gateway ID in an egress key. 
Modify your subnets section to look like this:

```
subnets:
- egress: nat-0b2f7f77b15041515
  id: subnet-8db395d6
  name: ap-southeast-1a
  type: Private
  zone: ap-southeast-1a
- egress: nat-059d239e3f86f6da9
  id: subnet-fd6b41d0
  name: ap-southeast-1c
  type: Private
  zone: ap-southeast-1c
- egress: nat-0231eef9a93386f4a
  id: subnet-5fc6dd16
  name: ap-southeast-1d
  type: Private
  zone: ap-southeast-1d
- id: subnet-0ab39551
  name: utility-ap-southeast-1a
  type: Utility
  zone: ap-southeast-1a
- id: subnet-656b4148
  name: utility-ap-southeast-1c
  type: Utility
  zone: ap-southeast-1c
- id: subnet-cdc7dc84
  name: utility-ap-southeast-1d
  type: Utility
  zone: ap-southeast-1d
```
'

kops update cluster \
    --out ${TERRAFORM_OUTPUT_LOCATION} \
    --target terraform \
  ${NAME}


: '
# PRIVATE SUBNETS
module.private_subnets.aws_subnet.private.0:
  id = subnet-752a0b12
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1a
  cidr_block = 10.1.128.0/20
  map_public_ip_on_launch = false
  vpc_id = vpc-03c4a964
module.private_subnets.aws_subnet.private.1:
  id = subnet-97d187de
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1b
  cidr_block = 10.1.144.0/20
  map_public_ip_on_launch = false
  vpc_id = vpc-03c4a964
module.private_subnets.aws_subnet.private.2:
  id = subnet-7326c12a
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1c
  cidr_block = 10.1.160.0/20
  map_public_ip_on_launch = false
  vpc_id = vpc-03c4a964

# NAT gateways
module.public_subnets.aws_nat_gateway.nat_gw.0:
  id = nat-05b98b1a2240cb091
  allocation_id = eipalloc-d9e7e1e3
  network_interface_id = eni-321b216a
  private_ip = 10.1.5.224
  public_ip = 13.228.192.155
  subnet_id = subnet-c22b0aa5
  tags.% = 0
module.public_subnets.aws_nat_gateway.nat_gw.1:
  id = nat-00bc6662c61eb5f9d
  allocation_id = eipalloc-1fe2e425
  network_interface_id = eni-da0d43f0
  private_ip = 10.1.30.171
  public_ip = 52.77.133.190
  subnet_id = subnet-85d284cc
  tags.% = 0
module.public_subnets.aws_nat_gateway.nat_gw.2:
  id = nat-09e3ee48448116c35
  allocation_id = eipalloc-5ae5e360
  network_interface_id = eni-fe5c1ac4
  private_ip = 10.1.36.59
  public_ip = 13.228.247.95
  subnet_id = subnet-9925c2c0
  tags.% = 0

# PUBLIC SUBNETS
module.public_subnets.aws_subnet.public.0:
  id = subnet-c22b0aa5
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1a
  cidr_block = 10.1.0.0/20
  map_public_ip_on_launch = true
  tags.% = 2
  tags.Name = k8i.intelllex.se-sn-public-a
  tags.Terraformed = true
  vpc_id = vpc-03c4a964
module.public_subnets.aws_subnet.public.1:
  id = subnet-85d284cc
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1b
  cidr_block = 10.1.16.0/20
  map_public_ip_on_launch = true
  tags.% = 2
  tags.Name = k8i.intelllex.se-sn-public-b
  tags.Terraformed = true
  vpc_id = vpc-03c4a964
module.public_subnets.aws_subnet.public.2:
  id = subnet-9925c2c0
  assign_ipv6_address_on_creation = false
  availability_zone = ap-southeast-1c
  cidr_block = 10.1.32.0/20
  map_public_ip_on_launch = true
  tags.% = 2
  tags.Name = k8i.intelllex.se-sn-public-c
  tags.Terraformed = true
  vpc_id = vpc-03c4a964
'
