################################################################################
#
# Copyright (c) 2022 Qumulo, Inc. All rights reserved.
#
# NOTICE: All information and intellectual property contained herein is the
# confidential property of Qumulo, Inc. Reproduction or dissemination of the
# information or intellectual property contained herein is strictly forbidden,
# unless separate prior written permission has been obtained from Qumulo, Inc.
#
# Filename: main.tf
# Name:     Copilot workstation terraform main
# Date:     June 4th, 2024
# Author:   kmac@qumulo.com
#
################################################################################

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.common_prefix}-nsg"
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "AllowQumuloremoteRDPAccess"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = var.authorized_ip_addresses
    destination_address_prefix = "*"
  }
}

resource "azurerm_proximity_placement_group" "ppg" {
  name                = "${var.common_prefix}-ppg"
  location            = var.location
  resource_group_name = var.rgname
  allowed_vm_sizes    = [var.vmsize]
  zone                = var.zone
}

resource "azurerm_public_ip" "workstation_publicip" {
  count                       = var.num_vms
  name                = "${var.common_prefix}-pip-${count.index}"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [var.zone]
}

resource "azurerm_network_interface" "nic" {
  count                       = var.num_vms
  name                        = "${var.common_prefix}-nic${count.index}"
  location                    = var.location
  resource_group_name         = var.rgname
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${var.common_prefix}-niccfg-${count.index}"
    subnet_id                     = var.worker_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.workstation_publicip[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "nic-nsg-assn" {
  count                     = var.num_vms
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                       = var.num_vms
  name                        = "${var.common_prefix}-${count.index}"
  location                    = var.location
  resource_group_name         = var.rgname
  network_interface_ids       = [azurerm_network_interface.nic[count.index].id]
  size                        = var.vmsize
  priority                    = "Spot"
  eviction_policy             = "Deallocate"
  proximity_placement_group_id = azurerm_proximity_placement_group.ppg.id
  zone                        = var.zone
  computer_name               = "${var.common_prefix}-${count.index}"
  admin_username              = var.admin_username
  admin_password              = var.admin_password
  timezone                    = "UTC"

 source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.common_prefix}-osdisk${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  additional_capabilities {
    ultra_ssd_enabled = false
  }
}

resource "azurerm_virtual_machine_extension" "windows_vm_extension" {
  count                = var.num_vms
  name                 = "CustomScriptExtension-${count.index}"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ${jsonencode(var.file_uris)},
        "commandToExecute": "${var.command_to_execute}"
    }
SETTINGS
}
