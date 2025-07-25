<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashBoard.aspx.cs" Inherits="EmployeeManagementSystem.AdminDashBoard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        /* General Layout */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e0f7fa, #80d8ff);
            color: #333;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(90deg, #1e88e5, #1565c0);
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            color: #fff;
            font-weight: bold;
        }

        .nav-link {
            color: #fff !important;
            margin-right: 10px;
            transition: color 0.3s ease;
        }

            .nav-link:hover {
                color: #cce4f7 !important;
            }

        .btn-primary {
            background-color: #ffffff !important;
            color: #1e88e5 !important;
            border: 1px solid #1e88e5 !important;
            transition: all 0.3s ease;
        }

            .btn-primary:hover {
                background-color: #f44336 !important; /* Red shade on hover */
                color: #ffffff !important;
            }

        /* Main Content */
        .main-content {
            padding: 30px;
            margin-top: 70px; /* Space for the fixed navbar */
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
        }

        /* Card Container */
        .card-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap; /* Ensure cards wrap on smaller screens */
            gap: 20px;
        }

        /* Cards */
        .card {
            background: linear-gradient(to right, #bbdefb, #e3f2fd);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
            width: 22%;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 15px rgba(0, 0, 0, 0.2);
            }

            .card h3 {
                font-size: 18px;
                color: #555;
                margin-bottom: 15px;
            }

            .card .count {
                font-size: 36px;
                font-weight: bold;
                color: #1e88e5;
            }

            .card .icon {
                font-size: 50px;
                color: #1e88e5;
                margin-top: 10px;
            }

        /* Footer */
        .footer {
            background: #1e88e5;
            color: #fff;
            text-align: center;
            padding: 15px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

            .footer p {
                margin: 0;
                font-size: 14px;
            }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .card {
                width: 45%; /* Adjust card width for tablets */
            }
        }

        @media (max-width: 768px) {
            .card-container {
                flex-direction: column;
                align-items: center;
            }

            .card {
                width: 80%; /* Adjust card width for smaller devices */
            }
        }
    </style>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Admin Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">

                        <li class="nav-item">
                            <a class="nav-link active" href="AdminDashboard.aspx">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="AdminSignUp.aspx">Add Admin</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="EmployeeManagement.aspx">Manage Employees</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MarkAttendance.aspx">Attendance</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LeaveManagement.aspx">Leave Requests</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MarkSalaryManagement.aspx">Salary Management</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ReportsManagement.aspx">Reports</a>
                        </li>
                        <asp:Button runat="server" Text="Logout" CssClass="btn btn-primary" OnClick="btn_Logout" />
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <h2>
                <asp:Label ID="lblWelcomeMessage" runat="server" Text="Admin"></asp:Label></h2>

            <!-- Card Container -->
            <div class="card-container">
                <div class="card">
                    <h3>Total Employees</h3>
                    <span class="count" id="totalEmployees">
                        <asp:Label ID="totalEmployeesLabel" runat="server" Text="0"></asp:Label></span>
                    <i class="icon">&#128100;</i>
                </div>

                <div class="card">
                    <h3>Attendance Today</h3>
                    <span class="count" id="todayAttendance">
                        <asp:Label ID="todayAttendanceLabel" runat="server" Text="0"></asp:Label></span>
                    <i class="icon">&#128197;</i>
                </div>

                <div class="card">
                    <h3>Active Employees</h3>
                    <span class="count" id="activeEmployees">
                        <asp:Label ID="activeEmployeesLabel" runat="server" Text="0"></asp:Label></span>
                    <i class="icon">&#9989;</i>
                </div>

                <div class="card">
                    <h3>Pending Leave Requests</h3>
                    <span class="count" id="pendingLeave">
                        <asp:Label ID="pendingLeaveLabel" runat="server" Text="0"></asp:Label></span>
                    <i class="icon">&#128665;</i>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2024 Employee Management System. All rights reserved.</p>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </form>
</body>
</html>
