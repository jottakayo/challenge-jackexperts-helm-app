locals {
  env                  = "dev"
  region               = "East US 2"
  resource_group_name  = "jackex"
  eks_name             = "jackex-kubernetes"
  eks_version          = "1.28.9"
  projeto              = "dev"
  orchestrator_version = "1.28.9"
  node_count           = 1
  enable_auto_scaling  = false
  vm_size              = "Standard_B2s"
}
