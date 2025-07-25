<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpSignUp.aspx.cs" Inherits="EmployeeManagementSystem.EmpSignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Signup</title>
    <style>
        /* General Layout */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f7fa;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 80%;
            height: 95%;
            display: flex;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
        }

        /* Left Side - Image Section */
        .left-section {
            width: 50%;
            background-image: url('/employee.jpeg'); /* Replace with your desired image URL */
            background-size: contain;
            background-position: center;
        }

        /* Right Side - Form Section */
        .right-section {
            width: 50%;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            margin-top: 5px;
        }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

            .footer a {
                color: #1565c0;
                text-decoration: none;
            }

                .footer a:hover {
                    text-decoration: underline;
                }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
            }

            .left-section {
                width: 100%;
                height: 300px;
            }

            .right-section {
                width: 100%;
                padding: 20px;
            }
        }

        #btnSignUp {
            background-color: #1565c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Section with Image -->
        <div class="left-section"></div>

        <!-- Right Section with Signup Form -->
        <div class="right-section">
            <h2>Employee Sign Up</h2>
            <form id="form1" runat="server">
                <div class="form-group">
                    <label for="txtfirstname">Firstname:</label>
                    <asp:TextBox ID="firstname" runat="server" CssClass="form-control" placeholder="Enter first username" required="required" />
                </div>
                <div class="form-group">
                    <label for="txtlastname">Lastname:</label>
                    <asp:TextBox ID="lastname" runat="server" CssClass="form-control" placeholder="Enter last username" required="required" />
                </div>
                <div class="form-group">
                    <label for="txtUsername">Username:</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" required="required" />
                </div>
                <div class="form-group">
                    <label for="txtEmail">Email:</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email" required="required" />
                </div>
                <div class="form-group">
                    <label for="txtPassword">Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter your password" TextMode="Password" required="required" />
                </div>
                <asp:Label ID="labelmsg" runat="server"></asp:Label>
                <div class="form-group">
                    <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="form-control" OnClick="SignUp_Click" />
                </div>
            </form>
            <div class="footer">
                <p>Already have an account? <a href="EmployeeLogin.aspx">Log in here</a></p>
            </div>
        </div>
    </div>
</body>
</html>
