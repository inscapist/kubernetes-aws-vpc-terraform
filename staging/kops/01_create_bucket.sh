#!/bin/sh

aws s3api create-bucket \
--bucket <KOPS_STATE_STORE> \
--region ap-southeast-1 \
--create-bucket-configuration LocationConstraint=ap-southeast-1

aws s3api put-bucket-versioning \
--bucket <KOPS_STATE_STORE>  \
--versioning-configuration Status=Enabled
