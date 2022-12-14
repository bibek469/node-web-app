variable "aws_region" {
  default = "us-east-2"
  type    = string
}

variable "cluster-name" {
  default = "ping-pong-demo"
  type    = string
}

variable "node-group-name" {
  default = "ping-pong-cdn-node-group"
  type    = string
}

variable "role-eks-demo-node" {
  default = "ping-pong-cdn-eks-demo-node"
  type    = string
}

variable "vpc-eks-tag-name" {
  default = "ping-pong-cdn-eks-demo-tag-name"
  type    = string
}

variable "cluster_ipv4_cidr" {
  description = "The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR."
  default = "10.0.0.0/16"
  type    = string
}



variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "wait_for_cluster_cmd" {
  description = "Custom local-exec command to execute for determining if the eks cluster is healthy. Cluster endpoint will be available as an environment variable called ENDPOINT"
  type        = string
  default     = " apk add curl; for i in `seq 1 60`; do curl -k $ENDPOINT/healthz >/dev/null && exit 0 || true; sleep 5; done; echo TIMEOUT && exit 1"
}

variable "wait_for_cluster_interpreter" {
  description = "Custom local-exec command line interpreter for the command to determining if the eks cluster is healthy."
  type        = list(string)
  default     = ["/bin/sh", "-c"]
}

variable "instance_types" {
  description = "List of instance types associated with the EKS Node Group. Defaults to [t3.medium]. Terraform will only perform drift detection if a configuration value is provided."
  default = ["t3-medium"]
}

variable "image_repo" {
  description = "Image of the App to deploy"
  default = "bibek469/node-web-app"
}

variable "image_tag" {
  description = "Tag of the image of the App to deploy"
  default = "v2"
}