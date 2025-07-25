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
    public partial class EmployeeManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            // Check if the user is authenticated (session exists)
            if (Session["AdminUsername"] == null)
            {
                // Redirect to login page if session doesn't exist
                Response.Redirect("AdminLogin.aspx");
            }
            if (!IsPostBack)
            {
                LoadEmployeeData();
            }
        }

        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEmployee.aspx");
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the GridView to edit mode
            GridView1.EditIndex = e.NewEditIndex;
            LoadEmployeeData();  // Reload data to reflect changes
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get the edited row
            GridViewRow row = GridView1.Rows[e.RowIndex];

            // Find the TextBox controls
            TextBox txtFirstName = (TextBox)row.FindControl("txtFirstName");
            TextBox txtLastName = (TextBox)row.FindControl("txtLastName");
            TextBox txtEmail = (TextBox)row.FindControl("txtEmail");
            TextBox txtPhone = (TextBox)row.FindControl("txtPhone");
            TextBox txtDepartment = (TextBox)row.FindControl("txtDepartment");
            TextBox txtJoinDate = (TextBox)row.FindControl("txtJoinDate");
            TextBox txtStatus = (TextBox)row.FindControl("txtStatus");

            // Get EmployeeID from DataKey
            int employeeId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Update the data in the database
            string query = "UPDATE Employee SET FirstName = @FirstName, LastName = @LastName, Email = @Email, " +
                           "Phone = @Phone, Department = @Department, JoinDate = @JoinDate,Status = @status WHERE EmployeeID = @EmployeeID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["empDB"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Department", txtDepartment.Text);
                cmd.Parameters.AddWithValue("@JoinDate", txtJoinDate.Text);
                cmd.Parameters.AddWithValue("@status", txtStatus.Text);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Exit edit mode
            GridView1.EditIndex = -1;
            LoadEmployeeData();  // Reload data to show updated records
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Exit edit mode without making changes
            GridView1.EditIndex = -1;
            LoadEmployeeData();  // Reload data to show records as before editing
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int employeeId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Delete record from the database
            string query = "DELETE FROM Employee WHERE EmployeeID = @EmployeeID";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["empDB"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    conn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex) {
                        ClientScript.RegisterStartupScript(this.GetType(), "REFRESH", "<script>alert('Canot delete Active Employee direclty!!!')</script>");
                    }
                }
            }
            catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(),"REFRESH","<script>alert('Canot delete Active Employee direclty!!!')</script>");
            }

            // Reload data to reflect changes
            LoadEmployeeData();
        }

        private void LoadEmployeeData()
        {
            // Load employee data into GridView
            string query = "SELECT * FROM Employee";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["empDB"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
    }
}