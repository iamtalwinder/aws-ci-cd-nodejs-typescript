#!/bin/bash
REPOSITORY_NAME="aws-ci-cd-nodejs-typescript"
TEMPLATE_FILE="infra/ecr-repository.yaml"
PARAMETER_OVERRIDES="RepositoryName=$REPOSITORY_NAME"

aws cloudformation deploy \
    --stack-name $REPOSITORY_NAME \
    --template-file $TEMPLATE_FILE \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides $PARAMETER_OVERRIDES
