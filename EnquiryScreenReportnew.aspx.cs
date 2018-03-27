using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString()))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select vehicleid,vehicleNumber from M_FMS_Vehicles", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                ddlvehicle.DataSource = ds.Tables[0];
                ddlvehicle.DataTextField = "VehicleNumber";
                ddlvehicle.DataValueField = "VehicleID";
                ddlvehicle.DataBind();
                ddlvehicle.Items.Insert(0, new ListItem("--Select--", "0"));
                con.Close();
            }
        }
        catch (Exception e)
        {

        }
    }
}