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
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }

            // Check if the user is authenticated (session exists)
            if (Session["AdminUsername"] == null)
            {
                // Redirect to login page if session doesn't exist
                Response.Redirect("AdminLogin.aspx");
            }
            else
            {
                // You can fetch additional information if necessary
                string adminUsername = Session["AdminUsername"].ToString();
                // Display a personalized welcome message
                lblWelcomeMessage.Text = "Welcome, " + adminUsername;
            }
        }        // Method to load dashboard data (Total Employees, Today's Attendance, Active Employees, etc.)
        private void LoadDashboardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;

            // Queries to fetch various statistics
            string totalEmployeesQuery = "SELECT COUNT(*) FROM Employee";
            string todayAttendanceQuery = "SELECT COUNT(*) FROM Attendance WHERE Date = @Today AND Status = 'Present'";
            string activeEmployeesQuery = "SELECT COUNT(*) FROM Employee WHERE Status = 'Active'";
            string pendingleavesQuery = "SELECT COUNT(*) FROM LeaveRequest WHERE Status = 'Pending'";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Total Employees
                SqlCommand cmd = new SqlCommand(totalEmployeesQuery, conn);
                int totalEmployees = Convert.ToInt32(cmd.ExecuteScalar());
                totalEmployeesLabel.Text = totalEmployees.ToString();

                // Today's Attendance
                cmd = new SqlCommand(todayAttendanceQuery, conn);
                cmd.Parameters.AddWithValue("@Today", DateTime.Now.Date);
                int todayAttendance = Convert.ToInt32(cmd.ExecuteScalar());
                todayAttendanceLabel.Text = $"{todayAttendance} / {totalEmployees}";

                // Active Employees
                cmd = new SqlCommand(activeEmployeesQuery, conn);
                int activeEmployees = Convert.ToInt32(cmd.ExecuteScalar());
                activeEmployeesLabel.Text = activeEmployees.ToString();

                // Pending Leave Requests
                cmd = new SqlCommand(pendingleavesQuery, conn);
                int pendingLeave = Convert.ToInt32(cmd.ExecuteScalar());
                pendingLeaveLabel.Text = pendingLeave.ToString();
            }
        }

        // Log out functionality
        protected void btn_Logout(object sender, EventArgs e)
        {
            // Clear the session
            Session.Clear();
            Session.Abandon();

            // Redirect to login page after logout
            Response.Redirect("AdminLogin.aspx");
        }
    }
}