#!/bin/bash

terraform init
terraform plan
terraform apply -auto-approve

echo "⏳ Waiting for 3 minutes before destroying resources..."
sleep 180

echo "🧨 Destroying resources with Terraform..."
terraform destroy -auto-approve

echo "✅ All Terraform-managed resources have been destroyed."
