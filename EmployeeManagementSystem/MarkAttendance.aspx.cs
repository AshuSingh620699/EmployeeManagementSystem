using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagementSystem
{
    public partial class MarkAttendance : System.Web.UI.Page
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
                LoadEmployees();
            }
        }

        // Load employees along with their attendance status
        private void LoadEmployees()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = "SELECT e.EmployeeID, e.FirstName, e.LastName, ISNULL(a.Status, 'Absent') AS Status, a.AttendanceID " +
                           "FROM Employee e " +
                           "LEFT JOIN Attendance a ON e.EmployeeID = a.EmployeeID AND a.Date = @Date";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Date", DateTime.Now.ToString("yyyy-MM-dd")); // Today's date
                conn.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptAttendance.DataSource = dt;  // Bind data to the repeater
                rptAttendance.DataBind();
            }
        }


        // Handle the Save button click
        protected void rptAttendance_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                int employeeID = Convert.ToInt32(e.CommandArgument);
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");
                string status = ddlStatus.SelectedValue;

                // Insert or update the attendance record for today's date
                string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
                string query = "IF EXISTS (SELECT 1 FROM Attendance WHERE EmployeeID = @EmployeeID AND Date = @Date) " +
                               "UPDATE Attendance SET Status = @Status WHERE EmployeeID = @EmployeeID AND Date = @Date " +
                               "ELSE " +
                               "INSERT INTO Attendance (EmployeeID, Date, Status) VALUES (@EmployeeID, @Date, @Status)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    cmd.Parameters.AddWithValue("@Date", DateTime.Now.ToString("yyyy-MM-dd")); // Today's date
                    cmd.Parameters.AddWithValue("@Status", status);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Reload data after saving
                LoadEmployees();
            }
        }

        // Set the status of DropDownList in ItemDataBound
        protected void rptAttendance_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");

                // Get the current status from the data
                string status = DataBinder.Eval(e.Item.DataItem, "Status").ToString();

                if (ddlStatus != null)
                {
                    ddlStatus.SelectedValue = status; // Set the selected value of dropdown
                }
            }
        }
    }
}
