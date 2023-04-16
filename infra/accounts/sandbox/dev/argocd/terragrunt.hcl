include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//terraform/argocd"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.account_vars.locals.environment
  account_id = local.account_vars.locals.aws_account_id
}

dependencies {
  paths = ["../eks"]
}

dependency "eks" {
  config_path = "../eks"
}

terraform {
  source = local.base_source
}

inputs = {
  cluster_name = dependency.eks.outputs.cluster_name
  namespace = "argocd"
  argocd_repo = "https://argoproj.github.io/argo-helm"
  argocd_chart = "argo-cd"
  argocd_version = "5.29.1"
  argocd_values = [file("${get_parent_terragrunt_dir()}/../k8s/argocd/apps/main.yaml")]
}