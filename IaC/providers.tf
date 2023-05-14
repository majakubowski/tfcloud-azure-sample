terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }
  cloud {}
}


provider "azurerm" {
  features {}
  skip_provider_registration = true
}

