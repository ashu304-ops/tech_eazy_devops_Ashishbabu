
---

````markdown
# AWS S3 & EC2 Logs Automation (Free Tier Compatible)

This project automates the creation of AWS resources using Terraform to:

- Create two IAM roles with specific S3 permissions:
  - **Read-only role**: Can list and read objects in S3.
  - **Write-no-read role**: Can create buckets and upload files, but cannot read or list objects.
- Create a private S3 bucket (bucket name is configurable).
- Launch an EC2 instance with the write-no-read role attached via an Instance Profile.
- Configure the EC2 instance to upload system and application logs to the S3 bucket **on shutdown**.
- Apply an S3 lifecycle rule to automatically delete logs older than 7 days.
- Use the read-only role to verify that files are listed in the S3 bucket.
- Destroy all created resources automatically within 1 minute to keep costs within AWS Free Tier.

---

## Prerequisites

- AWS account with programmatic access and permissions to create IAM, EC2, and S3 resources.
- AWS CLI installed and configured (`aws configure`).
- Terraform installed (v1.0+ recommended).
- Linux/macOS shell environment for running scripts.

---

## Getting Started

1. **Clone this repository:**

```bash
git clone <your-repo-url>
cd <your-repo-folder>
````

2. **Configure AWS CLI:**

```bash
aws configure
```

3. **Set your bucket name and run the deployment script:**

```bash
./deploy_and_destroy.sh
```

The script will:

* Initialize Terraform.
* Create resources (S3 bucket, IAM roles, EC2 instance).
* Wait 60 seconds to allow EC2 to start and upload logs on shutdown.
* Destroy all resources to avoid ongoing costs.

---

## Terraform Variables

* `bucket_name` (required): Name of the S3 bucket to create (must be globally unique).

You can override this by modifying the deploy script or passing `-var` directly.

---

## Important Files

* `main.tf` - Terraform configuration for AWS resources.
* `variables.tf` - Terraform variable declarations.
* `scripts/user_data.sh` - EC2 user-data script for installing AWS CLI and configuring log upload.
* `policies/` - JSON IAM policies for roles.
* `deploy_and_destroy.sh` - Bash script to deploy and clean up resources automatically.

---

## How It Works

* The EC2 instance boots and runs the user-data script.
* The script installs AWS CLI and sets up a systemd service that uploads `/var/log/cloud-init.log` and app logs to the S3 bucket when the instance shuts down.
* The bucket has a lifecycle rule to delete logs after 7 days.
* The deployment script waits 60 seconds, then destroys everything to prevent AWS charges beyond free tier.

---

## Notes

* Ensure the bucket name you provide is unique and valid.
* This setup is designed to run **quickly and cleanly** for testing or demo purposes.
* Logs are uploaded during shutdown, so stopping or terminating the instance triggers the upload.
* The IAM roles strictly limit permissions to follow the principle of least privilege.

---

## License

This project is released under the MIT License.

---

## Questions?

Feel free to open an issue or reach out for help.

---
