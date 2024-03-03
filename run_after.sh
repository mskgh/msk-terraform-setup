#!/bin/bash

#Define variables
s3Bucket="$1"
regionName="$2"
dynamodbTable="$3"

# Check if s3 bucket exists then delete
if aws s3api head-bucket --bucket "$s3Bucket" --region "$regionName" 2>/dev/null; then
    echo "Deleting S3 bucket $s3Bucket..."
    aws s3 rb "s3://$s3Bucket" --force
    echo "S3 bucket $s3Bucket deleted successfully."
else
    echo "S3 bucket $s3Bucket does not exist."
fi

# Check if dynamodb table exists then delete
if aws dynamodb describe-table --table-name "$dynamodbTable" --region "$regionName" > /dev/null 2>&1; then
    echo "Deleting DynamoDB table $dynamodbTable..."
    if aws dynamodb delete-table --table-name "$dynamodbTable" --region "$regionName" > /dev/null 2>&1; then
        echo "DynamoDB table $dynamodbTable deleted successfully."
    else
        echo "Failed to delete DynamoDB table $dynamodbTable."
    fi
else
    echo "DynamoDB table $dynamodbTable does not exist."
fi