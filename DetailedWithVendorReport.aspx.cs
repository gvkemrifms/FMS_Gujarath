using System;
using System.Web.UI;

public partial class DetailedWithVendorReport : Page
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
        var sqlQuery = "select ds_dsid,ds_lname from M_FMS_Districts";
        _helper.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);
    }

    public void Withoutdist()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVendor", null, null, null, null, null, null, null, null, null, null, null, Grdvendor);
        }
        catch (Exception)
        {
            // ignored
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

    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVendor", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grdvendor);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        switch (ddldistrict.SelectedValue)
        {
            case "0":
                Withoutdist();
                break;
            default:
                Loaddata();
                break;
        }
    }
}