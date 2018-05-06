#!/bin/sh

aws s3api create-bucket \
--bucket intelllex-se-kops-state \
--region ap-southeast-1 \
--create-bucket-configuration LocationConstraint=ap-southeast-1

aws s3api put-bucket-versioning \
--bucket intelllex-se-kops-state  \
--versioning-configuration Status=Enabled