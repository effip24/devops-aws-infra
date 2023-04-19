#!/bin/bash
export AWS_REGION=us-east-1
export AWS_PROFILE=sandbox

rm -rf ~/.kube/config
aws eks update-kubeconfig --name dev-eks-test --region us-east-1