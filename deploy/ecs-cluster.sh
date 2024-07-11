#!/bin/bash
STACK_NAME="aws-ci-cd-nodejs-typescript-ecs-cluster"
REPOSITORY_NAME="aws-ci-cd-nodejs-typescript"
TEMPLATE_FILE="infra/ecs-cluster.yaml"

# Retrieve VPC ID and Subnet IDs from AWS Systems Manager Parameter Store
VPC_ID=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-vpc-id" --query "Parameter.Value" --output text)
SUBNET_IDS=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-subnet-ids" --query "Parameter.Value" --output text)

if [[ -z "$VPC_ID" || -z "$SUBNET_IDS" ]]; then
    echo "Failed to retrieve VPC ID or Subnet IDs from Systems Manager Parameter Store."
    exit 1
fi

# Convert Subnet IDs to a comma-separated string without brackets
SUBNET_IDS=$(echo $SUBNET_IDS | tr -d '[]' | tr -d '"' | tr ',' '\n' | awk '{$1=$1};1' | paste -sd "," -)

echo "Formatted Subnet IDs: $SUBNET_IDS"

PARAMETER_OVERRIDES="RepositoryName=$REPOSITORY_NAME ImageTag=latest VpcId=$VPC_ID SubnetIds=$SUBNET_IDS"

aws cloudformation deploy \
    --template-file "$TEMPLATE_FILE" \
    --stack-name "$STACK_NAME" \
    --parameter-overrides $PARAMETER_OVERRIDES \
    --capabilities CAPABILITY_NAMED_IAM

if [[ $? -ne 0 ]]; then
    echo "CloudFormation stack deployment failed."
    exit 1
fi

echo "CloudFormation stack deployed successfully."
