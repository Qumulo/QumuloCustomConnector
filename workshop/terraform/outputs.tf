################################################################################
#
# Filename: outputs.tf
# Windows   Copilot Workshop Provisioning Terraform Module
# Date:     May 24th, 2024
# Author:   kmac@qumulo.com
# Desc:     Provision multiple azurerm_windows_virtual_machine's leveraging a prebuilt image
#
################################################################################


output "workers_virtual_machine_id" {
  description = "Workers Virtual Machine ID"
  value = azurerm_windows_virtual_machine.windows_vm.*.name
}


##########################################################################################
# Output IP Addresses
##########################################################################################

output "workers_private_ip_addresses" {
  description = "Workers Private IP Addresses"
  value = azurerm_windows_virtual_machine.windows_vm.*.private_ip_address
}

output "workstations_public_ip_address" {
  description = "Workstations Public IP Address"
  value = azurerm_windows_virtual_machine.windows_vm.*.public_ip_address
}
