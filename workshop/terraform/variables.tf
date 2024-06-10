################################################################################
#
# Copyright (c) 2022 Qumulo, Inc. All rights reserved.
#
# NOTICE: All information and intellectual property contained herein is the
# confidential property of Qumulo, Inc. Reproduction or dissemination of the
# information or intellectual property contained herein is strictly forbidden,
# unless separate prior written permission has been obtained from Qumulo, Inc.
#
# Filename: variables.tf
# Name:     Copilot Workshop Workstation Terraform Module
# Date:     June 4th, 2024
# Author:   kmac@qumulo.com
#
# SUBSCRIPTION_ID:	"/subscriptions/00000000-0000-0000-0000-000000000000"
# RESOURCE_GROUP: 	Key-value pair <90 characters suggested format <service short name>-<environment>-rg Example: qcc-workshop-rg
# VNET_NAME:		Key-value pair <64 characters suggested format vnet-<service short name>-<environment>-vnet Example: qcc-workshop-vnet
# SUBNET_NAME:		Key-value pair <80 characters suggested format <service short name>-<environment>-subnet Example: qcc-workshop-subnet
#
################################################################################

variable "common_prefix" {
  type        = string
  description = "Prefix for all resources deployed by this project."
  default     = "qcc"
}

###
# Modify the default from 1 to 'n' number of virtual desktops you wish to deploy
# E.g. default     = 100
###
variable "num_vms" {
  type        = number
  description = "Number of VM's"
  default     = 1
}

###
# Choose a VM size thats offered in the region/zone you are running in. 
###
variable "vmsize" {
  type        = string
  description = "Virtual Machine Size for the Servers"
  default     = "Standard_B4ls_v2"
}

variable "admin_username" {
  type        = string
  description = "Local admin username"
  default     = "qumulo"
}

###
# Set the "RESOURCE_GROUP" name to match the Resource Group you are using
###
variable "rgname" {
  type        = string
  description = "Resource Group Name"
  default     = "RESOURCE_GROUP"
}

###
# Be sure that the REGION is updated 
###
variable "location" {
  type        = string
  description = "Microsoft Region/Location"
  default     = "REGION"
}

###
# Be sure that you specify which zone you want to run in. 
# For optimal performance use the same zone as the ANQ cluster you are using
###
variable "zone" {
  type        = string
  description = "Zone in the region you would like to deploy the Azure Native Qumulo cluster in"
  default     = "1"
}

###
# IMPORTANT! The string used for the subnet resource id much match what is in the Azure Portal/CLI, exactly.
#
# CLI: az network vnet subnet show --resource-group MyResourceGroup --vnet-name MyVNet --name MySubnet --query "id" --output tsv
#
###
variable "worker_subnet" {
  type        = string
  description = "Subnet to deploy worker VM's too - should be in the same vNet as the ANQ cluster"
  default     = "/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/VNET_NAME/subnets/SUBNET_NAME"
}

###
# Edit this field to allow just the IP addresses network access to the workshop
###
variable "authorized_ip_addresses" {
  type        = list(string)
  description = "IP addresses for the workstations that need access to the harness"
  default     = ["xxx.xxx.xxx.xxx/, "yyy.yyy.yyy.yyy", "zzz.zzz.zzz.zzz"]
}

###
# Set this to be the Windows password for the qumulo/local admin account
###
variable "admin_password" {
  type        = string
  description = "Windows local admin password"
  default     = "P@55w0rd1234!"
}

###
# This is a SAS TOKEN of a blob containing the userdata script used to configure the VMs during install. 
#    Qumulo has shared the userdata script used to configure the Windows 10 workstation used in the workshop.  Other versions of Windows will likely need modifications. 
#    To learn how to create a SAS token: https://learn.microsoft.com/en-us/azure/ai-services/translator/document-translation/how-to-guides/create-sas-tokens?tabs=Containers
#    QCC userdata PowerShell script: https://github.com/Qumulo/QumuloCustomConnector/workshop/scripts/copilot-workshop-userdata.ps1
#
###
variable "file_uris" {
  type        = list(string)
  description = "List of file URIs for Custom Script Extension"
  default     = ["https://qumuloworkshops.blob.core.windows.net/qccapps/copilot-workshop-userdata.ps1?se=2026-06-05T23%3A26Z&sp=r&spr=https&sv=2021-12-02&sr=b&sig=MWCoQ%2F%2BHZtKeMD7lANJvKN7NQSoUM8dbJ4Uk76zZ%2BIE%3D"]
}

variable "command_to_execute" {
  type        = string
  description = "Command to execute for Custom Script Extension"
  default     = "powershell -ExecutionPolicy Unrestricted -File copilot-workshop-userdata.ps1"
https://qumuloworkshops.blob.core.windows.net/qccapps/copilot-workshop-userdata.ps1?se=2026-06-05T23%3A26Z&sp=r&spr=https&sv=2021-12-02&sr=b&sig=MWCoQ%2F%2BHZtKeMD7lANJvKN7NQSoUM8dbJ4Uk76zZ%2BIE%3D"]
}}
