using System;
using System.Web.UI;

public partial class FuelVarienceReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
            Bindbunkdropdown();

            // withoutdist();
        }
    }
    private void Bindbunkdropdown()
    {
        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddlbunk);

    }
    private void BindDistrictdropdown()
    {
        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }
    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvehicle.Enabled = true;


            try
            {
                AccidentReport.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@districtID");


            }
            catch
            {
                //Ex
            }
        }
        else
        {
            ddlvehicle.Enabled = false;
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_FuelVariance", null, null, ddldistrict, ddlvehicle, txtfrmDate, txttodate, "@districtID", "@VehicleID", "@From", "@To");

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