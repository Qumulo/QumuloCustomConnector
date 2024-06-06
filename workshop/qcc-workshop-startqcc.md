# Start the Qumulo Custom Connector

---
### Step 1: Run the Qumulo Custom Connector PowerShell Script

- In a PowerShell 7 shell:
     - The default directory is set to `$env:USERPROFILE\Desktop\qcc`  <br>
![Powershell command shell](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-powershell-cd-qcc-dir.png)
- Type `QumuloCustomConnector.ps1` (or tab complete twice) and hit enter to start the script

---
### Step 2: Select QCC menu selection #1 to initialize QCC

1. Select option '1' to initialize the Qumulo Custom Connector. <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-menu.png)

2. An Internet Explorer browser will open for you to authenticate: <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step1-microsoft-signin.png)
<br>
3. Use the *Entra username* and *Entra password* provided in the handout to sign in.

**What is happening when initializing QCC?**
|  Task |  Description |
|--|--|
| 1. | Loads the settings in the `connections.json` file  |
| 2. | Create a connection to Microsoft Graph |
| 3. | Creates a Graph Service Principal with admin rights  |
| 4. | Creates and stores the clients secret (used for the application object)  |
| 5. | Saves the config to a file named `config.ini`  |

**Note:** Once authenticated you can close the Internet Explorer browser window. 

4. When prompted, enter a QumuloSecret vault password.
    - Use an easy to remember short phrase such as `changeme`, `password`, or `letmein`. 
    - Enter the password a second time for verification.
    - **Remember what you used!** <br><br>
    
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step1-output.png)
<br>
 - Press **Enter** to return to the main menu.  <br><br>

**Note:** The `config.ini` file stores user identity and credentials: 
|  |  |
|--|--|
| `TenantId`  | A dedicated instance of Azure AD used for authentication, for example |
| `AppId` | Unique identifier for a registered application in Azure AD. | 
| `ClientSecret` | Encrypted credential used to confirm the application’s identity |


---
<div align="right">
  <a href="qcc-workshop-config-conn.md">⬅️ [Previous: Configure QCC]</a> | <a href="qcc-workshop-initmsgraph.md">[Next: Initialize Microsoft Graph] ➡️ </a>
</div>