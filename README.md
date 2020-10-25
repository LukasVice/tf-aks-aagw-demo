# Deploy AKS with Azure Application Gateway and demo apps

## Requirements

- Azure CLI
- kubectl
- helm

## Steps

- Login to Azure CLI

  `az login`

- Create a Azure service principal

  `az ad sp create-for-rbac --skip-assignment`

  - Copy appId (client-id) and password (client-secret) to [tf/terraform.tfvars](tf/terraform.tfvars)
  - Complete [k8s/aadpodidentity.yaml](k8s/aadpodidentity.yaml): ClientSecret (base64 client-secret), TenantID, ClientID

- Get the service principal's object id with

  `az ad sp show --id <appId>`

  Copy the object id to [tf/terraform.tfvars](tf/terraform.tfvars)

- Complete helm config

  - Complete [k8s/helm-secret.json](k8s/helm-secret.json) (clientId, clientSecret, tenantId, subscriptionId)
  - Fill out [k8s/03-helm-config.yaml](k8s/03-helm-config.yaml): subscriptionId, secretJSON (base64 helm-secret.json)

- Configure apps

  - Complete host for [k8s/05-app1.yaml](k8s/05-app1.yaml) and [k8s/06-app2.yaml](k8s/06-app2.yaml)
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

  # Prepare and install AGIC
  kubectl apply -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment-rbac.yaml
  kubectl apply -f k8s/01-aadpodidentity.yaml

  helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
  helm repo update
  helm install -f k8s/03-helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure --generate-name

  # Deploy demo apps
  kubectl apply -f k8s/05-app1.yaml
  kubectl apply -f k8s/06-app2.yaml
  ```

## Resources

- https://www.starwindsoftware.com/blog/use-an-application-gateway-as-ingress-and-protect-your-aks-websites-with-a-waf
- https://github.com/Azure/application-gateway-kubernetes-ingress
- https://github.com/Azure/terraform-azurerm-appgw-ingress-k8s-cluster
- https://medium.com/faun/build-an-azure-application-gateway-with-terraform-8264fbd5fa42
