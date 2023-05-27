locals {
  
  component = "sandbox"
  resource_tags = {
    project = var.PROJECT
    env     = var.ENV
    owner   = var.OWNER
  }

}