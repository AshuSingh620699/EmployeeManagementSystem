using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagementSystem
{
    public partial class EmpSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SignUp_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Simple Validation
            if (password.Length <= 8)
            {
                // Passwords do not match
                Response.Write("<script>alert('Passwords length must be greater than eight digits.');</script>");
                return;
            }

            bool flag = false;
            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = "select EmployeeID from Employee where email = @email";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    string eid = "";
                    if (reader.HasRows)
                    {
                        reader.Read();
                        eid = reader["EmployeeID"].ToString();
                        flag = true;
                    }
                    if (flag)
                    {
                    using(SqlConnection c = new SqlConnection(connectionString))
                    {
                        string q = "UPDATE Employee SET column_username = @c_us where EmployeeID = @eid";
                        using(SqlCommand cd = new SqlCommand(q, c))
                        {
                            cd.Parameters.AddWithValue("@c_us", txtUsername.Text);
                            cd.Parameters.AddWithValue("@eid", eid);
                            c.Open();
                            cd.ExecuteNonQuery();
                            c.Close();
                        }
                    }
                        labelmsg.ForeColor = System.Drawing.Color.Red;
                        labelmsg.Text = "User Exists!!!, log in please..";
                    }
            }

            if (!flag)
            {
                // SQL query to insert a new admin user
                string query2 = "Insert into Employee (FirstName,LastName,Email,column_username,column_password) values (@fn, @ln, @em, @cus, @cpw)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand(query2, conn);
                        cmd.Parameters.AddWithValue("@fn", firstname.Text);
                        cmd.Parameters.AddWithValue("@ln", lastname.Text);
                        cmd.Parameters.AddWithValue("@em", email);
                        cmd.Parameters.AddWithValue("@cus", username);
                        cmd.Parameters.AddWithValue("@cpw", password);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Successful signup message
                        Response.Write("<script>alert('Sign up successful. You can now log in.');</script>");
                        Response.Redirect("EmployeeLogin.aspx"); // Redirect to login page after successful signup
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
}