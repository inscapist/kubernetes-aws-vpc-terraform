#!/bin/bash

# REFER:
# https://github.com/kubernetes/kops/blob/master/docs/cli/kops_create_cluster.md

export NAME=k8i.intelllex.se
export KOPS_STATE_STORE=s3://<KOPS_STATE_STORE>
export ZONES=ap-southeast-1a,ap-southeast-1b,ap-southeast-1c
export DNS_ZONE_PRIVATE_ID=ZXXXXXXXY
export VPC_ID=vpc-xxxxxxx # terraform output
export PUB_KEY_LOCATION=~/.ssh/mykey.pub
export TERRAFORM_OUTPUT_LOCATION=../terraform/k8s

kops create cluster \
    --node-count 3 \
    --node-size t2.medium \
    --master-size t2.medium \
    --zones ${ZONES} \
    --master-zones ${ZONES} \
    --vpc=${VPC_ID} \
    --dns private \
    --dns-zone ${DNS_ZONE_PRIVATE_ID} \
    --topology private \
    --networking weave \
    --bastion \
    --ssh-public-key ${PUB_KEY_LOCATION} \
    --out ${TERRAFORM_OUTPUT_LOCATION} \
    --target terraform \
    ${NAME}
