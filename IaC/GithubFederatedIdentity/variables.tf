
variable "resource_group_name" {
  description = "Resource group name"
}
variable "managed_identity_name" {
  description = "User-Managed Identity name"
}
variable "federated_identity_subject" {
  description = "Github token subject as per documentation https://learn.microsoft.com/en-us/azure/active-directory/workload-identities/workload-identity-federation-create-trust-user-assigned-managed-identity?pivots=identity-wif-mi-methods-azp#important-considerations-and-restrictions"
}