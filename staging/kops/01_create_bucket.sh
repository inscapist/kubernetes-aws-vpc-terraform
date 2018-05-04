#!/bin/sh

aws s3api create-bucket \
--bucket kops-intelllexse-state \
--region ap-southeast-1 \
--create-bucket-configuration LocationConstraint=ap-southeast-1

aws s3api put-bucket-versioning \
--bucket kops-intelllexse-state  \
--versioning-configuration Status=Enabled