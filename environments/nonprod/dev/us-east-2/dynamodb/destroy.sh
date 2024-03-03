#!/bin/bash

# config.sh
source "../../../../../config.sh"

echo "Started running terraform destroy"
dynamodbTable="$regionTwo-$dynamodbTable" s3Bucket="$regionTwo-$s3Bucket" regionName=$regionTwo toEncrypt=$toEncrypt terragrunt run-all destroy --terragrunt-non-interactive -lock=false 
echo "Finished running terraform destroy"
echo ""