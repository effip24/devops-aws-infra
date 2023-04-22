# Terraform EKS Cluster with Karpenter, External-DNS, LB Ingress Controller, and Argo CD


##  Prerequisites
To use this project, you'll need the following:
 - An AWS account
 - Terraform installed on your local machine
 - Terragrunt installed on your local machine
 - AWS CLI installed on your local machine
 - kubectl installed on your local machine
## Add-ons

This project deploys several Kubernetes add-ons to the EKS cluster, including:

### Karpenter
[Karpenter](https://github.com/awslabs/karpenter) is a Kubernetes add-on that automates node provisioning and lifecycle management for AWS Fargate and EC2 Spot instances.

### External-DNS
[External-DNS](https://github.com/kubernetes-sigs/external-dns) is a Kubernetes add-on that synchronizes exposed Kubernetes Services and Ingresses with DNS providers.

### LB Controller
[LB Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/) is a Kubernetes add-on that manages AWS Load Balancers for Kubernetes Services and Ingresses.

### Argo CD
[Argo CD](https://argoproj.github.io/argo-cd/) is a continuous delivery tool that uses GitOps to deploy applications to Kubernetes clusters.