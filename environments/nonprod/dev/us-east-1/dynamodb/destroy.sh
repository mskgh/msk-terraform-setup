#!/bin/bash

# config.sh
source "../../../../../config.sh"

echo "Started running terraform destroy"
dynamodbTable="$regionOne-$dynamodbTable" s3Bucket="$regionOne-$s3Bucket" regionName=$regionOne toEncrypt=$toEncrypt terragrunt run-all destroy --terragrunt-non-interactive -lock=false 
echo "Finished running terraform destroy"
echo ""