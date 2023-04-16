provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "argocd" {
  name             = var.namespace
  namespace        = var.namespace
  repository       = var.argocd_repo
  chart            = var.argocd_chart
  version          = var.argocd_version
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }
  values = var.argocd_values
}