#!/bin/bash

STACK_NAME="aws-ci-cd-nodejs-typescript-ecs-ci-cd"
TEMPLATE_FILE="infra/ci-cd-pipeline.yaml"

# Retrieve parameters from AWS Systems Manager Parameter Store
ECR_REGION=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-region" --query "Parameter.Value" --output text)
GITHUB_OAUTH_TOKEN=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-github-oauth-token" --with-decryption --query "Parameter.Value" --output text)
GITHUB_REPO_OWNER=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-github-repo-owner" --query "Parameter.Value" --output text)
GITHUB_BRANCH=$(aws ssm get-parameter --name "/ci-cd-nodejs-typescript-github-branch" --query "Parameter.Value" --output text)

if [[ -z "$ECR_REGION" || -z "$GITHUB_OAUTH_TOKEN" || -z "$GITHUB_REPO_OWNER" || -z "$GITHUB_BRANCH" ]]; then
    echo "Failed to retrieve one or more parameters from Systems Manager Parameter Store."
    exit 1
fi

CLUSTER_NAME="aws-ci-cd-nodejs-typescript-cluster"
SERVICE_NAME="aws-ci-cd-nodejs-typescript-service"
REPOSITORY_NAME="aws-ci-cd-nodejs-typescript"

PARAMETER_OVERRIDES="ClusterName=$CLUSTER_NAME RepositoryName=$REPOSITORY_NAME ServiceName=$SERVICE_NAME ECRRegion=$ECR_REGION GithubOauthToken=$GITHUB_OAUTH_TOKEN GithubRepoOwner=$GITHUB_REPO_OWNER GithubBranch=$GITHUB_BRANCH"

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
