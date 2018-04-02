using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class HIstoryReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {



        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
        }
    }
    private void BindDistrictdropdown()
    {
        try
        {
            string sqlQuery = "select ds_dsid,ds_lname from M_FMS_Districts";
            AccidentReport.FillDropDownHelperMethod(sqlQuery, "ds_lname", "ds_dsid", ddldistrict);

        }
        catch
        {
            //
        }
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
                AccidentReport.FillDropDownHelperMethodWithSp("P_Get_Vehicles", "VehicleNumber", "VehicleID",
                    ddldistrict, ddlvehicle, null, null, "@DistrictID");
            }
            catch
            {
                //
            }
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
                CommandText = "[P_Report_VehicleHistoryReport]"
            };
            var adp = new SqlDataAdapter(cmd);
            
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@district_id", ddldistrict.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@VehID", ddlvehicle.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@Month", ddlmonth.Text);
            cmd.Parameters.AddWithValue("@Year", ddlyear.Text);
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
}