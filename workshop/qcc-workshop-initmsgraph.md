# Initialize Microsoft Graph

### Step 1: Initialize the Microsoft Graph Connection 

- Select QCC menu option #2 to connect to the Microsoft Graph connection.
   - This step uses the Cmdlet `Connect-MgGraph` to establish a connection to Microsoft Graph <br>

![Connect to the connection](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step2-connect-to-MSGraph.png)

---
### Step 2: Create a Microsoft Graph External Connection 

### What is a ***External Connection***?

- An external connection is a Microsoft Graph capability that allows you to connect Microsoft 365 services to external data sources.
   - In QCC, we are connecting to Microsoft Search.
   - Copilot will be using Microsoft Search to query the data using natural language processing (NLP).

- Select QCC menu option #3 to create the external connection.

![Create external connection](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step3-create-ext-conn.png)

### **What is happening in this step?**
|  Task |  Description |
|--|--|
| 1. | Loads the schema from the `schema.json` file  |
| 2. | Converts the schema objects to hashtables |
| 3. | Loads the adaptive card layout |
<br>

**This step takes a few minutes:** The duration for schema provisioning can vary significantly based on a few factors:

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/woman-waiting.png" alt="Waiting">
</p>

- **API Throttling**: Microsoft Graph API imposes throttling limits to ensure equitable usage among all users.
- **Service Performance**: The performance of the Microsoft Graph service can fluctuate based on load and resource availability on Microsoft's end.
- **Query Complexity**: Complex queries or those involving a large amount of associated data may require more time for the API to process and return the data.



### **What can be done for slow performance?**

<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/perf-gauge2.jpg" alt="Performance Gauge">
</p>

- **Check Throttling Limits**: Monitor your API usage and ensure you are not hitting throttling limits. You can also implement retry logic with exponential back-off in your script.
    - Microsoft Graph API responses include headers that indicate if throttling is occurring. Key headers to look for are:
        - `Retry-After`: Indicates how long to wait before retrying the request.
        - `x-ms-ratelimit-*`: Provides information about the rate limits and the remaining number of requests.
- **Simplify Queries**: If possible, simplify your queries to reduce the amount of data being fetched.
    - In QCC, the query is retrieving data, so there is not much to optimize.
- **Use Filters**: If the Cmdlet supports filters, use them to limit the amount of data being fetched to only what is necessary.
    - In QCC, the `Update-MgExternalConnectionSchema` Cmdlet doesn't support query filters. Instead, optimizations would require defining and updating the schema properties.  <br>


### What is ***adaptive card layout***?

- An "adaptive card" defines the logical layout used to display information in a UI in a human understandable format.
- They are commonly used in Microsoft applications such as Teams, Outlook, and Microsoft 365.
- The Qumulo Custom Connector (QCC) uses an adaptive card for displaying the invoice information on the screen in the file named `resultLayout.json`.

See this [Microsoft Learn page](https://learn.microsoft.com/en-us/outlook/actionable-messages/adaptive-card) to learn more


<p align="center">
  <img src="https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/adaptivecard_layout.jpg" alt="Example Adaptive Card">
</p>
<p align="center">
  <em>Visual example of an adaptive card layout in use.</em>
</p>

### While you wait...
- You have a few minutes to multi-task: check messages, read the powershell script, or even learn something new using <a href="https://chat.openai.com/">ChatGPT!</a>


---
<div align="right">
  <a href="qcc-workshop-startqcc.md">⬅️ [Previous: Start QCC]</a> | <a href="qcc-workshop-import-invoices.md">[Next: Import Invoices] ➡️ </a>
</div>