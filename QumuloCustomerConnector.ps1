function Read-Content {
    # Load the schema from the JSON file as an array of objects
    $qumuloDetails = Get-Content -Path ".\qumulo.json" -Raw | ConvertFrom-Json
    $files = Get-ChildItem -Path "\\$($qumuloDetails.clusterAddress)\$($qumuloDetails.shareName)" -Recurse -File -Filter "$($qumuloDetails.filePrefix)*"
    
    $files | ForEach-Object {
        # Define the path to the PDF file and the output text file
        $pdfPath = $_.FullName
        $txtOutputPath = "$($qumuloDetails.tempFilePath)"

        # Convert PDF to Text using pdftotext
        $PDFToTextPath = "C:\Program Files\Xpdf\bin64\pdftotext.exe"
        if (Test-Path -Path $PDFToTextPath) {
            & "C:\Program Files\Xpdf\bin64\pdftotext.exe" -raw $pdfPath $txtOutputPath
        } else {
            Write-Output "The pdf to text does not exist.Please download it from https://dl.xpdfreader.com/xpdf-tools-win-4.05.zip" -ForegroundColor Red
            exit 1
        }
        
        # Read the converted text file
        $content = Get-Content $txtOutputPath -Encoding UTF8

        # Define regular expressions for the data you want to extract
        $regexes = @{
            Date = "Date:\s*(\d{2}/\d{2}/\d{4})"
            InvoiceNumber = "Invoice Number:\s*(\w+)"
            Customer = "Customer:\s*(.+?)(?=\s+Address:)"
            Address = "Address:\s*(.+?)(?=\s+Postcode:)"
            Postcode = "Postcode:\s*(.+?)\s+(?=City:)"
            City = "City:\s*(.+?)\s+(?=Country:)"
            Country = "Country:\s*(.+?)\s+(?=Items:)"
            TotalAmount = "Total Amount:\s*([£$€]\d+\.\d{2})"
        }

        $invoiceDetails = @{}
        foreach ($regKey in $regexes.Keys) {
            $matches = Select-String -Pattern $regexes[$regKey] -InputObject $content
            if ($matches.Matches.Count -gt 0) {
                $invoiceDetails[$regKey] = $matches.Matches[0].Groups[1].Value.Trim()
            } else {
                $invoiceDetails[$regKey] = ""
            }
        }

        # Creating a structured object for each invoice
        $invoice = @{
            Meta = @{
                city = $invoiceDetails.City
                address = $invoiceDetails.Address
                country = $invoiceDetails.Country
                postcode = $invoiceDetails.Postcode
                totalAmount = $invoiceDetails.TotalAmount
                date = $invoiceDetails.Date
                invoiceNumber = $invoiceDetails.InvoiceNumber
                customer = $invoiceDetails.Customer
                # items can be added similarly if needed
            }
        }

        Write-Output $invoice
    }
}

function ConvertTo-ExternalItem {
    param(
        [Parameter(Mandatory = $true)]
        [Object[]] $Content
    )

    # Load the schema from the JSON file
    $qumuloDetails = Get-Content -Path ".\qumulo.json" -Raw | ConvertFrom-Json

    # Construct the base URL
    $baseUrl = "file://$($qumuloDetails.clusterAddress)/$($qumuloDetails.shareName)/"

    $Content | ForEach-Object {
        try {
            # Ensure all necessary meta properties are present
            $docDate = if ($_.Meta.date) { Get-Date $_.Meta.date -Format "yyyy-MM-dd" } else { "" }
            $invoiceNumber = if ($_.Meta.invoiceNumber) { $_.Meta.invoiceNumber } else { "" }
            $customer = if ($_.Meta.customer) { $_.Meta.customer } else { "" }
            $totalAmount = if ($_.Meta.totalAmount) { $_.Meta.totalAmount } else { "" }
            $address = if ($_.Meta.address) { $_.Meta.address } else { "" }
            $city = if ($_.Meta.city) { $_.Meta.city } else { "" }
            $country = if ($_.Meta.country) { $_.Meta.country } else { "" }
            $postCode = if ($_.Meta.postCode) { $_.Meta.postCode } else { "" }
            $product = if ($_.Meta.product) { $_.Meta.product } else { "" }
            $customerName = if ($_.Meta.customerName) { $_.Meta.customerName } else { "" }

            $path = "Invoice" + $invoiceNumber + ".pdf"
            $url = [System.Uri]::new([System.Uri]$baseUrl, $path).ToString()

            # Create the item structure
            $item = @{
                id = $invoiceNumber
                properties = @{
                    customer = $customer
                    totalAmount = $totalAmount
                    invoiceNumber = $invoiceNumber
                    date = $docDate
                    address = $address
                    city = $city
                    country = $country
                    postCode = $postCode
                    url = $url
                }
                content = @{
                    value = "Invoice for $product to $customerName"
                    type = 'text'
                }
                acl = @(
                    @{
                        accessType = "grant"
                        type = "everyone"
                        value = "everyone"
                    }
                )
            }

            Write-Output $item
        } catch {
            Write-Error "Failed to process content: $_"
        }
    }
}

function InitializeEntraApp {
    param (
        [Parameter(Mandatory = $false)]
        [string] $connectionFilePath = ".\connection.json"
    )

    try {
        # Load connection details from the JSON file
        $connectionDetails = Get-Content -Path $connectionFilePath -Raw | ConvertFrom-Json
        Write-Output "Loaded connection details from $connectionFilePath"

        # Connect to Microsoft Graph
        Connect-MgGraph -Scopes AppRoleAssignment.ReadWrite.All, Application.ReadWrite.All -NoWelcome
        Write-Output "Connected to Microsoft Graph"

        # Define the required resource access
        $requiredResourceAccess = @(
            @{
                "resourceAccess" = @(
                    @{
                        id = "f431331c-49a6-499f-be1c-62af19c34a9d"
                        type = "Role"
                    },
                    @{
                        id = "8116ae0f-55c2-452d-9944-d18420f5b2c8"
                        type = "Role"
                    }
                )
                "resourceAppId" = "00000003-0000-0000-c000-000000000000"
            }
        )
        Write-Output "Defined required resource access"

        # Create the application
        $app = New-MgApplication -DisplayName $connectionDetails.appDisplayName -RequiredResourceAccess $requiredResourceAccess
        Write-Output "Created application: $($app.DisplayName) with AppId: $($app.AppId)"

        # Get the Graph Service Principal Id
        $graphSpId = (Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'").Id
        Write-Output "Retrieved Graph Service Principal Id: $graphSpId"

        # Create the service principal
        $sp = New-MgServicePrincipal -AppId $app.AppId
        Write-Output "Created service principal with Id: $($sp.Id)"

        # Grant admin consent
        New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id -PrincipalId $sp.Id -AppRoleId "f431331c-49a6-499f-be1c-62af19c34a9d" -ResourceId $graphSpId
        Write-Output "Granted admin consent for role: f431331c-49a6-499f-be1c-62af19c34a9d"
        New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id -PrincipalId $sp.Id -AppRoleId "8116ae0f-55c2-452d-9944-d18420f5b2c8" -ResourceId $graphSpId
        Write-Output "Granted admin consent for role: 8116ae0f-55c2-452d-9944-d18420f5b2c8"

        # Create client secret
        $cred = Add-MgApplicationPassword -ApplicationId $app.Id
        Write-Output "Created client secret for application"

        $app
        $cred

        # Create and store the credential
        $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $app.AppId, (ConvertTo-SecureString -String $cred.SecretText -AsPlainText -Force)
        ########################
        Set-Secret -Name "QumTest1" -Secret $credential
        Write-Output "Created PSCredential object"

        # Output configuration to file
        $config = @"
TenantId=$($(Get-MgContext).TenantId)
AppId=$($app.AppId)
ClientSecret=$($cred.SecretText)
"@
        $configFilePath = "config.ini"
        $config | Out-File -FilePath $configFilePath -Encoding utf8
        Write-Output "Saved configuration to $configFilePath"

        Disconnect-MgGraph
    } catch {
        Write-Error "An error occurred: $_"
    }
}



function Import-ExternalItems {
    param (
        [Parameter(Mandatory = $true)]
        [Object[]] $ExternalItems
    )

    $connectionDetails = Get-Content -Path ".\connection.json" -Raw | ConvertFrom-Json

    $count = $ExternalItems.Count
    $i = 0

    $ExternalItems | ForEach-Object {
        try {
            Write-Output "Importing item with ID: $($_.id)" -ForegroundColor Yellow
            Set-MgExternalConnectionItem -ExternalConnectionId $connectionDetails.connection.id -ExternalItemId $_.id -BodyParameter $_ -ErrorAction Stop | Out-Null
            $complete = [math]::Round((++$i / $count) * 100, 0)
            Write-Progress -Activity "Importing items" -Status "$complete% Complete: $($_.id)" -PercentComplete $complete
        } catch {
            Write-Error "An error occurred while importing item with ID $($_.id): $_"
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode -eq 403) {
                Write-Output "Status Code: 403 (Forbidden)" -ForegroundColor Red
                Write-Output "Error Message: $($_.Exception.Message)" -ForegroundColor Red
                Write-Output "Make sure your application has the necessary permissions and that admin consent has been granted." -ForegroundColor Red
            }
        }
    }

    Write-Output "Import completed." -ForegroundColor Green
}

function CurrentConnection {
    try {
        $currentConnection = Get-MgContext
        if ($currentConnection) {
            $currentConnection
        } else {
            Write-Output "No existing connection." -ForegroundColor Yellow
        }
    } catch {
        Write-Error "An error occurred while fetching the current connection: $_"
    }
}

function DisconnectFromCurrentConnection {
    try {
        Disconnect-MgGraph
        Write-Output "Disconnected from the current connection." -ForegroundColor Green
    } catch {
        Write-Error "An error occurred while disconnecting: $_"
    }
}

function CreateAConnection {
    param (
        [Parameter(Mandatory = $false)]
        [string] $schemaFilePath = ".\schema.json",
        
        [Parameter(Mandatory = $false)]
        [string] $connectionFilePath = ".\connection.json"
    )
    try{
        # Load the schema from the JSON file
        Write-Output "Loading schema from $schemaFilePath"
        $schemaObjects = Get-Content -Path $schemaFilePath -Raw | ConvertFrom-Json

        # Convert each object to a hashtable
        Write-Output "Converting schema objects to hashtables"
        $schemaHashtables = $schemaObjects | ForEach-Object {
            $ht = @{}
            foreach ($prop in $_.PSObject.Properties) {
                $ht[$prop.Name] = $prop.Value
            }
            $ht
        }

        # Load the connection details from the JSON file
        Write-Output "Loading connection details from $connectionFilePath"
        $connectionDetails = Get-Content -Path $connectionFilePath -Raw | ConvertFrom-Json

        Write-Output "Loading adaptive card layout"
        [hashtable]$adaptiveCard = @{}
        $adaptiveCard += Get-Content -Path $connectionDetails.searchSettings.layoutFilePath -Raw | ConvertFrom-Json -AsHashtable
        
        $externalConnection = @{
            userId     = $($connectionDetails.userId)
            connection = @{
                id               = $($connectionDetails.connection.id)
                name             = $($connectionDetails.connection.name)
                description      = $($connectionDetails.connection.description)
                activitySettings = @{
                    urlToItemResolvers = @(
                        @{
                            "@odata.type" = "#microsoft.graph.externalConnectors.itemIdResolver"
                            urlMatchInfo  = @{
                                baseUrls   = @(
                                    $($connectionDetails.activitySettings.baseUrl)
                                )
                                urlPattern = $($connectionDetails.activitySettings.urlPattern)
                            }
                            itemId        = "$($connectionDetails.activitySettings.itemId)"
                            priority      = 1
                        }
                    )
                }
                searchSettings   = @{
                    searchResultTemplates = @(
                        @{
                            id       = $($connectionDetails.searchSettings.id) 
                            priority = 1
                            layout   = $adaptiveCard
                        }
                    )
                }
            }
            schema = $schemaHashtables
        }
        

        Write-Output
        Write-Output "Creating external connection... " -NoNewLine
        New-MgExternalConnection -BodyParameter $externalConnection.connection -ErrorAction Stop | Out-Null
        Write-Output "DONE" -ForegroundColor Green

        Write-Output "Creating schema... " -NoNewLine
        $body = @{
            baseType = "microsoft.graph.externalItem"
            properties = $externalConnection.schema
        }
        
        Update-MgExternalConnectionSchema -ExternalConnectionId $externalConnection.connection.id -BodyParameter $body -ErrorAction Stop
        Write-Output "DONE" -ForegroundColor Green

        Write-Output "Waiting for the schema to get provisioned..." -ForegroundColor Yellow -NoNewline
        do {
            $connection = Get-MgExternalConnection -ExternalConnectionId $externalConnection.connection.id
            Start-Sleep -Seconds 30
            Write-Output "." -NoNewLine -ForegroundColor Yellow
        } while ($connection.State -eq 'draft')

        Write-Output " DONE" -ForegroundColor Green
        Write-Output
    } catch {
        Write-Error "An error occurred: $_"
    }
}


function ConnecttoAConnection {
    try {
        Write-Output "Loading configuration..." -ForegroundColor Yellow
        $config = Get-Content -Path "config.ini" | ConvertFrom-StringData
        Write-Output "Loading credentials..." -ForegroundColor Yellow
        $credential = Get-Secret -Name "QumTest1"
        
        Write-Output "Connecting to Microsoft Graph..." -ForegroundColor Yellow
        Connect-MgGraph -ClientSecretCredential $credential -TenantId $config.TenantId -NoWelcome
        #Connect-MgGraph -Scopes AppRoleAssignment.ReadWrite.All, Application.ReadWrite.All -NoWelcome
        Write-Output "Successfully connected to the connection." -ForegroundColor Green
    } catch {
        Write-Error "An error occurred while connecting to the connection: $_"
    }
}

function ImportDataFromQumulo {
    try {
        Write-Output "Reading content from Qumulo..." -ForegroundColor Yellow
        $content = Read-Content
        Write-Output "Converting content to external items..." -ForegroundColor Yellow
        $externalItems = ConvertTo-ExternalItem -Content $content
        Write-Output "Importing external items..." -ForegroundColor Yellow
        Import-ExternalItems -ExternalItems $externalItems
        Write-Output "Data imported successfully from Qumulo." -ForegroundColor Green
    } catch {
        Write-Error "An error occurred while importing data from Qumulo: $_"
    }
}

function Show-Menu {
    param (
        [string]$Title = 'Welcome to Qumulo Custom Connector!'
    )
    Clear-Host
    Write-Output "================ $Title ================"
    Write-Output
    Write-Output " Please choose an option:"
    Write-Output "- Press '" -NoNewline
    Write-Output '1' -ForegroundColor Yellow -NoNewline
    Write-Output "' to initialize an Entra app."

    Write-Output "- Press '" -NoNewline
    Write-Output '2' -ForegroundColor Yellow -NoNewline
    Write-Output "' to connect to a connection."

    Write-Output "- Press '" -NoNewline
    Write-Output '3' -ForegroundColor Yellow -NoNewline
    Write-Output "' to create a new connection."

    Write-Output "- Press '" -NoNewline
    Write-Output '4' -ForegroundColor Yellow -NoNewline
    Write-Output "' to import data from a Qumulo cluster."

    Write-Output "- Press '" -NoNewline
    Write-Output 'Q' -ForegroundColor Yellow -NoNewline
    Write-Output "' to quit."
    Write-Output
    Write-Output "===================================================================="
}

do {
    Show-Menu
    $CliInput = Read-Host "Select an option"
    switch ($CliInput) {
        '1' {
            InitializeEntraApp
        }
        '2' {
            ConnecttoAConnection
        }
        '3' {
            CreateAConnection
        }
        '4' {
            ConnecttoAConnection
            ImportDataFromQumulo
        }
        'Q' {
            Write-Output "Quitting..." -ForegroundColor Green
            break
        }
        default {
            Write-Output "Invalid option, please try again." -ForegroundColor Red
        }
    }
    if ($CliInput -ne 'Q') { pause }
} while ($CliInput -ne 'Q')
