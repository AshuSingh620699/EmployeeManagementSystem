using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;


namespace EmployeeManagementSystem
{
    public partial class ReportsManagement : System.Web.UI.Page
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
                LoadSalaryReport();
                LoadAttendanceReport();
                LoadEmployeeReport();
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
        private void LoadSalaryReport()
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
            e.EmployeeID = p.EmployeeID";
            rptSalaryReport.DataSource = GetData(query);
            rptSalaryReport.DataBind();
        }

        // Load Attendance Report
        private void LoadAttendanceReport()
        {
            string query = "SELECT a.AttendanceID, a.EmployeeID, e.FirstName, e.LastName, a.Date, a.Status " +
                           "FROM Attendance a JOIN Employee e ON a.EmployeeID = e.EmployeeID";
            rptAttendanceReport.DataSource = GetData(query);
            rptAttendanceReport.DataBind();
        }

        // Load Employee Report
        private void LoadEmployeeReport()
        {
            string query = "SELECT EmployeeID, FirstName, LastName, Department, JoinDate, Status FROM Employee";
            rptEmployeeReport.DataSource = GetData(query);
            rptEmployeeReport.DataBind();
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


        // Download Salary Report
        protected void btnDownloadSalary_Click(object sender, EventArgs e)
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
            e.EmployeeID = p.EmployeeID";
            DataTable dt = GetData(query);
            ExportToPDF(dt, "SalaryReport");
        }

        // Download Attendance Report
        protected void btnDownloadAttendance_Click(object sender, EventArgs e)
        {
            string query = "SELECT a.AttendanceID, a.EmployeeID, e.FirstName, e.LastName, a.Date, a.Status " +
                           "FROM Attendance a JOIN Employee e ON a.EmployeeID = e.EmployeeID";
            DataTable dt = GetData(query);
            ExportToPDF(dt, "AttendanceReport");
        }

        // Download Employee Report
        protected void btnDownloadEmployee_Click(object sender, EventArgs e)
        {
            string query = "SELECT EmployeeID, FirstName, LastName, Department, JoinDate, Status FROM Employee";
            DataTable dt = GetData(query);
            ExportToPDF(dt, "EmployeeReport");
        }
    }
}