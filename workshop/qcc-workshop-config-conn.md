# Configure the Qumulo Custom Connector

### Step 1: Modify the Configuration Files

- Open the `qumulo.json` and `connection.json` files located in the QCC folder on your Desktop using your preferred text editor.
   - Available editors on the virtual desktop include Visual Studio Code, Notepad++, and Notepad.

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/explorer-showing-json-files.png" alt="File Explorer Example">
</p>
<p align="center">
  <em>Example File Explorer of the QCC directory</em>
</p>

#### Modifications to make in the `qumulo.json` file:

- In the `qumulo.json` file, update the `clusterAddress`, `shareName`, and `tempFilePath` values to match those provided in your handout.
    - For the workshop on June 6th, 2024, use the following values:

| Field            | Value                                               |
|------------------|-----------------------------------------------------|
| `clusterAddress` | anq.qcc.qumulo.net                                  |
| `shareName`      | invoices                                            |
| `tempFilePath`   | `C:\\Users\\Qumulo\\Desktop\\qcc\\Invoices_temp.txt`  |
<br> *(verify that all backslashes are escaped in the path name)* 


#### Modifications to make in the `connection.json` file:

- Change the `connection` -> `id` to a **unique** value.
   - For this workshop, you can use an easy-to-remember connection ID, such as a combination of your nickname and pet's name.
   - The connection ID must meet the following requirements:
      - Write down or save the connection ID you used for future reference.
      - For example: `grumpquat`

| Requirement       | Description                                                                          |
|-------------------|--------------------------------------------------------------------------------------|
| Allowed Characters| The connection ID can only contain alphanumeric characters (A-Z, a-z, 0-9)           |
| Length            | The ID must be between 3 and 10 characters in length                                 |
| Uniqueness        | Each connection ID must be unique within the tenant                                  |

- Update the `activitySettings` -> `baseUrl` value to match the UNC path provided in the handout.
    - For the workshop on June 6th, 2024, use: `file://anq.qcc.qumulo.net/invoices/HOSTNAME`
    - Where HOSTNAME is your computers name (Ie: `$env:COMPUTERNAME`)

| *Tip* |
|------------------------------------------------------------------------------------------------------------------------------------------|
| *HOSTNAME* is a subfolder that is precreated and has unique pdf's staged for you to work with. |
| For example: `Q://qcc-38`                                            |


1. **Options** on validating the HOSTNAME:

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/hostname.png" alt="Display hostname">
</p>

2. **Example** of edited `qumulo.json` and `connection.json` files:

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-workshop-vscode-jsons.png" alt="Example of edited config files">
</p>

### Step 2: Validate the PDF's in the ANQ SMB folder

- Mount the Qumulo invoices SMB share to the `Q:` drive
    - In another PowerShell, or Windows Command shell, run:
        `net use /persist:yes Q: \\anq.qcc.qumulo.net\invoices`
    - You can also mount the drive using Windows Explorer "Map Network Drive" 

- Inspect the Q:\HOSTNAME folder on the ANQ cluster 
    - Confirm that there are PDFs in the folder.
    - Review a few PDFs to familiarize yourself with the content.

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/list-invoices.png" alt="Invoices directory listing">
</p>
<p align="center">
  <em>Example of prestaged invoices</em>
</p>


---

<div align="right">
  <a href="qcc-workshop-holstart.md">⬅️ [Previous: Hands-On Lab]</a> | <a href="qcc-workshop-startqcc.md">[Next: Start QCC] ➡️ </a>
</div>