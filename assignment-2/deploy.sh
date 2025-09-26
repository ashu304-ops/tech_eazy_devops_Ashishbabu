#!/bin/bash
set -e

UNIQUE_BUCKET="logs-bucket-$(date +%s)"

echo "[+] Bucket to create: $UNIQUE_BUCKET"

terraform init

terraform apply -auto-approve -var="bucket_name=$UNIQUE_BUCKET"

echo "[+] Sleeping 60 seconds before destroying..."
sleep 60

terraform destroy -auto-approve -var="bucket_name=$UNIQUE_BUCKET"
