locals {
    env = "prod"
}

module "ping-pong-cluster" {
    source = "../../modules/eks"

    aws_region = "us-east-2"
    cluster-name = "ping-pong-${local.env}"
    node-group-name = "ping-pong-${local.env}-node-group"
    role-eks-demo-node = "ping-pong-eks-${local.env}-node"
    vpc-eks-tag-name = "ping-pong-cdn-eks-${local.env}-tag-name"
    cluster_ipv4_cidr = "10.5.0.0/16"
    instance_types = ["t3.medium"]
    image_repo = "bibek469/node-web-app"
    image_tag = "v2"
}

