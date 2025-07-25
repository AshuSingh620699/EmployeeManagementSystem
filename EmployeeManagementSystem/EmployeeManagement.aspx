<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeManagement.aspx.cs" Inherits="EmployeeManagementSystem.EmployeeManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Management</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            padding: 20px;
        }

        /* GridView styling */
        .gridview-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

            .gridview-container table {
                width: 100%;
                border-collapse: collapse;
                text-align: left;
            }

            .gridview-container th, .gridview-container td {
                padding: 12px 15px;
                border: 1px solid #e0e0e0;
            }

            .gridview-container th {
                background-color: #4CAF50;
                color: white;
                font-weight: bold;
            }

            .gridview-container td {
                background-color: #fafafa;
            }

            .gridview-container tr:hover {
                background-color: #f1f1f1;
            }

            /* Edit and Delete buttons styling */
            .gridview-container .aspNetBtn {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 8px 16px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 5px;
            }

                .gridview-container .aspNetBtn:hover {
                    background-color: #45a049;
                }

            /* Input fields styling */
            .gridview-container input[type="text"] {
                width: 100%;
                padding: 8px 10px;
                margin-top: 5px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }

                .gridview-container input[type="text"]:focus {
                    border-color: #4CAF50;
                    outline: none;
                }

        /* Button styling for Add Employee */
        #btnAddEmployee {
            background-color: #008CBA;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

            #btnAddEmployee:hover {
                background-color: #007B9F;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="gridview-container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EmployeeID"
                OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting"
                OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit">
                <Columns>
                    <asp:BoundField DataField="EmployeeID" HeaderText="ID" ReadOnly="True" SortExpression="EmployeeID" />
                    <asp:TemplateField HeaderText="First Name">
                        <ItemTemplate>
                            <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("FirstName") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Eval("FirstName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name">
                        <ItemTemplate>
                            <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("LastName") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("LastName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Username">
                        <ItemTemplate>
                            <asp:Label ID="lblusername" runat="server" Text='<%# Eval("column_username") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtusername" runat="server" Text='<%# Eval("column_username") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("Phone") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Department">
                        <ItemTemplate>
                            <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDepartment" runat="server" Text='<%# Eval("Department") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Join Date">
                        <ItemTemplate>
                            <asp:Label ID="lblJoinDate" runat="server" Text='<%# Eval("JoinDate") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtJoinDate" runat="server" Text='<%# Eval("JoinDate") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStatus" runat="server" Text='<%# Eval("Status") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnAddEmployee" runat="server" Text="Add Employee" OnClick="btnAddEmployee_Click" />
        </div>
    </form>
</body>
</html>
