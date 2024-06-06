# Configure the Qumulo Custom Connector

### Step 1: Modify the configuration files 

- Using your editor of choice, open `qumulo.json` and `connection.json` located in the QCC folder on your Desktop.
   - Visual Studio Code, Notepad++, and Notepad are available on the virtual desktop.

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/explorer-showing-json-files.png" alt="File Explorer Example">
</p>
<p align="center">
  <em>Example File Explorer of qcc directory</em>
</p>

#### Modifications for the **qumulo.json:** file

- In the `qumulo.json` file, change the `clusterAddress`, `shareName`, and `tempFilePath` to match the values provided in your handout.
    - For the workshop on June 6th, 2024, we are using:
        - "**anq.qcc.qumulo.net**" for the `clusterAddress`
        - "**invoices**" for the `shareName`
        - "`C:\\Users\\Qumulo\\Desktop\\qcc\\Invoices_temp.txt`" for the `tempFilePath`

    - *Example of edited qumulo.json and connection.json files are further down on this page.* 

#### Modifications for the **connection.json** file

- Change the `connection` -> `id` to a **unique** value
   - For this workshop you can use an easy-to-remember connection ID, such as your nickname and pet name combined.
   - The connection ID naming requirements *(below)*, require that these are unique for all attendees. *(Don't use special characters, and 3 -> 10 characters in length.)*
      - Write the connection ID you used in this step down or save it on your laptop for future use.
      - For example: *kmacsdad*

|Requirement|Description  |
|--|--|
|Allowed Characters|The connection ID can only contain alphanumeric characters (A-Z, a-z, 0-9)  |
| Length | The ID must be between 3 and 10 characters in length |
| Uniqueness | Each connection ID must be unique within the tenant |

  - Update the `activitySettings` -> `baseUrl` value to match the UNC path in the handout
    - For the workshop on June 6th, 2024, we are using "`file://anq.qcc.qumulo.net/invoices/UNIQUE_NAME`" <br>

| *UNIQUE_NAME* is a subfolder where you can save the workshop invoices (pdf's) in. Choose something that is unique and easy for you to remember. |
|--------------------------------------------------------------------------------------------------------------------------------|
| For example: "`file://anq.qcc.qumulo.net/invoices/grumpquat`"                                                                  |

- Next, create a uniquely named sub-directory in `\\anq.qcc.qumulo.net\invoices`.
> For example, in PowerShell you can run *mkdir `\\anq.qcc.qumulo.net\invoices\grumpquat`* (but use the name you chose!)


<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-workshop-vscode-jsons.png" alt="Example of edited config files">
</p>
<p align="center">
  <em>Example of edited qumulo.json and connection.json files</em>
</p>

---
<div align="right">
  <a href="qcc-workshop-holstart.md">⬅️ [Previous: Hands-On Lab]</a> | <a href="qcc-workshop-startqcc.md">[Next: Start QCC] ➡️ </a>
</div>
