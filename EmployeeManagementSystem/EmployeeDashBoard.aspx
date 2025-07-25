<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeDashBoard.aspx.cs" Inherits="EmployeeManagementSystem.EmployeeDashBoard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fffbea;
            color: #333;
        }

        .navbar {
            background-color: #f7d774;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .navbar h1 {
                margin: 0;
                color: #333;
            }

        .nav-links a {
            margin-left: 20px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }

            .nav-links a:hover, .nav-links .active {
                text-decoration: underline;
                color: #d45f00;
            }

        .section {
            margin: 20px;
            padding: 20px;
            background-color: #fff7d4;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin: 10px 0;
            background-color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .card h3 {
                margin: 0;
            }

        /* Style for the container inside the UpdatePanel */
        .updatepanel-container {
            padding: 20px;
            background-color: transparent;
            opacity: 0.8;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

            .updatepanel-container h3 {
                font-weight: 600;
            }

            /* Style for textboxes */
            .updatepanel-container input[type="text"],
            .updatepanel-container input[type="email"],
            .updatepanel-container input[type="password"],
            .updatepanel-container textarea {
                width: 90%;
                padding: 10px 12px;
                margin: 10px 0;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

                .updatepanel-container input[type="text"]:focus,
                .updatepanel-container input[type="email"]:focus,
                .updatepanel-container input[type="password"]:focus,
                .updatepanel-container textarea:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                    outline: none;
                }

            /* Style for buttons */
            .updatepanel-container button,
            .updatepanel-container input[type="submit"],
            .updatepanel-container input[type="button"] {
                padding: 10px 15px;
                margin: 10px 5px 0 0;
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
            }

                .updatepanel-container button:hover,
                .updatepanel-container input[type="submit"]:hover,
                .updatepanel-container input[type="button"]:hover {
                    background-color: #0056b3;
                    transform: translateY(-2px);
                }

                .updatepanel-container button:active,
                .updatepanel-container input[type="submit"]:active,
                .updatepanel-container input[type="button"]:active {
                    background-color: #004085;
                    transform: translateY(0);
                }

            /* Add spacing between labels and textboxes/buttons */
            .updatepanel-container label {
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 5px;
                display: block;
                color: #333;
            }

        /* Responsive design */
        @media (max-width: 768px) {
            .updatepanel-container {
                padding: 15px;
            }

                .updatepanel-container input[type="text"],
                .updatepanel-container input[type="email"],
                .updatepanel-container input[type="password"],
                .updatepanel-container textarea {
                    font-size: 12px;
                    padding: 8px 10px;
                }

                .updatepanel-container button,
                .updatepanel-container input[type="submit"],
                .updatepanel-container input[type="button"] {
                    font-size: 12px;
                    padding: 8px 12px;
                }
        }

        /*Leave Panel*/
        /* Style for the Leave Application Panel */
        #pnlLeaveApplication {
            background-color: transparent;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 40px auto;
            font-family: 'Arial', sans-serif;
        }

            /* Heading Style */
            #pnlLeaveApplication h2 {
                font-size: 20px;
                font-weight: 700;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            /* Textboxes styling */
            #pnlLeaveApplication input[type="text"],
            #pnlLeaveApplication input[type="date"],
            #pnlLeaveApplication textarea {
                width: 90%;
                padding: 12px;
                font-size: 14px;
                margin-bottom: 15px;
                border-radius: 5px;
                border: 1px solid #ccc;
                background-color: #fff;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

                /* Focused state for input fields */
                #pnlLeaveApplication input[type="text"]:focus,
                #pnlLeaveApplication input[type="date"]:focus,
                #pnlLeaveApplication textarea:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                    outline: none;
                }

            /* Button styling */
            #pnlLeaveApplication .btn {
                padding: 12px 15px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                width: 100%;
                margin-top: 10px;
            }

                #pnlLeaveApplication .btn:hover {
                    background-color: #0056b3;
                    transform: translateY(-2px);
                }

                #pnlLeaveApplication .btn:active {
                    background-color: #004085;
                    transform: translateY(0);
                }

            /* Message Label styling */
            #pnlLeaveApplication #lblLeaveMessage {
                display: block;
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
                font-weight: 500;
                color: #28a745; /* Green color for success messages */
            }

        /* Responsive styling for smaller screens */
        @media (max-width: 600px) {
            #pnlLeaveApplication {
                padding: 15px;
                max-width: 90%;
            }

                #pnlLeaveApplication h2 {
                    font-size: 18px;
                }

                #pnlLeaveApplication .btn {
                    font-size: 14px;
                    padding: 10px 12px;
                }
        }

        /*Attendence*/
        /* Overall Panel */
        .attendance-panel {
            margin: 30px auto;
            max-width: 90%; /* Make the table and panel take up more space */
            font-family: 'Arial', sans-serif;
        }

        /* Card Customization */
        .card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .bg-light-yellow {
            background-color: #fff9db; /* Soft yellow background */
        }

        .card-header {
            background-color: #ffc107; /* Bright yellow */
            color: #343a40; /* Dark text for better contrast */
            text-align: center;
            font-size: 1.6rem;
            font-weight: bold;
            padding: 15px;
        }

        /* Table Customization */
        .table-modern {
            font-size: 1.2rem;
            width: 100%; /* Full width */
            border: 1px solid #e5e5e5;
        }

            .table-modern thead {
                background-color: #ffc107; /* Match yellow theme */
                color: #343a40;
                font-weight: bold;
            }

            .table-modern tbody tr:hover {
                background-color: #fff4b2; /* Subtle hover effect in yellow */
            }

            .table-modern tbody tr {
                border-bottom: 1px solid #e5e5e5;
            }

            .table-modern td,
            .table-modern th {
                padding: 12px;
                text-align: center; /* Center align for modern look */
            }

            .table-modern tbody td {
                vertical-align: middle;
            }

        /* Responsive Table */
        .table-responsive {
            overflow-x: auto;
        }

        /* Card Body Padding */
        .card-body {
            padding: 20px;
        }

        #btn {
            display: inline;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #f7d774;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .navbar h1 {
                margin: 0;
                color: #333;
                font-size: 1.5rem;
                flex: 1;
            }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: flex-end;
            align-items: center;
            flex: 2;
        }

            .nav-links a {
                color: #333;
                text-decoration: none;
                font-weight: bold;
                cursor: pointer;
                padding: 8px 12px;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }

                .nav-links a:hover, .nav-links .active {
                    background-color: #d45f00;
                    color: #fff;
                }

        .logout-btn {
            background-color: #ff4444;
            color: white;
            font-weight: bold;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

            .logout-btn:hover {
                background-color: #cc0000;
            }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .nav-links {
                justify-content: flex-start;
                gap: 5px;
            }

                .nav-links a {
                    padding: 6px 10px;
                    font-size: 0.9rem;
                }

            .logout-btn {
                padding: 6px 10px;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 480px) {
            .navbar h1 {
                font-size: 1.2rem;
                margin-bottom: 10px;
            }

            .nav-links {
                flex-direction: column;
                gap: 8px;
            }

                .nav-links a, .logout-btn {
                    width: 100%;
                    text-align: left;
                    padding: 10px 15px;
                }
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
    <form id="form1" runat="server">
        <div class="employee-dashboard">
            <nav class="navbar">
                <h1>Employee Dashboard</h1>
                <div class="nav-links">
                    <asp:LinkButton ID="lnkHome" runat="server" CssClass="nav-link active" OnClick="ShowHomePanel">Home</asp:LinkButton>
                    <asp:LinkButton ID="lnkUpdateDetails" runat="server" CssClass="nav-link" OnClick="ShowUpdatePanel">Update Details</asp:LinkButton>
                    <asp:LinkButton ID="lnkAttendance" runat="server" CssClass="nav-link" OnClick="ShowAttendancePanel">Attendance</asp:LinkButton>
                    <asp:LinkButton ID="lnkSalarySlip" runat="server" CssClass="nav-link" OnClick="ShowSalaryPanel">Salary Slip</asp:LinkButton>
                    <asp:LinkButton ID="lnkLeaveApplication" runat="server" CssClass="nav-link" OnClick="ShowLeavePanel">Apply for Leave</asp:LinkButton>
                    <asp:Button ID="btn" CssClass="logout-btn" runat="server" Text="Logout" OnClick="btn_Logout" />
                </div>
            </nav>

            <!-- Home Panel -->
            <asp:Panel ID="pnlHome" runat="server" CssClass="section" Visible="true">
                <h2>Welcome to Your Dashboard, 
                <asp:Label ID="welcomemsg" runat="server"></asp:Label>!
                </h2>
                <div class="card">
                    <h3>Today's Attendance</h3>
                    <asp:Label ID="lblAttendanceStatus" runat="server" Text="Loading..."></asp:Label>
                </div>
            </asp:Panel>

            <!-- Update Details Panel -->
            <asp:Panel ID="pnlUpdateDetails" runat="server" CssClass="section" Visible="false">
                <div class="updatepanel-container">
                    <h2>Update Your Details here</h2>
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name"></asp:TextBox><br />
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name"></asp:TextBox><br />
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox><br />
                    <asp:Button ID="btnUpdateDetails" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                    <asp:Label ID="lblUpdateMessage" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <!-- Attendance Panel -->
            <asp:Panel ID="pnlAttendance" runat="server" CssClass="section attendance-panel" Visible="false">
                <div class="card shadow-lg bg-light-yellow">
                    <div class="card-header bg-yellow text-dark">
                        <h2 class="mb-0">Your Attendance</h2>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="True" CssClass="table table-modern table-hover table-striped">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>


            <!-- Salary Slip Panel -->
            <asp:Panel ID="pnlSalarySlip" runat="server" CssClass="section" Visible="false">
                <!-- Tab Content -->
                <div class="tab-content mt-3" id="reportTabContent">
                    <!-- Salary Report -->
                    <div class="tab-pane fade show active" id="salary" role="tabpanel" aria-labelledby="salary-tab">
                        <h2>Salary Slips</h2>
                        <asp:Repeater ID="rptSalarySlips" runat="server">
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
                        <asp:Button ID="btnDownloadSalary" runat="server" Text="Download Salary Report" CssClass="btn btn-success mt-3" OnClick="btnDownload_Click" />
                    </div>
                </div>
            </asp:Panel>

            <!-- Leave Application Panel -->
            <asp:Panel ID="pnlLeaveApplication" runat="server" CssClass="section" Visible="false">
                <h2>Apply for Leave</h2>
                <asp:TextBox ID="txtLeaveReason" runat="server" TextMode="MultiLine" placeholder="Reason" reuired="true"></asp:TextBox><br />
                <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" placeholder="From" reuired="true"></asp:TextBox><br />
                <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" placeholder="To" reuired="true"></asp:TextBox><br />
                <asp:Button ID="btnApplyLeave" runat="server" Text="Submit" OnClick="btnApplyLeave_Click" CssClass="btn btn-primary" />
                <asp:Label ID="lblLeaveMessage" runat="server"></asp:Label>
            </asp:Panel>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    </form>
</body>
</html>
