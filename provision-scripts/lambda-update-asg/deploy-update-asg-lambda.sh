#!/bin/bash

createRoleAndMapPolicies()
{
    echo "Creating IAM Role and attaching policies"

    aws iam create-role --role-name lambda-update-asg-role --assume-role-policy-document file://trust-policy.json

    aws iam attach-role-policy --role-name lambda-update-asg-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
    aws iam attach-role-policy --role-name lambda-update-asg-role --policy-arn arn:aws:iam::aws:policy/AutoScalingFullAccess

    #list the policies after they are attached
    aws iam list-attached-role-policies --role-name lambda-function

    export lambdaRoleARN=$(aws iam get-role --role-name lambda-update-asg-role --query 'Role.Arn' --output text)
    echo "lambda-update-asg-role Role ARN: $lambdaRoleARN"
}

createLambdaFunction()
{
    echo "Creating lambda function"

    aws lambda create-function \
            --function-name updateASGMaxSize \
            --runtime python3.13 \
            --zip-file fileb://function.zip \
            --handler lambda_function.lambda_handler \
            --role "${lambdaRoleARN}" \
            --no-paginate \
            --output json

    # Wait a few seconds to ensure the Lambda function has been created before creating the Function URL
    sleep 5

    aws lambda add-permission \
        --function-name updateASGMaxSize \
        --action lambda:InvokeFunctionUrl \
        --principal "*" \
        --function-url-auth-type "NONE" \
        --statement-id url

    aws lambda create-function-url-config \
        --function-name updateASGMaxSize \
        --auth-type NONE

    export updateASGMaxSizeURL=$(aws lambda get-function-url-config --function-name updateASGMaxSize --query 'FunctionUrl' --output text)

    echo "Function URL for $updateASGMaxSizeURL created with public access."
}

echo "Deploying lambda function to update autoscalinggroups"

createRoleAndMapPolicies
sleep 5
createLambdaFunction