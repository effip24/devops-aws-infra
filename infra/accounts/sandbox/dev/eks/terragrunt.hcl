include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//terraform/eks"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals.aws_region
  environment = local.account_vars.locals.environment
  account_id = local.account_vars.locals.aws_account_id
  account_name = local.account_vars.locals.account_name
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = local.base_source
}

inputs = {
  eks_cluster_name = "${local.account_name}-${local.environment}-eks"
  eks_cluster_version = "1.24"
  cluster_endpoint_public_access = true
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  eks_admin_role_name = "eks-admin-role"
  environment = local.environment
  account_id = local.account_id

  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_private_subnets = dependency.vpc.outputs.vpc_private_subnets

    eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.medium"]
      create_security_group = false
      min_size     = 2
      max_size     = 3
      desired_size = 3
    }
  }

  node_security_group_tags = {
    "karpenter.sh/discovery" = "${local.account_name}-${local.environment}-eks"
  }

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }

  is_domain_private_zone = false

  karpenter_chart_repo = "oci://public.ecr.aws/karpenter"
  karpenter_chart_name = "karpenter"
  karpenter_chart_version = "v0.27.3"

  external_dns_chart_repo = "https://kubernetes-sigs.github.io/external-dns/"
  external_dns_chart_name = "external-dns"
  external_dns_chart_version = "1.12.2"
  external_dns_provider = "aws"
  external_dns_aws_region = local.region
  external_dns_source = "ingress"
  external_dns_domain_filter = "cmcloudlab319.info"

  lb_controller_chart_repo = "https://aws.github.io/eks-charts"
  lb_controller_chart_name = "aws-load-balancer-controller"
  lb_controller_chart_version = "1.5.2"

  argocd_namespace = "argocd"
  argocd_repo = "https://argoproj.github.io/argo-helm"
  argocd_chart = "argo-cd"
  argocd_version = "5.29.1"
  argocd_root_app_name = "root-apps-${local.environment}"
  argocd_root_app_repo  = "https://github.com/effip24/devops-aws-infra.git"
  argocd_root_app_path = "k8s/argocd/applicationsets"
  argocd_root_app_targetRevision = "main"
  argocd__root_app_project = "default"
}