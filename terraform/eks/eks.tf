module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "19.5.1"
  cluster_name                    = var.eks_cluster_name
  cluster_version                 = var.eks_cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.vpc_private_subnets
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults
  eks_managed_node_groups         = var.eks_managed_node_groups
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap
  enable_irsa                     = true

  aws_auth_roles = [
    {
      rolearn  = module.karpenter[0].karpenter_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
    },
    {
      groups   = ["system:masters"]
      rolearn  = aws_iam_role.eks_admin_role.arn
      username = "eks-admin"
    },
    {
      groups   = ["sadnbox:developer"]
      rolearn  = aws_iam_role.eks_developer_role.arn
      username = "eks-developer"
    },
  ]

  node_security_group_tags = var.node_security_group_tags

  tags = var.tags
}


module "karpenter" {
  source                                     = "./add-ons/karpenter"
  eks_cluster_name                           = module.eks.cluster_name
  count                                      = var.create_karpenter ? 1 : 0
  oidc_provider_arn                          = module.eks.oidc_provider_arn
  eks_cluster_endpoint                       = module.eks.cluster_endpoint
  aws_ecrpublic_authorization_token_username = data.aws_ecrpublic_authorization_token.token.user_name
  aws_ecrpublic_authorization_token_password = data.aws_ecrpublic_authorization_token.token.password
  karpenter_chart_name                       = var.karpenter_chart_name
  karpenter_chart_repo                       = var.karpenter_chart_repo
  karpenter_chart_version                    = var.karpenter_chart_version
  karpenter_tags                             = var.tags

}

module "external-dns" {
  source                     = "./add-ons/external-dns"
  count                      = var.create_external_dns ? 1 : 0
  eks_cluster_name           = module.eks.cluster_name
  oidc_provider_arn          = module.eks.oidc_provider_arn
  external_dns_chart_repo    = var.external_dns_chart_repo
  external_dns_chart_name    = var.external_dns_chart_name
  external_dns_chart_version = var.external_dns_chart_version
  external_dns_provider      = var.external_dns_provider
  external_dns_aws_region    = var.external_dns_aws_region
  external_dns_source        = var.external_dns_source
  external_dns_domain_filter = var.external_dns_domain_filter
  is_domain_private_zone     = var.is_domain_private_zone
  aws_route53_zone_id        = data.aws_route53_zone.domain.zone_id
}

module "lb-controller" {
  source                      = "./add-ons/lb-controller"
  count                       = var.create_load_balancer_controller ? 1 : 0
  eks_cluster_name            = module.eks.cluster_name
  oidc_provider_arn           = module.eks.oidc_provider_arn
  lb_controller_chart_repo    = var.lb_controller_chart_repo
  lb_controller_chart_name    = var.lb_controller_chart_name
  lb_controller_chart_version = var.lb_controller_chart_version
}

module "argocd" {
  source                         = "./add-ons/argocd"
  count                          = var.create_argocd ? 1 : 0
  eks_cluster_name               = module.eks.cluster_name
  oidc_provider_arn              = module.eks.oidc_provider_arn
  environment                    = var.environment
  argocd_namespace               = var.argocd_namespace
  argocd_repo                    = var.argocd_repo
  argocd_chart                   = var.argocd_chart
  argocd_version                 = var.argocd_version
  argocd_root_app_name           = var.argocd_root_app_name
  argocd_root_app_repo           = var.argocd_root_app_repo
  argocd_root_app_path           = var.argocd_root_app_path
  argocd_root_app_targetRevision = var.argocd_root_app_targetRevision
  argocd__root_app_project       = var.argocd__root_app_project
  kapenter_created               = module.karpenter[0].karpenter_created
  external_dns_created           = module.external-dns[0].created
  lb_controller_created          = module.lb-controller[0].created
  external_dns_domain_filter     = var.external_dns_domain_filter
}
