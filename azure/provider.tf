terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27.0" # Allow minor updates
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
