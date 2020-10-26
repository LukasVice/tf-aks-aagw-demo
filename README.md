# Deploy AKS with Azure Application Gateway and demo apps

## Requirements

- Azure CLI
- terraform
- kubectl
- helm

## Steps

- Login to Azure CLI

  `az login`

- Create a Azure service principal

  `az ad sp create-for-rbac --skip-assignment`

  - Copy appId (client-id) and password (client-secret) to [terraform.tfvars](terraform.tfvars)

- Configure apps

  - Configure host for [k8s/app1.yaml](k8s/app1.yaml) and [k8s/app2.yaml](k8s/app2.yaml)
  - Configure DNS entry for used host

- _Optional_: Create an Azure storage account and configure the terraform backend ([tf/main.tf](tf/main.tf))

- Deploy

  ```sh
  # Deploy infrastructure
  terraform init tf
  terraform plan tf
  terraform apply tf

  # Configure kubectl
  az aks get-credentials --name k8s-tf-k8s-cluster --resource-group k8s-tf-rg

  # Deploy demo apps
  kubectl apply -f k8s/app1.yaml
  kubectl apply -f k8s/app2.yaml
  ```

## Resources

- https://www.starwindsoftware.com/blog/use-an-application-gateway-as-ingress-and-protect-your-aks-websites-with-a-waf
- https://github.com/Azure/application-gateway-kubernetes-ingress
- https://github.com/Azure/terraform-azurerm-appgw-ingress-k8s-cluster
- https://medium.com/faun/build-an-azure-application-gateway-with-terraform-8264fbd5fa42
