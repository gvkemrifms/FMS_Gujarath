using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleSummaryDistrictwise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDistrictdropdown();
            
        }
    }
    private void BindDistrictdropdown()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString()))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT district_id ds_dsid,district_name ds_lname from [m_district]  where state_id = 24 order by district_name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddldistrict.DataSource = ds;
            ddldistrict.DataTextField = "ds_lname";
            ddldistrict.DataValueField = "ds_dsid";
            ddldistrict.DataBind();
            ddldistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            con.Close();
        }
    }
   
    protected void btnsubmit_Click(object sender, EventArgs e)
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
            cmd.CommandText = "VAS_Districtwise_Vehicles_Inactive";
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@dsid", ddldistrict.SelectedItem.Text);
            //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
           // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
            adp.Fill(ds);
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                GridInactive.DataSource = dt;
                GridInactive.DataBind();
            }
            else
            {
                GridInactive.DataSource = null;
                GridInactive.DataBind();
            }

        

            conn.Open();

            cmd.Connection = conn;
        
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "VAS_Districtwise_Vehicles_Active";
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@dsid", ddldistrict.SelectedItem.Value);
            //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
            // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
            adp.Fill(ds);
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                GridActive.DataSource = dt;
                GridActive.DataBind();
            }
            else
            {
                GridActive.DataSource = null;
                GridActive.DataBind();
            }

        }
        catch (Exception ex)
        {

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
}