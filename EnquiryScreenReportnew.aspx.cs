using System;

public partial class EnquiryScreenReportnew : System.Web.UI.Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindVehicledropdown();
    }

    private void BindVehicledropdown()
    {
        try
        {
            var sqlQuery = "select vehicleid,vehicleNumber from M_FMS_Vehicles";
            _helper.FillDropDownHelperMethod(sqlQuery, "VehicleNumber", "VehicleID", ddlvehicle);
        }
        catch (Exception)
        {
            // ignored
        }
    }
}