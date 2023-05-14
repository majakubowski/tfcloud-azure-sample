resource "azurerm_user_assigned_identity" "id" {
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  name                = var.managed_identity_name
}

resource "azurerm_role_assignment" "id_rbac" {
  scope = data.azurerm_resource_group.rg.id
  role_definition_name = "Owner"
  principal_id = azurerm_user_assigned_identity.id.principal_id
}

resource "azurerm_federated_identity_credential" "github" {
  resource_group_name = data.azurerm_resource_group.rg.name
  name                = "github-federation"
  parent_id           = azurerm_user_assigned_identity.id.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = var.federated_identity_subject
}