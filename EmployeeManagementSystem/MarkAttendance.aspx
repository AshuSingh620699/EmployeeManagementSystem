<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarkAttendance.aspx.cs" Inherits="EmployeeManagementSystem.MarkAttendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }

        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center">Mark Attendance</h2>
            
            <asp:Repeater ID="rptAttendance" runat="server" OnItemCommand="rptAttendance_ItemCommand" OnItemDataBound="rptAttendance_ItemDataBound">
    <HeaderTemplate>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Attendance Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Eval("EmployeeID") %></td>
            <td><%# Eval("FirstName") %></td>
            <td><%# Eval("LastName") %></td>
            <td>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Text="Present" Value="Present" />
                    <asp:ListItem Text="Absent" Value="Absent" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Eval("EmployeeID") %>' CssClass="btn btn-primary" />
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

        </div>
    </form>
</body>
</html>

