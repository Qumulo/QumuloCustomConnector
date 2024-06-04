
# Connecting to the Workshop 

This workshop is designed to run the Qumulo Custom Connector (QCC) on a Windows 10 workstation with the necessary QCC prerequisites pre-installed and configured to save you time.

- You were provided a handout when you walked in the room that has your assigned Windows 10 Workstation IP Address, RDP login username, and RDP login password printed on it.
- We will be using the <span style="color: #00a4ef;">Microsoft Remote Desktop</span> application to connect to your personally assigned Windows 10 Workstation.

### Microsoft Windows Desktops

- Download the Remote Desktop app from the [Microsoft Store](https://www.microsoft.com/store/p/microsoft-remote-desktop/9wzdncrfj3ps).
- Installation:
  1. Install and launch the application.
  2. Add a Remote Desktop Connection:
     - In the app, click on the **+ Add** button and select **PC**.
     - Use the IP address provided on the handout for the **PC name**.
  3. Under the **User account** section, enter the Username and Password provided on the handout.
  4. Click **Save**.

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-microsoft-rdp-settings.png?raw=true" alt="RDP settings">
</p>
<p align="center">
  <em>Example Windows RDP settings</em>
</p>

### Apple MacOS Desktops

- Download the application from the [Mac App Store](https://itunes.apple.com/app/microsoft-remote-desktop/id1295203466?mt=12).
- Installation:
  1. Install and launch the application.
  2. Click on **PCs** and then the **+** sign to add a PC.
  3. For the **PC name**, use your specific IP address on the handout.
     - Each attendee has been provided their own personal virtual desktop for this workshop. Your IP address is unique and will only allow a single RDP connection.
  4. For the **User account**, click on the drop-down and select **Add user account**.
  5. Enter the Username and Password from the handout.
  6. Under **General**, provide a friendly name, such as "QCC Copilot Workshop".
     - *[Optional]* Adjust other settings to suit your personal preferences, such as whether or not to start in full screen.
  7. Click **Add**.

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-macos-rdp-settings.png?raw=true" alt="MacOS RDP settings">
</p>
<p align="center">
  <em>Example MacOS RDP settings</em>
</p>
---

### Your Virtual Desktop

1. **Log In**
   - Click the RDP connection in the Remote Desktop Application.
      - Be sure you are using the IP address, username, and password from your handout.
   - You will see a PowerShell command window running - *do not close this window or otherwise interrupt this process*.
   - PowerShell 7 is installing the prerequisites for QCC during the first login.

   ![Installation](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-login-script-installing-microsoft-graph.png?raw=true)

2. **Deploying Outside the Workshop**
   - Follow the prerequisite instructions on the [GitHub page](https://github.com/Qumulo/QumuloCustomConnector).

3. **Pre-Installed Software on Your Virtual Desktop**
   - **PowerShell 7.0**
   - **Microsoft Graph PowerShell SDK**
   - **XPDF Tools**
   - **PowerShell Modules:**
     - `Microsoft.Graph`
     - `Microsoft.PowerShell.SecretManagement`
     - `Microsoft.PowerShell.SecretStore`
     - `Register-SecretVault`

4. **Additional Instructions**
   - Follow any extra install/configuration instructions from the lab instructor.
   - **Launch PowerShell 7:**
     - Click the magnifier icon and search for `powershell 7`.

   ![PowerShell 7](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/powershell7-launch.png?raw=true)

---
<div align="right">
  <a href="qcc-workshop.md">[Previous: Workshop Start]</a> | <a href="qcc-workshop-holstart.md">[Next: Hands-On Lab]</a>
</div>
