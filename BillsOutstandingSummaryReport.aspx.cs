using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BillsOutstandingSummaryReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindDistrictdropdown();
            // withoutdist();
        }
    }
    private void BindDistrictdropdown()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString()))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("select district_id,district_name from m_district  where state_id= 24 and is_active = 1", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddldistrict.DataSource = ds;
            ddldistrict.DataTextField = "district_name";
            ddldistrict.DataValueField = "district_id";
            ddldistrict.DataBind();
            ddldistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            con.Close();
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
    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvendor.Enabled = true;


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
                cmd.CommandText = "P_Get_Agency";


                //ImageButton1.Enabled = true;
                cmd.Parameters.AddWithValue("@DistrictID", ddldistrict.SelectedItem.Value);
                //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
                // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
                adp.Fill(ds);
                ddlvendor.DataSource = ds.Tables[0];
                ddlvendor.DataTextField = "AgencyName";
                ddlvendor.DataValueField = "AgencyID";
                ddlvendor.DataBind();
                ddlvendor.Items.Insert(0, new ListItem("--Select--", "0"));
                conn.Close();



            }
            catch (Exception ex)
            {

            }
        }
        else
        {
            ddlvendor.Enabled = false;
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
            cmd.CommandText = "P_Report_VendorWiseBillsOutstandingSummaryReport";
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@DistrictID", ddldistrict.SelectedItem.Value);
           // cmd.Parameters.AddWithValue("@VendorID", ddlvendor.SelectedItem.Value);
           // cmd.Parameters.AddWithValue("@From", txtfrmDate.Text + " 00:00:00");
           // cmd.Parameters.AddWithValue("@To", txttodate.Text + " 23:59:59");
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
}