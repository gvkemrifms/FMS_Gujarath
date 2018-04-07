using System;
using System.Web.UI;

public partial class CostingAnalysisReport : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
            // withoutdist();
        }
    }
    private void BindDistrictdropdown()
    {
        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }
    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex <= 0)
        {
            ddlvehicle.Enabled = false;
        }
        else
        {
            ddlvehicle.Enabled = true;
            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@DistrictID");
            }
            catch (Exception)
            {
                // ignored
            }
        }
    }
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            _helper.LoadExcelSpreadSheet(this,Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch (Exception)
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
            _helper.FillDropDownHelperMethodWithSp("P_Reports_MaintCostingAnalysis", null, null, ddldistrict, ddlvehicle, null, null, "@DistrictID", "@VehicleID", null, null, null, Grdcosdetails);

        }
        catch (Exception)
        {
            // ignored
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
}