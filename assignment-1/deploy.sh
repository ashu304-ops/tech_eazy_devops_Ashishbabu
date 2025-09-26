# Initialize Terraform
terraform init

# Deploy to Dev
terraform apply -var-file="dev.tfvars"

# Output will show public IP
# Visit http://<public-ip> in browser

# Destroy after use (to save cost)
terraform destroy -var-file="dev.tfvars"
