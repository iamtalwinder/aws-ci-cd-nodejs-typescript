from diagrams import Diagram, Edge, Cluster
from diagrams.aws.compute import ECS, ECR
from diagrams.aws.general import User
from diagrams.aws.devtools import Codebuild, Codepipeline, Codedeploy
from diagrams.aws.management import Cloudformation
from diagrams.aws.storage import S3
from diagrams.onprem.vcs import Github
from diagrams.aws.network import VPC, InternetGateway, ELB

# Create a diagram
with Diagram("CI/CD Pipeline Architecture with CloudFormation", show=False, outformat=["png"], filename="ci-cd-architecture"):
    developer = User("Developer")
    user = User("User")
    github = Github("Github")
    cloudformation = Cloudformation("CloudFormation")
    cluster = Cluster("VPC")

    with cluster:
        codepipeline = Codepipeline("Codepipeline")
        codebuild = Codebuild("Codebuild")
        codedeploy = Codedeploy("Codebuild")
        ecs = ECS("ECS Fargate")
        elb = ELB("ALB")
        s3 = S3("S3")
        ecr = ECR("ECR")
        internet_gateway = InternetGateway("Internet Gateway")

        developer >> Edge(label="Push Code") >> github >> Edge(label="Push event") >> codepipeline >> codebuild >> codedeploy >> ecs >> elb
        elb >> ecs
        codebuild >> Edge(label="Artifacts") >> s3
        codebuild >> Edge(label="Images") >> ecr
        internet_gateway >> elb
        elb >> internet_gateway
        user >> internet_gateway
        internet_gateway >> user