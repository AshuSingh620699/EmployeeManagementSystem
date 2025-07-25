<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaveManagement.aspx.cs" Inherits="EmployeeManagementSystem.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Leave Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center">Leave Management</h2>
            <asp:Repeater ID="rptLeaveRequests" runat="server" OnItemCommand="rptLeaveRequests_ItemCommand">
                <HeaderTemplate>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Leave ID</th>
                                <th>Employee Name</th>
                                <th>Leave Dates</th>
                                <th>Reason</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("LeaveID") %></td>
                        <td><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                        <td>
                            <%# Eval("LeaveDateFrom", "{0:yyyy-MM-dd}") %> to <%# Eval("LeaveDateTo", "{0:yyyy-MM-dd}") %>
                        </td>
                        <td><%# Eval("Reason") %></td>
                        <td>
                            <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="Approve" CommandArgument='<%# Eval("LeaveID") %>' CssClass="btn btn-success" />
                            <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="Reject" CommandArgument='<%# Eval("LeaveID") %>' CssClass="btn btn-danger" />
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

