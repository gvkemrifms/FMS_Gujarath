using System;
using System.Web.UI;

public partial class VehicleSummaryAll : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("vas_allvehicleregin", null, null, null, null, null, null, null, null, null, null, null, GrdtotalData);
        }
        catch
        {
            //
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            var report = new AccidentReport();
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryAll.xls");
        }
        catch
        {
            // Response.Write(ex.Message.ToString());
        }
    }
}
   