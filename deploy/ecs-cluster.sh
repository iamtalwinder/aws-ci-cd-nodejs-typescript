#!/bin/bash
VPC_ID="vpc-0078f4e17cd758c9e"
SUBNET_IDS="subnet-0744b99e04b1745d1,subnet-05d99bcaa2a3a88f3"
STACK_NAME="aws-ci-cd-nodejs-typescript-ecs-cluster"
REPOSITORY_NAME="aws-ci-cd-nodejs-typescript"
TEMPLATE_FILE="infra/ecs-cluster.yaml"
PARAMETER_OVERRIDES="RepositoryName=$REPOSITORY_NAME ImageTag=latest VpcId=$VPC_ID SubnetIds=$SUBNET_IDS"

aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --parameter-overrides $PARAMETER_OVERRIDES \
    --capabilities CAPABILITY_NAMED_IAM
