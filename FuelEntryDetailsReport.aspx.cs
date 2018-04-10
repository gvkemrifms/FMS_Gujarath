using System;
using System.Web.UI;

public partial class FuelEntryDetailsReport : Page
{
    private readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindDistrictdropdown();
    }
    private void BindDistrictdropdown()
    {

        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_FMSReports_GetFuelEntryDetails", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grddetails);
        }
        catch
        {
            // ignored
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

}
