provider "azurerm" {
  version = "~> 2.0"
  features {}
}

#terraform {
#  backend "azurerm" {
#    resource_group_name   = "terraform-state"
#    storage_account_name  = "lwmpntfstate"
#    container_name        = "tfstate"
#  }
#}
