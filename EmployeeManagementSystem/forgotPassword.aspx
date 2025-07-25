<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgotPassword.aspx.cs" Inherits="EmployeeManagementSystem.forgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <style>
        /* General Layout */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(45deg, #2193b0, #6dd5ed); /* Bluish gradient background */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 450px;
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-size: 26px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            text-align: left;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            color: #333;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #2193b0;
            box-shadow: 0 0 10px rgba(33, 147, 176, 0.3);
        }

        .form-control[type="submit"] {
            background-color: #2193b0;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .form-control[type="submit"]:hover {
            background-color: #6dd5ed;
        }

        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 10px;
        }

        .success-message {
            color: #28a745;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                width: 80%;
            }

            h2 {
                font-size: 22px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px 15px;
                width: 90%;
            }

            h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Reset Your Password</h2>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" required="required" />
            </div>
            <div class="form-group">
                <label for="txtPassword">New Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password" required="required" />
            </div>
            <div class="form-group">
                <label for="txtConfirmPassword">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password" required="required" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="form-control" OnClick="ResetPassword_Click" />
            </div>
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" />
            <asp:Label ID="lblSuccessMessage" runat="server" CssClass="success-message" />
        </div>
    </form>
</body>
</html>

