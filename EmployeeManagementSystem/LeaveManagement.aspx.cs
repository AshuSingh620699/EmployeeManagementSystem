using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

namespace EmployeeManagementSystem
{
    public partial class WebForm1 : System.Web.UI.Page
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
                LoadLeaveRequests();
            }
        }

        // Load all pending leave requests
        private void LoadLeaveRequests()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = "SELECT lr.LeaveID, lr.EmployeeID, e.FirstName, e.LastName, " +
                           "lr.LeaveDateFrom, lr.LeaveDateTo, lr.Reason, lr.Status " +
                           "FROM LeaveRequest lr " +
                           "JOIN Employee e ON lr.EmployeeID = e.EmployeeID " +
                           "WHERE lr.Status = 'Pending'";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptLeaveRequests.DataSource = dt;
                rptLeaveRequests.DataBind();
            }
        }

        // Handle Approve/Reject actions
        protected void rptLeaveRequests_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            int leaveID = Convert.ToInt32(e.CommandArgument);
            string action = e.CommandName;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Update Leave Status
                string query = action == "Approve"
                    ? "UPDATE LeaveRequest SET Status = 'Approved' WHERE LeaveID = @LeaveID"
                    : "UPDATE LeaveRequest SET Status = 'Rejected' WHERE LeaveID = @LeaveID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LeaveID", leaveID);
                cmd.ExecuteNonQuery();

                // Fetch Employee Email using EmployeeID from LeaveRequests table
                string emailQuery = @"
                    SELECT e.Email 
                    FROM Employee e 
                    INNER JOIN LeaveRequest lr ON e.EmployeeID = lr.EmployeeID 
                    WHERE lr.LeaveID = @LeaveID";

                SqlCommand emailCmd = new SqlCommand(emailQuery, conn);
                emailCmd.Parameters.AddWithValue("@LeaveID", leaveID);
                string email = emailCmd.ExecuteScalar()?.ToString();

                // Send Email Notification
                if (!string.IsNullOrEmpty(email))
                {
                    string subject = action == "Approve" ? "Leave Request Approved" : "Leave Request Rejected";
                    string body = action == "Approve"
                        ? "Your leave request has been approved, make your presence on time after this, Thank You!"
                        : "Your leave request has been rejected, make your presence by tommorow";

                    SendEmail(email, subject, body);
                }

                conn.Close();
            }

            // Rebind Data
            LoadLeaveRequests();
        }
        private void SendEmail(string toEmail, string subject, string body)
        {
            try
            {
                string email = ConfigurationManager.AppSettings["EmailSender"];
                string password = ConfigurationManager.AppSettings["EmailPassword"];

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(email);
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = body;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                smtp.Port = 587;
                smtp.Credentials = new NetworkCredential(email, password);
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Email sending failed: " + ex.Message);
            }
        }


    }
}