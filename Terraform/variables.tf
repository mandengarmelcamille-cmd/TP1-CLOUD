# variables.tf

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Azure region"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "public_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
variable "alert_email_address" {
  type        = string
  description = "Adresse email de réception des alertes"
}

variable "storage_account_name" {
  type        = string
  description = "Nom du compte de stockage à créer"
}

variable "storage_container_name" {

  description = "Azure stockage mandeng"
  type        = string
  
}