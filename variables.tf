variable "vm_count" {
  description = "Number of Azure VMs to create"
  type        = number
  default     = 1
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-app-deploy"
}

variable "storage_account_name" {
  description = "Storage Account Name (lowercase only)"
  type        = string
  default     = "appstorageaccountdemo"
}

variable "container_name" {
  description = "Blob Container Name"
  type        = string
  default     = "appjarcontainer"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  default = "AdminPassw0rd123!"
}
