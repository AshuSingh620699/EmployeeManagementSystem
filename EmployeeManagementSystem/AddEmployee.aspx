<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="EmployeeManagementSystem.AddEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Employee</title>
    <style>
        /* General Layout */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            max-width: 100%;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
            display: inline-block;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 12px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="email"]:focus {
            border-color: #007bff;
            outline: none;
        }

        .form-group input[type="text"]:invalid {
            border-color: #e74c3c;
        }

        .form-group input[type="text"]:valid {
            border-color: #2ecc71;
        }

        /* Button Styling */
        #btnSave {
            background-color: #28a745;
            color: white;
            font-size: 16px;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #btnSave:hover {
            background-color: #218838;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            form {
                padding: 20px;
                width: 100%;
            }

            .form-group {
                margin-bottom: 12px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Add New Employee</h2>

        <div class="form-group">
            <label for="txtFirstName">First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtLastName">Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtPhone">Phone:</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtDepartment">Department:</label>
            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtDOJ">Date of Joining:</label>
            <asp:TextBox ID="txtDOJ" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <label for="txtSalary">Salary:</label>
            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" Required="True" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnSave" Text="Save" OnClick="btnSave_Click" runat="server" />
        </div>
    </form>
</body>
</html>
