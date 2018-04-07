using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class SparePartwiseReport : Page
{
    readonly  Helper _helper=new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            ddlvendor.Enabled = false;
            BindDistrictdropdown();
        }
    }
    private void BindDistrictdropdown()
    {
        try
        {

            string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
            _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);

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
    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvehicle.Enabled = true;
            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@districtID");

            }
            catch
            {
                //
            }
        }
        else
        {
            ddlvehicle.Enabled = false;
        }
    }
    protected void ddlvehicle_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvendor.Enabled = true;


            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_Get_Agency", "AgencyName", "AgencyID", ddldistrict, ddlvendor, txtfrmDate, txttodate, "@DistrictID");
                SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString());

            }
            catch
            {
                //
            }
        }
        else
        {
            ddlvendor.Enabled = false;
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

            SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"]);
            var ds = new DataSet();
            conn.Open();
            SqlCommand cmd = new SqlCommand
            {
                Connection = conn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "P_Reports_SparePartsWise"
            };
            SqlDataAdapter adp = new SqlDataAdapter(cmd);

            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@DistrictID", ddldistrict.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@VehicleID", ddlvehicle.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@SpareVenName", ddlvendor.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@From", txtfrmDate.Text + " 00:00:00");
            cmd.Parameters.AddWithValue("@To", txttodate.Text + " 23:59:59");
            adp.Fill(ds);
            var dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                Grddetails.DataSource = dt;
                Grddetails.DataBind();
            }
            else
            {
                Grddetails.DataSource = null;
                Grddetails.DataBind();
            }
        }
        catch
        {
            //
        }
    }
}
