using System;
using System.Web.UI;
public partial class AgeingReportnew : Page
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
        try
        {

            string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
            AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
        }

        catch (Exception)
        {
            // ignored
        }
    }
    public void Withoutdist()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_VehicleAgeingReport", null, null, null, null, null, null, null, null, null, null, null, Grdtyre);
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
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_VehicleAgeingReport", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grdtyre);

        }
        catch (Exception)
        {
            // ignored
        }
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
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            AccidentReport report = new AccidentReport();
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");

        }
        catch 
        {
            //
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }

}