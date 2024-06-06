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

#### Modifications to make in the **qumulo.json** File:

- In the `qumulo.json` file, update the `clusterAddress`, `shareName`, and `tempFilePath` values to match those provided in your handout.
    - For the workshop on June 6th, 2024, use the following values:
        - `clusterAddress`: `anq.qcc.qumulo.net`
        - `shareName`: `invoices`
        - `tempFilePath`: `C:\\Users\\Qumulo\\Desktop\\qcc\\Invoices_temp.txt` <br>
            *(We need to ensure that all backslashes are escaped in the path name)*

    - An example of edited `qumulo.json` and `connection.json` files is provided further down on this page.

#### Modifications to make in the **connection.json** File:

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
    - For the workshop on June 6th, 2024, use: `file://anq.qcc.qumulo.net/invoices/UNIQUE_NAME`

| *Tip* |
|------------------------------------------------------------------------------------------------------------------------------------------|
| *UNIQUE_NAME* is a subfolder where you can save the workshop invoices (PDFs). <br> Choose something that is unique and easy for you to remember. |
| For example: `file://anq.qcc.qumulo.net/invoices/grumpquat`                                                                              |

- Next, create a uniquely named sub-directory in `\\anq.qcc.qumulo.net\invoices`.
> For example, in PowerShell you can run `mkdir \\anq.qcc.qumulo.net\invoices\grumpquat` *(but use the name you chose!)*

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