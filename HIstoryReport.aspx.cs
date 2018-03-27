using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HIstoryReport : System.Web.UI.Page
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
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString()))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select ds_dsid,ds_lname from M_FMS_Districts", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                ddldistrict.DataSource = ds.Tables[0];
                ddldistrict.DataTextField = "ds_lname";
                ddldistrict.DataValueField = "ds_dsid";
                ddldistrict.DataBind();
                ddldistrict.Items.Insert(0, new ListItem("--Select--", "0"));
                con.Close();
            }
        }
        catch (Exception e)
        {

        }
    }

    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
       if(ddldistrict.SelectedIndex>0)
        {
            ddlvehicle.Enabled = true;


            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString());
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "P_Get_Vehicles";

                
                //ImageButton1.Enabled = true;
                cmd.Parameters.AddWithValue("@DistrictID", ddldistrict.SelectedItem.Value);
                //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
                // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
                adp.Fill(ds);
                ddlvehicle.DataSource = ds.Tables[0];
                ddlvehicle.DataTextField = "VehicleNumber";
                ddlvehicle.DataValueField = "VehicleID";
                ddlvehicle.DataBind();
                ddlvehicle.Items.Insert(0, new ListItem("--Select--", "0"));
                conn.Close();
             


            }
            catch (Exception ex)
            {

            }
        }
       else
        {
            ddlvehicle.Enabled = false;
        }
      

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        loaddata();
    }
    public void loaddata()
    {
        try
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString());
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[P_Report_VehicleHistoryReport]";
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@district_id", ddldistrict.SelectedItem.Value);
             cmd.Parameters.AddWithValue("@VehID", ddlvehicle.SelectedItem.Value);
             cmd.Parameters.AddWithValue("@Month", ddlmonth.Text);
             cmd.Parameters.AddWithValue("@Year", ddlyear.Text );
            adp.Fill(ds);
            dt = ds.Tables[0];
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
        catch (Exception ex)
        {

        }
    }
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=VehicleSummaryDistrictwise.xls");
            Response.ContentType = "application/excel";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Panel2.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }
        catch (Exception ex)
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