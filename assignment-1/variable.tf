variable "stage" {
  description = "Deployment stage: Dev or Prod"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name for SSH"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
