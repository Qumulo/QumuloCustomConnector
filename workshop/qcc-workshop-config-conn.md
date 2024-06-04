# Configure the Qumulo Custom Connector

### Step 1: Modify the configuration files 

- Using your editor of choice, open `qumulo.json` and `connection.json` located in the QCC folder on your Desktop.
   - Visual Studio Code, Notepad++, and Notepad are available on the virtual desktop.

#### Changes to make to **qumulo.json:**

- In the `qumulo.json` file, change the `clusterAddress` and `shareName` to match the values provided in your handout.
- Set the `tempFilePath` to `C:\\Users\\Qumulo\\Desktop\\qcc\\Invoices_temp.txt` 
    - *Example of edited qumulo.json and connection.json files are after the instructions*

#### Changes to make to **connection.json**

- In the `connection.json` file, update the `baseUrl`-> `activitySetting` similarly.
- In the `connection.json` file, set the `appSecretName` to a **unique** value
   - For this workshop you can use an easy-to-remember connection ID, such as your nickname and pet name combined.
      - Write the connection ID you used in this step down or save it on your laptop for future use.
      - For example: *kmaconyxia*
   - Here are the connection ID requirements:

|Requirement|Description  |
|--|--|
|Allowed Characters|The connection ID can only contain alphanumeric characters (A-Z, a-z, 0-9)  |
| Length | The ID must be between 3 and 10 characters in length |
| Uniqueness | Each connection ID must be unique within the tenant |


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
