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
  root_app_manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata   = {
      name      = "root-app"
      namespace = "argocd"
    }
    spec       = {
      destination = {
        namespace = "argocd"
        server    = "https://kubernetes.default.svc"
      }
      source      = {
        path           = "k8s/argocd/applicationsets"
        repoURL        = "https://github.com/effip24/devops-aws-infra.git"
        targetRevision = "main"
      }
      project     = "default"
      syncPolicy  = {
        automated = {
          selfHeal = true
          prune    = true
        }
        syncOptions = [
          "CreateNamespace=true",
        ]
      }
    }
  }
}