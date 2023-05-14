output "resource_group_name" {
  value = module.af.resource_group_name
}

output "functionapp_name" {
  value = module.af.functionapp_name
}

output "tenant_id" {
  value = module.github_federated_identity.tenant_id
}
output "subscription_id" {
  value = module.github_federated_identity.subscription_id
}
output "github_client_id" {
  value = module.github_federated_identity.client_id
}
