#!/bin/bash
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <new_password>"
  exit 1
fi

newpassword=$1

kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" $newpassword | tr -d ':\n')'"}}'