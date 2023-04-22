data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
}
data "aws_ecrpublic_authorization_token" "token" {}
data "aws_route53_zone" "domain" {
  name         = var.external_dns_domain_filter
  private_zone = var.is_domain_private_zone
}