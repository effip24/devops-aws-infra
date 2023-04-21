resource "helm_release" "lb-controller" {
  depends_on = [
    module.eks, module.iam_lb_controller_role
  ]
  namespace        = "kube-system"
  create_namespace = true

  name       = "load-balancer-controller"
  repository = var.lb_controller_chart_repo
  chart      = var.lb_controller_chart_name
  version    = var.lb_controller_chart_version

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "deploymentAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_lb_controller_role.iam_role_arn
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_lb_controller_role.iam_role_arn
  }


}
