using System;

public partial class EnquiryScreenReportnew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindVehicledropdown();
    }
    private void BindVehicledropdown()
    {
        try
        {
            string sqlQuery = "select vehicleid,vehicleNumber from M_FMS_Vehicles";
            AccidentReport.FillDropDownHelperMethod(sqlQuery, "VehicleNumber", "VehicleID", ddlvehicle);
           
        }
        catch (Exception)
        {
            // ignored
        }
    }
}