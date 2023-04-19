#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <access_key> <secret_key>"
  exit 1
fi

accesskey=$1
secretkey=$2

sed -i.bak -e '/\[sandbox\]/,/^\s*$/ s/aws_access_key_id =.*/aws_access_key_id = '"$accesskey"'/' -e '/\[sandbox\]/,/^\s*$/ s/aws_secret_access_key =.*/aws_secret_access_key = '"$secretkey"'/' ~/.aws/credentials
