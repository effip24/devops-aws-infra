data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.cluster_name
}
data "aws_partition" "current" {}
data "aws_availability_zones" "available" {}
data "aws_ecrpublic_authorization_token" "token" {}
