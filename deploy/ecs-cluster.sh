#!/bin/bash
STACK_NAME="aws-ci-cd-nodejs-typescript-ecs-cluster"
REPOSITORY_NAME="aws-ci-cd-nodejs-typescript"
TEMPLATE_FILE="infra/ecs-cluster.yaml"
PARAMETER_OVERRIDES="RepositoryName=$REPOSITORY_NAME ImageTag=latest"

aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --parameter-overrides $PARAMETER_OVERRIDES \
    --capabilities CAPABILITY_NAMED_IAM
