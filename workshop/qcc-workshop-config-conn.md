# Configure the Qumulo Custom Connector

### Step 1: Modify the configuration files 

- Using your editor of choice, open `qumulo.json` and `connection.json` located in the qcc folder on your Desktop.
   - Visual Studio Code, Notepad++, and Notepad are available on the virtual desktop.

![Opening the Config Files with Notepad++](https://github.com/Qumulo/QumuloCustomConnector/blob/main/workshop/images/qcc-open-config-files-confs.png?raw=true)

#### Changes to make to **qumulo.json:**

- In the `qumulo.json` file, change the `clusterAddress` and `shareName` to match the values provided in your handout.
- Set the `tempFilePath` to `C:\\Users\Qumulo\Desktop\qcc\Invoices_temp.txt` 

#### Changes to make to **connection.json**

- In the `connection.json` file, update the `baseUrl`-> `activitySetting` similarly.
- In the `connection.json` file, set the `appSecretName` to a **unique** value
   - For this workshop you can use an easy-to-remamber connection ID, such as your nickname and pet name combined.
      - For example: *kmaconyxia*
   - Here are the connection ID requirements:

|Requirement|Description  |
|--|--|
|Allowed Characters|The connection ID can only contain alphanumeric characters (A-Z, a-z, 0-9)  |
| Length | The ID must be between 3 and 10 characters in length |
| Uniqueness | Each connection ID must be unique within the tenant |

Example **qumulo.json** file:

```
{
    "clusterAddress" : "10.0.0.4",  # Use the ANQ IP Address on the handout
    "shareName" : "invoices",       # Use the share name on the handout
    "filePrefix" : "*.pdf",
    "tempFilePath" : "C:\\Invoice_Temp.txt"
}
```
Example **connection.json** file:
```
{
    "appDisplayName" : "Content Search on Qumulo",
    "appSecretName" : "kmaconyxia",
    "userId" : "71608eb0-9c49-4a21-a77b-f8f3d66d4289",
    "connection" :{
        "id" : "QumuloConnector",
        "name" : "Invoice Data on Qumulo",
        "description" : "Invoice data including products, amounts, and customer details"
    },
    "activitySettings" : {
        "baseUrl" : "file://10.0.0.4/invoices/",  # Use the information from the handout
        "urlPattern" : "/Invoice(?<invoiceNumber>[^/]+).pdf",
        "itemId" : "{invoiceNumber}"
    },
    "searchSettings":{
        "id" : "invoiceTemplate",
        "layoutFilePath" : ".\\resultLayout.json" 
    }
}
```

---
<div align="right">
  | [Previous: Hands-On Lab](qcc-workshop-holstart.md) | [Next: Start QCC](qcc-workshop-startqcc.md) |
</div>
