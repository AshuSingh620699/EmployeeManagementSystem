using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace EmployeeManagementSystem
{
    public partial class EmployeeDashBoard : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["column_username"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx");
            }
            else
            {
                welcomemsg.Text = Session["column_username"].ToString();
                LoadTodayAttendance();
            }
            using (SqlConnection con = new SqlConnection(connectionString)) {
                string q = "Select FirstName,LastName, Email from Employee where EmployeeID = @eid";
                using (SqlCommand cd = new SqlCommand(q, con))
                {
                    cd.Parameters.AddWithValue("@eid", Session["EmployeeID"]);
                    con.Open();
                    SqlDataReader reader = cd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                    }
                    con.Close();
                }
            }
        }
        protected void btn_Logout(object sender, EventArgs e) {
            // Clear the session
            Session.Clear();
            Session.Abandon();

            // Redirect to login page after logout
            Response.Redirect("EmployeeLogin.aspx");
        }

        protected void ShowHomePanel(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlHome.Visible = true;
            SetActiveLink(lnkHome);
        }

        protected void ShowUpdatePanel(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlUpdateDetails.Visible = true;
            SetActiveLink(lnkUpdateDetails);
        }

        protected void ShowAttendancePanel(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlAttendance.Visible = true;
            SetActiveLink(lnkAttendance);
            LoadAttendance();
        }

        protected void ShowSalaryPanel(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlSalarySlip.Visible = true;
            SetActiveLink(lnkSalarySlip);
            LoadSalarySlips();
        }

        protected void ShowLeavePanel(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlLeaveApplication.Visible = true;
            SetActiveLink(lnkLeaveApplication);
        }

        private void HideAllPanels()
        {
            pnlHome.Visible = false;
            pnlUpdateDetails.Visible = false;
            pnlAttendance.Visible = false;
            pnlSalarySlip.Visible = false;
            pnlLeaveApplication.Visible = false;
        }

        private void SetActiveLink(LinkButton activeLink)
        {
            lnkHome.CssClass = "nav-link";
            lnkUpdateDetails.CssClass = "nav-link";
            lnkAttendance.CssClass = "nav-link";
            lnkSalarySlip.CssClass = "nav-link";
            lnkLeaveApplication.CssClass = "nav-link";

            activeLink.CssClass = "nav-link active";
        }

        private void LoadTodayAttendance()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Convert GETDATE() to NVARCHAR in the same format as stored in the database
                string query = "SELECT Status FROM Attendance WHERE EmployeeId = @EmployeeId AND Date = CONVERT(NVARCHAR, GETDATE(), 23)"; // 23: 'YYYY-MM-DD' format

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmployeeId", Session["EmployeeId"]);

                con.Open();
                object status = cmd.ExecuteScalar();

                lblAttendanceStatus.Text = status != null ? status.ToString() : "Not Marked";
            }
        }


        private void LoadAttendance()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Date, Status FROM Attendance WHERE EmployeeId = @EmployeeId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmployeeId", Session["EmployeeId"]);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                gvAttendance.DataSource = reader;
                gvAttendance.DataBind();
            }
        }
        // Helper method to fetch data from the database
        private DataTable GetData(string query)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Load Salary Report
        private void LoadSalarySlips()
        {
            string query = @"
        SELECT 
            e.EmployeeID, 
            e.FirstName,
            e.Department,
            p.Month,
            p.year,
            p.GrossSalary, 
            p.Deductions,
            p.NetSalary
        FROM 
            Employee e 
        JOIN 
            Payslip p 
        ON 
            e.EmployeeID = p.EmployeeID WHERE 
    e.EmployeeID = @EmployeeID;";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmployeeID", Session["EmployeeId"]);  // Add the parameter

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptSalarySlips.DataSource = reader;
                rptSalarySlips.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Employee SET FirstName = @FirstName, LastName = @LastName, Email = @Email WHERE EmployeeId = @EmployeeId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@EmployeeId", Session["EmployeeId"]);
                con.Open();

                cmd.ExecuteNonQuery();
                lblUpdateMessage.Text = "Details Updated Successfully!";
            }
        }

        protected void btnApplyLeave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO LeaveRequest (EmployeeId, LeaveDateFrom, LeaveDateTo, Reason) VALUES (@EmployeeId, @FromDate, @ToDate, @Reason)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@EmployeeId", Session["EmployeeId"]);
                cmd.Parameters.AddWithValue("@FromDate", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@ToDate", txtToDate.Text);
                cmd.Parameters.AddWithValue("@Reason", txtLeaveReason.Text);
                con.Open();

                cmd.ExecuteNonQuery();
                lblLeaveMessage.ForeColor = System.Drawing.Color.Green;
                lblLeaveMessage.Text = "Leave Application Submitted Successfully!";
            }
        }
        private void ExportToPDF(DataTable dt, string fileName)
        {
            using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
            {
                // Create a new PDF document
                iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 10, 10, 10, 10);
                iTextSharp.text.pdf.PdfWriter.GetInstance(pdfDoc, memoryStream);
                pdfDoc.Open();

                // Add a title
                iTextSharp.text.Paragraph title = new iTextSharp.text.Paragraph("Salary Report")
                {
                    Alignment = iTextSharp.text.Element.ALIGN_CENTER
                };
                pdfDoc.Add(title);
                pdfDoc.Add(new iTextSharp.text.Paragraph("\n"));

                // Create a table with column headers
                iTextSharp.text.pdf.PdfPTable table = new iTextSharp.text.pdf.PdfPTable(dt.Columns.Count);
                foreach (DataColumn column in dt.Columns)
                {
                    table.AddCell(new iTextSharp.text.Phrase(column.ColumnName));
                }

                // Add rows
                foreach (DataRow row in dt.Rows)
                {
                    foreach (DataColumn column in dt.Columns)
                    {
                        table.AddCell(new iTextSharp.text.Phrase(row[column].ToString()));
                    }
                }

                pdfDoc.Add(table);
                pdfDoc.Close();

                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", $"attachment;filename={fileName}.pdf");
                Response.OutputStream.Write(memoryStream.GetBuffer(), 0, memoryStream.GetBuffer().Length);
                Response.Flush();
                Response.End();
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            string query = @"
        SELECT 
            e.EmployeeID, 
            e.FirstName,
            e.Department,
            p.Month,
            p.year,
            p.GrossSalary, 
            p.Deductions,
            p.NetSalary
        FROM 
            Employee e 
        JOIN 
            Payslip p 
        ON 
            e.EmployeeID = p.EmployeeID WHERE 
    e.EmployeeID = @EmployeeID;";
            // Pass the logged-in employee's ID as a parameter
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmployeeID", Session["EmployeeId"]); // Ensure this session variable is set during login
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Call the method to export the filtered data to PDF
                ExportToPDF(dt, "SalaryReport");
            }

        }
    }
}
