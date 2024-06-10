# Deploying the workshop

Deploying the workshop is done in two steps: deploying an ANQ cluster and running Terraform for the Windows 10 Workstations

### Step 1: Deploying the ANQ cluster 

##### Option A: Deploy ANQ using the Azure Portal

- Start by watching this one minute video: 
<br>

<div align="center">
    <a href="https://www.youtube.com/watch?v=zJpUAZVAato">
        <img src="https://img.youtube.com/vi/zJpUAZVAato/0.jpg" alt="Watch this one minute video">
    </a>
</div>

- Follow the instructions in Microsoft's *Get started with Azure Native Qumulo Scalable File Service* article [Get started with Azure Native Qumulo Scalable File Service](https://learn.microsoft.com/en-us/azure/partner-solutions/qumulo/qumulo-create) article. 

##### Option B: Using the Az.Qumulo PowerShell Module

>The following PowerShell commands below installs the necessary module, connects to Azure, creates the resource group if it doesn't exist, and then creates the ANQ cluster with the specified parameters.

- Be sure to set the variables `YourResourceGroupName`, `YourLocation`, `YourClusterName`, `YourClusterSize`, and `YourCapacity` to match your environmental specifics. 

1. Install the Az.Qumulo module
    ```powershell
    Install-Module -Name Az.Qumulo -Scope CurrentUser -Force -AllowClobber
    ```

2. Connect to your Azure account
    ```powershell
    Connect-AzAccount
    ```

3. Define the parameters for the ANQ cluster
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

    # The minimum starting capacity is 100TiB. You can increase the capacity non-disruptively to several hundres PiBs
    $InitialCapacity 100 

    # You should place the ANQ cluster in the same zone as the workstations for minimum network latency.
    $AvailabilityZone = "2"

    # Add any user-defined tags here
    $Tag @{"123"="abc"}

    $MarketplaceOfferId = "qumulo-saas-mpp" 
    $MarketplacePlanId = "azure-native-qumulo-hot-cold-iops" 
    $MarketplacePublisherId = "qumulo1584033880660"
    $StorageSku = "Standard"


    ```

4. Create a resource group (if it does not already exist)
    ```powershell
    $resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
    if (-not $resourceGroup) {
        New-AzResourceGroup -Name $resourceGroupName -Location $location
    }
    ```

5. Create the ANQ cluster
    ```powershell
New-AzQumuloFileSystem -Name $clusterName `
    -ResourceGroupName $resourceGroupName `
    -AdminPassword $AdminPassword `
    -DelegatedSubnetId $DelegatedSubnetId `
    -InitialCapacity $InitialCapacity `
    -Location $location `
    -MarketplaceOfferId $MarketplaceOfferId `
    -MarketplacePlanId  $MarketplacePlanId `
    -MarketplacePublisherId  $MarketplacePublisherId  `
    -StorageSku $StorageSku `
    -UserEmail $UserEmail `
    -AvailabilityZone $AvailabilityZone `
    -Tag $Tag

    ```

For additional details about the Az.Qumulo PowerShell Module, [click here.](https://learn.microsoft.com/en-us/powershell/module/az.qumulo/?view=azps-12.0.0)



#### Option C: Using the Azure REST SPI (Python script)

- Azure Qumulo SDK for Python <a href="https://learn.microsoft.com/en-us/python/api/overview/azure/qumulo?view=azure-python">[documentation]</a>. 

- You can <a href="create-anq-cluster.py">[download]</a> an example python script from the GitHUB repo. 

---

### Step 2: Deploying QCC Windows 10 Workstations with Terraform

- Customizing the configuration for your environment
   - Modify yhe `variables.tf` file located in <a href="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/terraform/variables.tf">[ the GitHUB repo]</a> with your specific environment settings.  

- terraform init, plan, and apply 
   - Run `terraform init` to initialize the directory
   - Run `terraform plan -out qcc.plan` to validate that the settings are correct
   - Run `terraform apply qcc.plan` to build the workstations 

---  

<div align="right">
  <a href="qcc-workshop-holstart.md">⬅️ [Previous: Hands-On Lab]</a> | <a href="qcc-workshop-connecting.md">[Next: Connecting to the Workshop] ➡️ </a>
</div>


