using System;
using System.Web.UI;

public partial class DetailedWithVehicleModelReport : Page
{
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
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);
    }

    public void Withoutdist()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVehicleModel", null, null, null, null, null, null, null, null, null, null, null, Grdvehmodel);
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
            var report = new AccidentReport();
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch (Exception)
        {
            // Response.Write(ex.Message.ToString());
        }
    }

    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVehicleModel", null, null, null, null, null, null, "@DistrictID", null, null, null, null, Grdvehmodel);
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