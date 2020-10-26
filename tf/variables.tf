variable "rg_name" {
  default = "k8s-tf-rg"
}

variable "location" {
  default = "West Europe"
}

variable "prefix" {
  default = "k8s-tf"
}

### Azure Application Gateway

variable "agw_sku_name" {
  default = "Standard_v2"
}

variable "agw_sku_tier" {
  default = "Standard_v2"
}

variable "agw_sku_capacity" {
  default = 1
}

### Azure Kubernetes Service

variable "aks_sp_client_id" {
  description = "AKS service principal client id"
}

variable "aks_sp_client_secret" {
  description = "AKS service principal client secret"
}

variable "k8s_node_count" {
  default = 1
}

variable "k8s_vm_size" {
  default = "Standard_B2s"
}

### Helm

variable "k8s_kube_config" {
  description = "Path to Kube Config File"
  default="kube_config"
}
