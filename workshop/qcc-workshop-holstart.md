# Hands-On Lab 

### Review the Qumulo Custom Connector PowerShell Script

### Step 1. Review of the QumuloCustomerConnector.ps1 PowerShell script

- In the PowerShell 7 command window launched in the previous step, cd to `C:\Users\Qumulo\Desktop\qcc`
   - Do not launch the script yet! We still need to configure QCC before running the script *(coming up)*

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-open-pwsh.png?raw=true" alt="QCC in pwsh">
</p>
<p align="center">
  <em>Qumulo Custom Connector in PowerShell</em>
</p>

### Step 2. Let's get acquainted with the functions used in QumuloCustomerConnector.ps1

| **Function**                         | **Description**                                                                                         |
|--------------------------------------|---------------------------------------------------------------------------------------------------------|
| <span style="color: #3dd6d0;">Read-Content</span>         | - Loads configuration from `qumulo.json`.<br> - Scans specified directory on a Qumulo cluster for PDF files.<br> - Converts PDFs to text using `pdftotext`.<br> - Extracts details like date, invoice number, customer info, etc., using regex.<br> - Outputs structured invoice details. |
| <span style="color: #3dd6d0;">ConvertTo-ExternalItem</span> | Converts extracted invoice details into a format suitable for importing into Microsoft Graph.            |
| <span style="color: #3dd6d0;">Import-ExternalItems</span>  | Imports external items (invoices) into a Microsoft Graph connection.                                     |
| <span style="color: #3dd6d0;">InitializeEntraApp</span>    | Initialize the connection to Entra.                                                                      |
| <span style="color: #3dd6d0;">CurrentConnection</span>     | Displays the current connection to Microsoft Graph.                                                      |
| <span style="color: #3dd6d0;">DisconnectFromCurrentConnection</span> | Disconnects the current connection to Microsoft Graph.                                       |
| <span style="color: #3dd6d0;">CreateAConnection</span>     | Creates a new connection and schema in Microsoft Graph.                                                  |
| <span style="color: #3dd6d0;">ConnecttoAConnection</span>  | Connects to Microsoft Graph using stored credentials.                                                    |
| <span style="color: #3dd6d0;">ImportDataFromQumulo</span>  | Orchestrates reading, converting, and importing data from Qumulo to Microsoft Graph.                     |
| <span style="color: #3dd6d0;">Show-Menu</span>             | Displays a menu for selecting different actions (initialize app, connect, create connection, import data). |
---

- The Qumulo Custom Connector requires four configuration files. Detailed information about each file is available in the [GitHub readme file](https://github.com/Qumulo/QumuloCustomConnector/blob/main?tab=readme-ov-file#configuration-files).

- In this lab, we will customize two files: `qumulo.json` and `connection.json`. The other two files are pre-configured, but you should review them to understand how they can be used in your own projects.

---
<div align="right">
  | <a href="qcc-workshop-virtualdesktop.md">[Previous: Your Virtual Desktop]</a> | <a href="qcc-workshop-config-conn.md">[Next: Configure the Qumulo Custom Connector]</a> |
</div>
