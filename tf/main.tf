provider "azurerm" {
  version = "~> 2.0"
  features {}
}

provider "azuread" {
  version = "~> 1.0.0"
}

provider "helm" {
  version = "~> 1.3"

  kubernetes {
    config_path = local_file.kube_config.filename
  }
}

provider "local" {
  version = "~> 2.0.0"
}

#terraform {
#  backend "azurerm" {
#    resource_group_name   = "terraform-state"
#    storage_account_name  = "lwmpntfstate"
#    container_name        = "tfstate"
#  }
#}
