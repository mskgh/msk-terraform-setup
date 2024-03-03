#!/bin/bash

# config.sh
source config.sh

#Define variables
s3Bucket="$1"
regionName="$2"
dynamodbTable="$3"

if [ $regionName == $regionOne ];
then

    # Check if S3 bucket exists
    if aws s3api head-bucket --bucket "$s3Bucket" 2>/dev/null; then
        echo "S3 bucket $s3Bucket already exists."
    else
        echo "Creating S3 bucket $s3Bucket..."
        aws s3api create-bucket \
        --bucket "$s3Bucket" \
        --region "$regionName"
        echo "S3 bucket $s3Bucket created successfully."
    fi
else

    # Check if S3 bucket exists
    if aws s3api head-bucket --bucket "$s3Bucket" --region "$regionName" 2>/dev/null; then
        echo "S3 bucket $s3Bucket already exists."
    else
        echo "Creating S3 bucket $s3Bucket..."
        aws s3api create-bucket \
        --bucket "$s3Bucket" \
        --region "$regionName" \
        --create-bucket-configuration LocationConstraint="$regionName"
        echo "S3 bucket $s3Bucket created successfully."
    fi
fi


# Check if DynamoDB table exists
if aws dynamodb describe-table --table-name "$dynamodbTable" --region "$regionName" > /dev/null 2>&1; then
    echo "DynamoDB table $dynamodbTable already exists."
else
    echo "Creating DynamoDB table $dynamodbTable..."
    if aws dynamodb create-table --table-name "$dynamodbTable" \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
        --region "$regionName" > /dev/null 2>&1; then
        echo "DynamoDB table $dynamodbTable created successfully."
    else
        echo "Failed to create DynamoDB table $dynamodbTable."
    fi
fi
