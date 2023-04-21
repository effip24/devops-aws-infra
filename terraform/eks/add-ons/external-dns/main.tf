resource "helm_release" "external-dns" {
  depends_on = [
    module.iam_external_dns_role
  ]
  namespace        = "kube-system"
  create_namespace = true

  name       = "external-dns"
  repository = var.external_dns_chart_repo
  chart      = var.external_dns_chart_name
  version    = var.external_dns_chart_version

  set {
    name  = "provider"
    value = var.external_dns_provider
  }

  set {
    name  = "aws.region"
    value = var.external_dns_aws_region
  }

  set {
    name  = "deploymentAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_external_dns_role.iam_role_arn
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_external_dns_role.iam_role_arn
  }

  set {
    name  = "source"
    value = var.external_dns_source
  }

  set {
    name  = "domain-filter"
    value = var.external_dns_domain_filter
  }

  set {
    name  = "aws-zone-type"
    value = var.is_domain_private_zone ? "private" : "public"
  }

  set {
    name  = "policy"
    value = "upsert-only"
  }

  set {
    name  = "registry"
    value = "txt"
  }

  set {
    name  = "txt-owner-id"
    value = var.aws_route53_zone_id
  }
}
