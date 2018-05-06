#!/bin/sh

kops delete cluster --name k8i.intelllex.se --state s3://<KOPS_STATE_STORE> --yes
