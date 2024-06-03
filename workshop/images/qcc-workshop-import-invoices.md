# Import Invoices

This step involves the integration with Azure Native Qumulo. The invoices are stored in an SMB share on the cluster. QCC reads the invoices and converts them into external item objects so they can be loaded into Microsoft Graph.

### Step 1: Select QCC menu option #4 to import the invoices stored on Azure Native Qumulo (ANQ)

- Select option '4' to import the invoices.
- Enter the **QumuloSecret vault password** you created earlier in the workshop. (*The easy to remember one!*)

![QCC input password](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-step4-enterpassword.png?raw=true)

**What is happening in this step?**

| Task | Description |
|------|-------------|
| 1.   | Reads the invoices stored on the ANQ cluster. |
| 2.   | Converts the invoices into an external item data structure. |
| 3.   | Imports the external items into Microsoft Graph. |

The PDFs will be listed on the screen as they are imported, as shown in the example below. <br>

![Importing invoices](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-importing-invoices-38percent.png?raw=true)

---
| [Previous: Initialize Microsoft Graph ](qcc-workshop-initmsgraph.md) | [Next: Connect MS Graph to MS Search](qcc-workshop-connect-msgraph-search.md) |  