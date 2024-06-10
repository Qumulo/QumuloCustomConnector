
# Deploying the Workshop

Deploying the workshop involves two main steps: deploying an ANQ cluster and running Terraform to provision the Windows 10 workstations (QCC pre-requisite ready).

## Step 1: Deploying the ANQ Cluster

### Option A: Deploy ANQ Using the Azure Portal

- Start by watching this short one minute video:

<div align="center">
    <a href="https://www.youtube.com/watch?v=zJpUAZVAato">
        <img src="https://img.youtube.com/vi/zJpUAZVAato/0.jpg" alt="Watch this one minute video">
    </a>
</div>

- Follow the instructions in Microsoft's [Get started with Azure Native Qumulo Scalable File Service](https://learn.microsoft.com/en-us/azure/partner-solutions/qumulo/qumulo-create) article.

### Option B: Using the Az.Qumulo PowerShell Module

High-level overview:
1. Install the required PowerShell module.
2. Connects to the Azure Account (`Connect-AzAccount`).
3. Creates a resource group if one doesn't already exist.
4. Define and create an ANQ cluster.

### Variables to configure:

| Variable              | Description                                           | Example                             |
|-----------------------|-------------------------------------------------------|-------------------------------------|
| `YourResourceGroupName` | The name of the resource group                      | myResourceGroup                             |
| `YourLocation`        | The location of the resource group                    | Example: eastus2<br> <div align="center"><a href="https://qumulo.com/product/azure/#:~:text=Azure%20Native%20Qumulo%20can%20be,%2C%20UK%2C%20Asia%20and%20Canada.">ANQ supported regions</a></div>                  |
| `YourClusterName`     | The name of the ANQ cluster (<= 15 characters) | `myanqcluster-1`                   |
| `InitialCapacity`        | The initial capacity of the ANQ cluster (minimum 100TiB) | `100`                              |
| `AdminPassword`       | The admin password for the ANQ cluster                | `Mypassword!123`                    |
| `UserEmail`           | The user email for notifications                      | `storageadmins@yourorganization.com`|
| `DelegatedSubnetId`   | The subnet ID delegated to Qumulo.Storage/fileSystems | `/subscriptions/.../subnets/...`    |
| `AvailabilityZone`    | The availability zone for the ANQ cluster (Keep same as workstations) | Example: `2`                        |
| `Tag`                 | User-defined tags                                     | `@{"Department"="Engineering"}`                    |
| `MarketplaceOfferId`  | The marketplace offer ID                              | `qumulo-saas-mpp`                   |
| `MarketplacePlanId`   | The marketplace plan ID                               | `azure-native-qumulo-hot-cold-iops` |
| `MarketplacePublisherId` | The marketplace publisher ID                      | `qumulo1584033880660`               |
| `StorageSku`          | The storage SKU                                       | `Hot`                          |


1. Install the Az.Qumulo module:
    ```powershell
    Install-Module -Name Az.Qumulo -Scope CurrentUser -Force -AllowClobber
    ```

2. Connect to your Azure account:
    ```powershell
    Connect-AzAccount
    ```

3. Define the parameters for the ANQ cluster:
    ```powershell
    # Update with your specifics
    $resourceGroupName = "my-rg"
    $location = "location" # e.g., "eastus2"
    $AdminPassword = 'Mypassword!123'
    $UserEmail = "storageadmins@yourorganization.com"

    # The cluster name must be less than 15 characters
    $clusterName = "myanqcluster-1"

    # This subnet needs to be delegated to Qumulo.Storage/fileSystems
    $DelegatedSubnetId = '/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/$resourceGroupName/providers/Microsoft.Network/virtualNetworks/myvnet/subnets/mysubnetname' 

    # The minimum starting capacity is 100TiB. You can increase the capacity non-disruptively to several hundreds of PiBs
    $InitialCapacity = 100 

    # You should place the ANQ cluster in the same zone as the workstations for minimum network latency.
    $AvailabilityZone = "2"

    # Add any user-defined tags here
    $Tag = @{"123"="abc"}

    $MarketplaceOfferId = "qumulo-saas-mpp" 
    $MarketplacePlanId = "2024-02-01-free-test-plan" 
    $MarketplacePublisherId = "qumulo1584033880660"
    $StorageSku = "Standard"
    ```

4. Create a resource group (if it does not already exist):
    ```powershell
    $resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
    if (-not $resourceGroup) {
        New-AzResourceGroup -Name $resourceGroupName -Location $location
    }
    ```

5. Create the ANQ cluster:
    ```powershell
    New-AzQumuloFileSystem -Name $clusterName `
        -ResourceGroupName $resourceGroupName `
        -AdminPassword $AdminPassword `
        -DelegatedSubnetId $DelegatedSubnetId `
        -InitialCapacity $InitialCapacity `
        -Location $location `
        -MarketplaceOfferId $MarketplaceOfferId `
        -MarketplacePlanId $MarketplacePlanId `
        -MarketplacePublisherId $MarketplacePublisherId `
        -StorageSku $StorageSku `
        -UserEmail $UserEmail `
        -AvailabilityZone $AvailabilityZone `
        -Tag $Tag
    ```

For additional details about the Az.Qumulo PowerShell Module, [click here](https://learn.microsoft.com/en-us/powershell/module/az.qumulo/?view=azps-12.0.0).

### Option C: Using the Azure REST API (Python Script)

- Azure Qumulo SDK for Python [documentation](https://learn.microsoft.com/en-us/python/api/overview/azure/qumulo?view=azure-python).

- You can [download](create-anq-cluster.py) an example Python script from the GitHub repo.

---

## Step 2: Deploying QCC Windows 10 Workstations with Terraform

- Customizing the configuration for your environment:
   - Modify the `variables.tf` file located in [the GitHub repo](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/terraform/variables.tf) with your specific environment settings.

- Run `terraform init`, `terraform plan`, and `terraform apply`:
   - Run `terraform init` to initialize the directory.
   - Run `terraform plan -out qcc.plan` to validate that the settings are correct.
   - Run `terraform apply qcc.plan` to build the workstations.

- The `terraform apply` will take ~10 minutes, as it is downloading, installoing, and configuring a suite of prerequisites for the workshop.  
   - Let the WindowsExtensions fully complete before logging into the windows workstations. 
   - Once the attendees log in, there will be a Powershell 7 command prompt running.  
   - **Let the Powershell 7 script finish**, as it is intalling the required Powershell modules. 

---

<div align="right">
  <a href="qcc-workshop.md">⬅️ [Previous: Start]</a> | <a href="qcc-workshop-connecting.md">[Next: Connecting to the Workshop] ➡️</a>
</div>
