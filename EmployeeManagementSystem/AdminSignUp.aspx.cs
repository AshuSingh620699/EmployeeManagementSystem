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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is authenticated (session exists)
            if (Session["AdminUsername"] == null)
            {
                // Redirect to login page if session doesn't exist
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Simple Validation
            if (password != confirmPassword)
            {
                // Passwords do not match
                Response.Write("<script>alert('Passwords do not match.');</script>");
                return;
            }


            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;

            // SQL query to insert a new admin user
            string query = "INSERT INTO AdminUsers (Username, Email, Password) VALUES (@Username, @Email, @Password)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    cnf.Text = "Admin Added successful!!!";
                }
                catch (Exception ex)
                {
                    // Handle any errors (e.g., database connection issues)
                    Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
                }
            }
        }
    }
}