<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="EmployeeManagementSystem.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login</title>
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
            height: 80%;
            display: flex;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
        }

        /* Left Side - Form Section */
        .left-section {
            width: 50%;
            padding: 40px;
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
            margin-top: 20px;
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

        /* Right Side - Image Section */
        .right-section {
            width: 50%;
            background-image: url('/admin.png'); /* Replace with your desired image URL */
            background-size: cover;
            background-position: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column-reverse;
                height: auto;
            }

            .left-section {
                width: 100%;
                padding: 20px;
            }

            .right-section {
                width: 100%;
                height: 300px;
            }
        }

        #btnLogin {
            background-color: #1565c0;
        }
        .fr{
            margin-top:5px;
            text-align:end;
            
        }
        .fr a{
            text-decoration:none;
            color:#1565c0;
        }
        .fr a:hover{
            text-decoration:underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Section with Login Form -->
        <div class="left-section">
            <h2>Admin Login</h2>
            <form id="form1" runat="server">
                <div class="form-group">
                    <label for="txtUsername">Username:</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" required="required" />
                    <div class="form-group fr">
                        <a href="forgotPassword.aspx">forgot password ?</a>
                    </div>
                </div>
                <div class="form-group">
                    <label for="txtPassword">Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter your password" TextMode="Password" required="required" />
                </div>
                <div class="form-group">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="form-control" OnClick="Login_Click" />
                </div>
            </form>
        </div>

        <!-- Right Section with Image -->
        <div class="right-section"></div>
    </div>
</body>
</html>
