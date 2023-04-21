module "iam_lb_controller_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "load-balancer-controller-role"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    one = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:load-balancer-controller-aws-load-balancer-controller"]
    }
  }
}
