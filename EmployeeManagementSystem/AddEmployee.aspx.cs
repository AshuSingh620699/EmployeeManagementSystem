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
    public partial class AddEmployee : System.Web.UI.Page
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
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO Employee (FirstName, LastName, Email, Phone, Department,JoinDate) VALUES (@FirstName, @LastName, @Email, @Phone, @Department, @doj)";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["empDB"].ConnectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@Department", txtDepartment.Text);
                    cmd.Parameters.AddWithValue("@doj", txtDOJ.Text);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) {
                    ClientScript.RegisterStartupScript(this.GetType(), "REFRESH", "<script>alert('You Cannot Change Username of employee, only they can change!!!')</script>");
                }
            }

            // Redirect back to the main page
            Response.Redirect("EmployeeManagement.aspx");
        }

    }
}