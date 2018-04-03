using System;
using System.Web.UI;

public partial class ScheduleMaintenanceStatusReport : Page
{
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
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);

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
                AccidentReport.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", null, null, ddldistrict, ddlvehicle,
                    null, null, "@districtID");
            }
            catch
            {
                //
            }
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_Reports_Sch_Maint_Status", null, null, ddldistrict, ddlvehicle, null, null, "@DistrictID", "@VehicleID", null, null, null, Grddetails);


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