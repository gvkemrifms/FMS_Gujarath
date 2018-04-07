using System;
using System.Web.UI;

public partial class BillProcessingManagementReport : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDistrictdropdown();
            Withoutdist();
        }
    }

    private void BindDistrictdropdown()
    {
        try
        {
            var sqlQuery = "select district_id,district_name from m_district  where state_id= 30";
            _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
        }
        catch (Exception ex)
        {
            var exMessage = ex.Message;
            Response.Write(exMessage);
       
        }
    }

    public void Withoutdist()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_Report_BillProcessingManagement", null, null, null, null, null, null, null, null, null, null, null, Grdtyre);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_Report_BillProcessingManagement", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grdtyre);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (ddldistrict != null && ddldistrict.SelectedValue == "0")
            Withoutdist();
        else
            Loaddata();
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

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}