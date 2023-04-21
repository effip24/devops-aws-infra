data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.cluster_name
}
data "aws_partition" "current" {}
data "aws_availability_zones" "available" {}
data "aws_ecrpublic_authorization_token" "token" {}
data "aws_iam_policy_document" "eks_admin_policy" {
  statement {
    effect = "Allow"
    actions = [
      "eks:Describe*",
      "eks:List*",
      "eks:Get*",
      "eks:Update*",
      "eks:Create*",
      "eks:Delete*",
      "eks:TagResource",
      "eks:UntagResource",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_group.eks_admin_group.arn]
    }
  }
}
data "aws_route53_zone" "domain" {
  name         = var.domain
  private_zone = var.is_domain_private_zone
}
