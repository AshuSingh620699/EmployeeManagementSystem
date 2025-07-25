using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagementSystem
{
    public partial class MarkSalaryManagement : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUsername"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadEmployeesWithSalaries();
                PopulateEmployeeDropdown();
            }
        }

        // Load Payslips and Employee Data
        private void LoadEmployeesWithSalaries()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = @"SELECT ps.PayslipID, e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
                     ps.Month,ps.Year, ps.GrossSalary, ps.Deductions, ps.NetSalary, ps.GeneratedDate
                     FROM Payslip ps
                     INNER JOIN Employee e ON ps.EmployeeID = e.EmployeeID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptSalaryManagement.DataSource = dt;
                rptSalaryManagement.DataBind();
            }
        }

        // Populate Employee Dropdown for Adding Payslip
        private void PopulateEmployeeDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = "SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS EmployeeName FROM Employee";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlEmployee.DataSource = dt;
                ddlEmployee.DataTextField = "EmployeeName";
                ddlEmployee.DataValueField = "EmployeeID";
                ddlEmployee.DataBind();
            }
        }

        // Handle Save and Add actions
        protected void rptSalaryManagement_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                int employeeID = Convert.ToInt32(e.CommandArgument);
                TextBox txtNewSalary = (TextBox)e.Item.FindControl("txtNewSalary");
                decimal newSalary;

                // Validate new salary input
                if (!decimal.TryParse(txtNewSalary.Text, out newSalary) || newSalary <= 0)
                {
                    Response.Write("<script>alert('Invalid salary amount. Please enter a valid number.');</script>");
                    return;
                }

                // Update or Add salary slip
                string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
                string query = @"
                    UPDATE Payslip
                    SET GrossSalary = @GrossSalary,
                        NetSalary = @NetSalary,
                        Deductions = @Deductions,
                        GeneratedDate = GETDATE()
                    WHERE EmployeeID = @EmployeeID;

                    IF @@ROWCOUNT = 0 -- If no rows updated, add a new salary slip
                    BEGIN
                        INSERT INTO Payslip (EmployeeID, Month,Year, GrossSalary, Deductions, NetSalary, GeneratedDate)
                        VALUES (@EmployeeID, FORMAT(GETDATE(), 'MM-yyyy'), @GrossSalary, @Deductions, @NetSalary, GETDATE());
                    END";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    cmd.Parameters.AddWithValue("@GrossSalary", newSalary);
                    cmd.Parameters.AddWithValue("@Deductions", newSalary * 0.1m); // Example: 10% deduction
                    cmd.Parameters.AddWithValue("@NetSalary", newSalary * 0.9m); // Example: 90% net salary

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Reload data after updating or adding
                LoadEmployeesWithSalaries();
            }
        }
        protected void btnAddPayslip_Click(object sender, EventArgs e)
        {
            int employeeID = int.Parse(ddlEmployee.SelectedValue);
            string month = txtMonth.Text;
            string Year = txtYear.Text;
            decimal grossSalary = decimal.Parse(txtGrossSalary.Text);
            decimal deductions = decimal.Parse(txtDeductions.Text);
            decimal netSalary = grossSalary - deductions;
            string generatedDate = DateTime.Now.ToString("yyyy-MM-dd");

            string connectionString = ConfigurationManager.ConnectionStrings["empDB"].ConnectionString;
            string query = @"INSERT INTO Payslip (EmployeeID, Month,Year, GrossSalary, Deductions, NetSalary, GeneratedDate) 
                     VALUES (@EmployeeID, @Month, @Year, @GrossSalary, @Deductions, @NetSalary, @GeneratedDate)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                cmd.Parameters.AddWithValue("@Month", month);
                cmd.Parameters.AddWithValue("@Year", Year);
                cmd.Parameters.AddWithValue("@GrossSalary", grossSalary);
                cmd.Parameters.AddWithValue("@Deductions", deductions);
                cmd.Parameters.AddWithValue("@NetSalary", netSalary);
                cmd.Parameters.AddWithValue("@GeneratedDate", generatedDate);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadEmployeesWithSalaries();
        }

    }
}
