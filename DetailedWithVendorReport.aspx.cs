using System;
using System.Web.UI;

public partial class DetailedWithVendorReport : Page
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
        string sqlQuery = "select ds_dsid,ds_lname from M_FMS_Districts";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);

    }
    public void Withoutdist()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVendor", null, null, null, null, null, null, null, null, null, null, null, Grdvendor);

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
            report.LoadExcelSpreadSheet(Panel2);
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
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_SummaryDetailedWithVendor", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grdvendor);



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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedValue == "0")
        {
            Withoutdist();

        }
        else
        {
            Loaddata();


        }
    }

}