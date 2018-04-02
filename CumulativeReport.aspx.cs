using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class CumulativeReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnShow_Click();

        }
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
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=CumulativeReport.xls");
        Response.ContentType = "application/excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
}