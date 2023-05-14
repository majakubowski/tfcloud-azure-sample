variable "location" {
  description = "azure region where resources will be created"
  default     = "westeurope"
}
variable "env" {
  description = "Name of environment - will be part of resources names"
  default     = "dev"
}
variable "replicationtype" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  default     = "LRS"
}
variable "plan_sku" {
  description = "The SKU for the App Service: Service Plan "
  default     = "Y1"
}
variable "project_prefix" {
  description = "used for resources names"
  default     = "testmj"
}