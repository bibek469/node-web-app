

module "container-insights" {
  source       = "Young-ook/eks/aws//modules/container-insights"
  version      = "1.7.9"
  cluster_name = aws_eks_cluster.demo.name
  oidc         = zipmap(
    ["url", "arn"],
    [local.oidc["url"], local.oidc["arn"]]
  )
  tags         = { env = "demo" }
  depends_on = [
    aws_eks_node_group.demo,
  ]
}

locals {
  oidc = {
    arn = aws_iam_openid_connect_provider.cluster.arn
    url = replace(aws_iam_openid_connect_provider.cluster.url, "https://", "")
  }
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.demo.name
  depends_on = [null_resource.wait_for_cluster]
}

provider "helm" {
  # Configuration options
  kubernetes {
    host                   = aws_eks_cluster.demo.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster_auth.token
  }
}

resource "helm_release" "aws_alb_controller" {
  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.demo.name
  }

  depends_on = [
    aws_eks_node_group.demo,
  ]
}

resource "helm_release" "kube-metrics" {
  name       = "aws-kube-metrics"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community/kube-state-metrics"
  namespace  = "kube-metrics"

  depends_on = [
    aws_eks_node_group.demo,
  ]
}


resource "helm_release" "ping-pong" {
  name       = "ping-pong"

  chart      = "../../../../../helm/ping-pong"

  set {
    name  = "image.repository"
    value = var.image_repo
  }

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  depends_on = [
    helm_release.aws_alb_controller,
  ]
}
