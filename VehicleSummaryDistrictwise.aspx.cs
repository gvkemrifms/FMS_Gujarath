using System;
using System.Web.UI;

public partial class VehicleSummaryDistrictwise : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindDistrictdropdown();
    }

    private void BindDistrictdropdown()
    {
        var sqlQuery = "SELECT district_id ds_dsid,district_name ds_lname from [m_district]  where state_id = 24 order by district_name";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("VAS_Districtwise_Vehicles_Inactive", null, null, ddldistrict, null, null, null, "@dsid", null, null, null, null, GridInactive);
            AccidentReport.FillDropDownHelperMethodWithSp("VAS_Districtwise_Vehicles_Active", null, null, ddldistrict, null, null, null, "@dsid", null, null, null, null, GridActive);
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
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch
        {
            // Response.Write(ex.Message.ToString());
        }
    }
}