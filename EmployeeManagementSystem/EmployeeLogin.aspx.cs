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
    public partial class EmployeeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the admin is already logged in (session exists)
            if (Session["column_Username"] != null)
            {
                // Redirect to the Admin Dashboard if already logged in
                Response.Redirect("EmployeeDashBoard.aspx");
            }
        }
        protected void Login_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;

            string query = "SELECT EmployeeID, column_Username FROM Employee WHERE column_Username = @Username AND column_Password = @Password";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        // Session: Store the admin username or AdminID (or any other identifying info)
                        reader.Read();
                        Session["EmployeeId"] = reader["EmployeeId"];
                        Session["column_Username"] = username; // Store the username or AdminID in the session
                        // You can also store more info like AdminID: Session["AdminID"] = reader["AdminID"];

                        // Successful login - redirect to the admin dashboard
                        Response.Redirect("EmployeeDashBoard.aspx");
                    }
                    else
                    {
                        // Invalid login
                        Response.Write("<script>alert('Invalid username or password.');</script>");
                    }
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