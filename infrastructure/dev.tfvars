environment = "dev"

azure_region = "Austria East"

aks_node_pool_default = {
  vm_size   = "Standard_D2_v3"
  max_count = 2
  min_count = 1
}

# High node pool, demonstration only, not provisioned (commented out in node-pool.tf locals).
aks_node_pool_high = {
  vm_size   = "Standard_F8s_v2"
  min_count = 2
  max_count = 3
}