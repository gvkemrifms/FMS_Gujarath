using System;
using System.Web.UI;

public partial class HistoryReport : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
        }
    }

    private void BindDistrictdropdown()
    {
        try
        {
            var sqlQuery = "select ds_dsid,ds_lname from M_FMS_Districts";
            _helper.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);
        }
        catch
        {
            //
        }
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
                _helper.FillDropDownHelperMethodWithSp("P_Get_Vehicles", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@DistrictID");
            }
            catch
            {
                //
            }
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
            _helper.FillDropDownHelperMethodWithSp("P_Report_VehicleHistoryReport", null, null, ddldistrict, ddlvehicle, null, null, "@district_id", "@VehID", "@Month", "@Year", null, Grddetails, ddlmonth, ddlyear);
        }
        catch
        {
            //
        }
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

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}