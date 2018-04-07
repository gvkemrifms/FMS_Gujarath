using System;
using System.Web.UI;

public partial class OutstandingSummaryReport : Page
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
        string sqlQuery = "select ds_dsid,ds_lname from M_FMS_Districts";
        _helper.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);

    }
    public void Withoutdist()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_Report_VendorWiseBillsOutstandingSummaryReport", null, null, null, null, null, null, null, null, null, null, null, Grdsummary);

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
    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_Report_VendorWiseBillsOutstandingSummaryReport", null, null, ddldistrict, null, null, null, "@districtID", null, null, null, null, Grdsummary);

        }
        catch
        {
            //
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
