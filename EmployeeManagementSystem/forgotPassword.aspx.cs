using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagementSystem
{
    public partial class forgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ResetPassword_Click(object sender, EventArgs e) {
            string email = txtEmail.Text.Trim();
            string newPassword = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Check if the passwords match
            if (newPassword != confirmPassword)
            {
                lblErrorMessage.Text = "Passwords do not match.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Query to check if the email exists in AdminUsers table
                string adminQuery = "SELECT COUNT(*) FROM AdminUsers WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(adminQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    int adminCount = Convert.ToInt32(cmd.ExecuteScalar());

                    // If the email is found in AdminUsers
                    if (adminCount > 0)
                    {
                        UpdatePassword(conn, email, newPassword, "AdminUsers", "Password");
                    }
                    else
                    {
                        // Check in Employee table if not found in AdminUsers
                        string employeeQuery = "SELECT COUNT(*) FROM Employee WHERE Email = @Email";
                        cmd.CommandText = employeeQuery;
                        int employeeCount = Convert.ToInt32(cmd.ExecuteScalar());

                        // If email is found in Employee table
                        if (employeeCount > 0)
                        {
                            UpdatePassword(conn, email, newPassword, "Employee");
                        }
                        else
                        {
                            // If email is not found in either table
                            lblErrorMessage.Text = "Email not found!";
                            lblSuccessMessage.Text = ""; // Clear any success message
                            return;
                        }
                    }
                }
            }
        }
        protected void UpdatePassword(SqlConnection conn, string email, string newPassword, string tableName, string colp = "column_password")
        {
            // Query to update the password in the specified table
            string updateQuery = $"UPDATE {tableName} SET {colp} = @Password WHERE Email = @Email";
            using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
            {
                updateCmd.Parameters.AddWithValue("@Password", newPassword);
                updateCmd.Parameters.AddWithValue("@Email", email);
                updateCmd.ExecuteNonQuery();
            }

            lblSuccessMessage.Text = "Password has been reset successfully!";
            lblErrorMessage.Text = ""; // Clear any previous error

            // Trigger the JavaScript to redirect after 3 seconds
            ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "setTimeout(function(){ window.location.href = 'HomePage.html';}, 2000);", true);
        }
    }
}