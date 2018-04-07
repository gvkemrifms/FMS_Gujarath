using System;
using System.Web.UI;

public partial class DetailedReport : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDistrictdropdown();
        }
    }
    private void BindDistrictdropdown()
    {
        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            _helper.LoadExcelSpreadSheet(this,Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch
        {
            // Response.Write(ex.Message.ToString());
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailed1", null, null, ddldistrict, null, null, null, "@DistrictID", "@From", "@To", null, null, Grddtreport);

        }
        catch (Exception)
        {
            // ignored
        }
    }
}
