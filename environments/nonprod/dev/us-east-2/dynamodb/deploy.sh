#!/bin/bash

# config.sh
source "../../../../../config.sh"

# Create resources
echo "Started running terraform init"
dynamodbTable="$regionTwo-$dynamodbTable" s3Bucket="$regionTwo-$s3Bucket" regionName=$regionTwo toEncrypt=$toEncrypt terragrunt run-all init -migrate-state
echo "Finished running terraform init"
echo ""

echo "Finished running terraform plan"
dynamodbTable="$regionTwo-$dynamodbTable" s3Bucket="$regionTwo-$s3Bucket" regionName=$regionTwo toEncrypt=$toEncrypt terragrunt run-all plan -lock=false
echo "Finished running terraform plan"
echo ""

echo "Finished running terraform apply"
dynamodbTable="$regionTwo-$dynamodbTable" s3Bucket="$regionTwo-$s3Bucket" regionName=$regionTwo toEncrypt=$toEncrypt terragrunt run-all apply -lock=false --terragrunt-non-interactive
echo "Finished running terraform apply"
echo ""