using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class CumulativeReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) btnShow_Click();
    }

    protected void btnShow_Click()
    {
        var c = new SqlConnection(ConfigurationManager.AppSettings["Str"]);
        var dataAdapter = new SqlDataAdapter("CumulativeReportOnRO", c);
        var commandBuilder = new SqlCommandBuilder(dataAdapter);
        var ds = new DataSet();
        dataAdapter.Fill(ds);
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        var report = new AccidentReport();
        report.LoadExcelSpreadSheet(null, "CumulativeReport.xls", GridView1);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}