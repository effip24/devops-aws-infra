resource "helm_release" "argocd" {
  name             = var.argocd_namespace
  namespace        = var.argocd_namespace
  repository       = var.argocd_repo
  chart            = var.argocd_chart
  version          = var.argocd_version
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }
}

resource "kubectl_manifest" "argocd_root_app_template" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: "${var.argocd_root_app_name}"
      namespace: ${var.argocd_namespace}
    spec:
      destination:
        namespace:  ${var.argocd_namespace}
        server: "https://kubernetes.default.svc"
      source:
        path:  ${var.argocd_root_app_path}
        repoURL: ${var.argocd_root_app_repo}
        targetRevision: ${var.argocd_root_app_targetRevision}
      project: ${var.argocd__root_app_project}
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
        syncOptions:
          - CreateNamespace=true
  YAML

  depends_on = [
    helm_release.argocd
  ]
}
