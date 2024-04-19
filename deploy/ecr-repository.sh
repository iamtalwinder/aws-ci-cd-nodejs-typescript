#!/bin/bash

STACK_NAME="aws-ci-cd-nodejs-typescript"
TEMPLATE_FILE="infra/ecr-repository.yaml"
PARAMETER_OVERRIDES="RepositoryName=aws-ci-cd-nodejs-typescript"

# Deploy the CloudFormation stack
aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-file $TEMPLATE_FILE \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides $PARAMETER_OVERRIDES
