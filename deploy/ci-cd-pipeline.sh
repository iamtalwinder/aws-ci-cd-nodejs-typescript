#!/bin/bash
STACK_NAME="aws-ci-cd-nodejs-typescript-ecs-ci-cd"
TEMPLATE_FILE="infra/ci-cd-pipeline.yaml"

CLUSTER_NAME="aws-ci-cd-nodejs-typescript"
SERVICE_NAME="aws-ci-cd-nodejs-typescript-service"

PARAMETER_OVERRIDES="ClusterName=$CLUSTER_NAME ServiceName=$SERVICE_NAME"

aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --parameter-overrides $PARAMETER_OVERRIDES \
    --capabilities CAPABILITY_NAMED_IAM
