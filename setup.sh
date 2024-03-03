#!/bin/bash

# config.sh
source "config.sh"

if [[ $1 == "deploy" ]]; 
then

    # Setup Region 1
    ./run_before.sh "$regionOne-$s3Bucket" $regionOne "$regionOne-$dynamodbTable"

    # Setup Region 2
    ./run_before.sh "$regionTwo-$s3Bucket" $regionTwo "$regionTwo-$dynamodbTable"

elif [[ $1 == "destroy" ]];
then

    echo ""
    read -p "Enter yes to confirm (yes/no): " response
    if [[ $response == "yes" ]];
    then

        # Destroy region 1
        ./run_after.sh "$regionOne-$s3Bucket" $regionOne "$regionOne-$dynamodbTable"

        # Destroy region 2
        ./run_after.sh "$regionTwo-$s3Bucket" $regionTwo "$regionTwo-$dynamodbTable"
    
    else
        echo ""
        echo "Failed to destroy Dynamodb Table: $regionOne-$dynamodbTable, $regionTwo-$dynamodbTable and s3 Bucket: $regionTwo-$s3Bucket"
        echo ""
    fi
    
else
    echo "Unknown operator"
fi