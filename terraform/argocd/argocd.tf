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
}

resource "kubernetes_manifest" "argocd_app" {
  depends_on = [helm_release.argocd]

  manifest = var.root_app_manifest
}
