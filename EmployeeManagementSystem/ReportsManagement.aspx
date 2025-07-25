<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportsManagement.aspx.cs" Inherits="EmployeeManagementSystem.ReportsManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Management</title>
    <!-- Bootstrap CSS -->
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
        <div class="container mt-5">
            <h2 class="text-center">Report Management</h2>

            <!-- Tab Navigation -->
            <ul class="nav nav-tabs" id="reportTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="salary-tab" data-bs-toggle="tab" href="#salary" role="tab" aria-controls="salary" aria-selected="true">Salary Report</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="attendance-tab" data-bs-toggle="tab" href="#attendance" role="tab" aria-controls="attendance" aria-selected="false">Attendance Report</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="employee-tab" data-bs-toggle="tab" href="#employee" role="tab" aria-controls="employee" aria-selected="false">Employee Report</a>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content mt-3" id="reportTabContent">
                <!-- Salary Report -->
                <div class="tab-pane fade show active" id="salary" role="tabpanel" aria-labelledby="salary-tab">
                    <h4>Salary Report</h4>
                    <asp:Repeater ID="rptSalaryReport" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Employee ID</th>
                                        <th>Name</th>
                                        <th>Department</th>
                                        <th>Month</th>
                                        <th>Year</th>
                                        <th>Gross Salary</th>
                                        <th>Deduction</th>
                                        <th>Net Salary</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("EmployeeID") %></td>
                                <td><%# Eval("FirstName") %></td>
                                <td><%# Eval("Department") %></td>
                                <td><%# Eval("Month") %></td>
                                <td><%# Eval("Year") %></td>
                                <td><%# Eval("GrossSalary") %></td>
                                <td><%# Eval("Deductions") %></td>
                                <td>$<%# Eval("NetSalary", "{0:N2}") %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnDownloadSalary" runat="server" Text="Download Salary Report" CssClass="btn btn-success mt-3" OnClick="btnDownloadSalary_Click" />
                </div>
            </div>

            <!-- Attendance Report -->
            <div class="tab-pane fade" id="attendance" role="tabpanel" aria-labelledby="attendance-tab">
                <h4>Attendance Report</h4>
                <asp:Repeater ID="rptAttendanceReport" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Employee ID</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Date", "{0:yyyy-MM-dd}") %></td>
                            <td><%# Eval("EmployeeID") %></td>
                            <td><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                            <td><%# Eval("Status") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                            </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:Button ID="btnDownloadAttendance" runat="server" Text="Download Attendance Report" CssClass="btn btn-success mt-3" OnClick="btnDownloadAttendance_Click" />
            </div>

            <!-- Employee Report -->
            <div class="tab-pane fade" id="employee" role="tabpanel" aria-labelledby="employee-tab">
                <h4>Employee Report</h4>
                <asp:Repeater ID="rptEmployeeReport" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Employee ID</th>
                                    <th>Name</th>
                                    <th>Department</th>
                                    <th>Join Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("EmployeeID") %></td>
                            <td><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                            <td><%# Eval("Department") %></td>
                            <td><%# Eval("JoinDate", "{0:yyyy-MM-dd}") %></td>
                            <td><%# Eval("Status") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                            </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:Button ID="btnDownloadEmployee" runat="server" Text="Download Employee Report" CssClass="btn btn-success mt-3" OnClick="btnDownloadEmployee_Click" />
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
