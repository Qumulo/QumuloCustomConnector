# Start the Qumulo Custom Connector

---
### Step 1: Run the Qumulo Custom Connector Powershell Script

- In a PowerShell 7 shell:
     - Change directory to $env:USERPROFILE\Desktop\qcc 
  `cd $env:USERPROFILE\Desktop\qcc`  <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-powershell-cd-qcc-dir.png?raw=true)
  
- Hit enter to start the `QumuloCustomConnector.ps1` script

---
### Step 2: Select QCC menu selection #1 to initialize QCC

1. Select option '1' to initialize the Qumulo Custom Connector. <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-menu.png?raw=true)

2. An Internet Explorer browser will open for you to authenticate: <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step1-microsoft-signin.png?raw=true)
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

4. When prompted, enter a QumuloSecret vault password of your choice.
    - Use an easy to remember short phrase such as `changeme`. 
    - Enter the password a second time for verification.
    - **Remember what you used!** <br><br>
    
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step1-output.png?raw=true)
<br>
 - Press **Enter** to return to the main menu.  <br><br>

**Note:** The `config.ini` file created in this step contains 3 entries: 
|  |  |
|--|--|
| `TenantId`  | A dedicated instance of Azure AD used for authentication, for example |
| `AppId` | Unique identifier for a registered application in Azure AD. | 
| `ClientSecret` | Encrypted credential used to confirm the application’s identity |


---
| [Previous: Configure QCC](qcc-workshop-config-conn.md) | [Next: Initialize Microsoft Graph ](qcc-workshop-initmsgraph.md) |
