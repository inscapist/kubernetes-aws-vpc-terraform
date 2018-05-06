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

