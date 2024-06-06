# Connect Microsoft Graph to Microsoft Search

### Step 1: Stage the Microsoft Graph connection ID you created in the previous steps
1. Open the Microsoft Edge web browser by clicking its icon on your desktop.
2. Navigate to the [Microsoft 365 admin center](https://admin.microsoft.com/) by entering the URL `https://admin.microsoft.com/` in the address bar.
    - Log in using your **Entra** username and password.
    - Once logged in, the web page will resemble the screenshot below. <br>
    
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-admin-center.png)

3. Open the "Search & intelligence" page by navigating the right-hand menu ("Show all > Settings > Search & intelligence")
    - **"Show all"** is on the bottom of the left-hand menu under "Microsoft 365 admin center"
    - **"Settings"** will appear a once you click "Show all"
    - **"Search & Intelligence"** will appear after you click "Settings"

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-adminctr-showall.png" alt="Show All" style="width: 200px;">
      <p><em>"Show All" location in menu</em></p>
    </td>
    <td align="center">
      <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-adminctr-settings.png" alt="Settings" style="width: 200px;">
      <p><em>"Settings" location in menu</em></p>
    </td>
    <td align="center">
      <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-adminctr-search.png" alt="Search" style="width: 200px;">
      <p><em>"Search & Intelligence" location in menu</em></p>
    </td>
  </tr>
</table>

4. Navigate to "Data Sources", the third tab under "Search & intelligence".

![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-search-intel-data-sources.png)

5. Locate the connection ID you created in the previous steps.  
    - Recall that the connection ID is unique and we suggested using your nickname and pet name combined. 
    - *Click on **"Display all connections"** if yours is not listed on the page.*

![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-search-intel-find-conn.png)

6. Click "Add staging" to the left of your connection ID
    *- This will being up a frame on the right side of the browser.* 

7. Enter "All Company", under "Select users and user groups"
   - Select the "All Company" group when it appears below. <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-search-intel-add-all-company.png)
   - Click save and then close.
    *- This will bring you back to the Search & Intelligence main page*

8. Click the "Include Connector Results" link to the left of  your connection ID, and then click OK. <br>
![enter image description here](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/ms365-search-intel-include-conn-results.png)

#### What just happened? 
- You linked the Microsoft Graph connection you created to Microsoft Search & Intelligence!
- The data ingest into Microsoft Search can take a few minutes time, but for now you can proceed to the next step.

---
<div align="right">
  <a href="qcc-workshop-import-invoices.md">⬅️ [Previous: Import Invoices]</a> | <a href="qcc-workshop-connect-copilot.md">[Next: Using Copilot to Query Images] ➡️ </a>
</div>