<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarkSalaryManagement.aspx.cs" Inherits="EmployeeManagementSystem.MarkSalaryManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Salary Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center my-3">Salary Management</h2>

            <!-- Add Payslip Button -->
            <div class="mb-3 text-end">
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addPayslipModal">Add Payslip</button>
            </div>

            <asp:Repeater ID="rptSalaryManagement" runat="server" OnItemCommand="rptSalaryManagement_ItemCommand">
                <HeaderTemplate>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Name</th>
                                <th>Month</th>
                                <th>Year</th>
                                <th>Gross Salary</th>
                                <th>Deductions</th>
                                <th>Net Salary</th>
                                <th>Generated Date</th>
                                <th>Salary</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("EmployeeID") %></td>
                        <td><%# Eval("EmployeeName") %></td>
                        <td><%# Eval("Month") %></td>
                        <td><%# Eval("Year") %></td>
                        <td>$<%# Eval("GrossSalary", "{0:N2}") %></td>
                        <td>$<%# Eval("Deductions", "{0:N2}") %></td>
                        <td>$<%# Eval("NetSalary", "{0:N2}") %></td>
                        <td><%# Eval("GeneratedDate", "{0:yyyy-MM-dd}") %></td>
                        <td>
                            <asp:TextBox ID="txtNewSalary" runat="server" CssClass="form-control" placeholder="Enter new salary" />
                        </td>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Save" CommandArgument='<%# Eval("PayslipID") %>' CssClass="btn btn-primary" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <!-- Add Payslip Modal -->
            <div class="modal fade" id="addPayslipModal" tabindex="-1" aria-labelledby="addPayslipModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addPayslipModalLabel">Add New Payslip</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="ddlEmployee" class="form-label">Employee</label>
                                <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="mb-3">
                                <label for="txtMonthYear" class="form-label">Month-Year</label>
                                <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control" placeholder="MM-YYYY"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtYear" class="form-label">Month-Year</label>
                                <asp:TextBox ID="txtYear" runat="server" CssClass="form-control" placeholder="MM-YYYY"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtGrossSalary" class="form-label">Gross Salary</label>
                                <asp:TextBox ID="txtGrossSalary" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtDeductions" class="form-label">Deductions</label>
                                <asp:TextBox ID="txtDeductions" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnAddPayslip" runat="server" Text="Add Payslip" CssClass="btn btn-success" OnClick="btnAddPayslip_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

