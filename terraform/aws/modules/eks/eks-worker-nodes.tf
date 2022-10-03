#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_eks_node_group" "demo" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = var.node-group-name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = aws_subnet.demo[*].id
  instance_types  = var.instance_types

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    kubernetes_config_map.aws_auth,
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]

}

resource "null_resource" "delete_ingress" {
  triggers = {
    cluster_delete_name = aws_eks_cluster.demo.name
    cluster_region = var.aws_region
  }
  depends_on = [
    helm_release.aws_alb_controller,
    aws_security_group.demo-cluster,
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.cluster-AmazonVPCFullAccess,
    aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-AmazonVPCFullAccess,
    aws_iam_instance_profile.node,
    aws_iam_role_policy_attachment.node-AWSLoadBalancerControllerIAMPolicy,
    aws_iam_role_policy_attachment.cluster-AWSVisualEditorPolicy,
    aws_iam_openid_connect_provider.cluster,
    aws_iam_role.cluster,
    aws_iam_role.node,
    aws_iam_policy.AWSLoadBalancerControllerIAMPolicy,
    aws_route_table_association.demo,
    module.container-insights,
    aws_route_table.demo,
    aws_security_group_rule.demo-cluster-ingress-workstation-https
    ]

}