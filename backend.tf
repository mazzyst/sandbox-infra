terraform {
  backend "azurerm" {
    subscription_id = "3f5b8941-3de5-4148-a787-32c5758e2138"
    resource_group_name  = "rg-inf-sandbox"
    storage_account_name = "stsandboxdevops"
    container_name       = "tfstate"
    key                  = "sandbox.tfstate"
  }
}
