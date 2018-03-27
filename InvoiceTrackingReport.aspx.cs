using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InvoiceTrackingReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            ddlbillno.Enabled = false;
            Bindvehiclesdropdown();
            // withoutdist();
        }
    }
    private void Bindvehiclesdropdown()
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
            cmd.CommandText = "P_GetVehicleNumber";


            //ImageButton1.Enabled = true;
           // cmd.Parameters.AddWithValue("@districtID", ddldistrict.SelectedItem.Value);
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
    protected void ddlvehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlvehicle.SelectedIndex > 0)
        {
            ddlbillno.Enabled = true;


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
                cmd.CommandText = "P_GetBillNo";


                //ImageButton1.Enabled = true;
                 cmd.Parameters.AddWithValue("@vehNo", ddlvehicle.SelectedItem.Value);
                //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
                // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
                adp.Fill(ds);
                ddlbillno.DataSource = ds.Tables[0];
                ddlbillno.DataTextField = "Billno";
                //ddlbillno.DataValueField = "VehicleID";
                ddlbillno.DataBind();
                ddlbillno.Items.Insert(0, new ListItem("--Select--", "0"));
                conn.Close();



            }
            catch (Exception ex)
            {

            }
        }
        else
        {
            ddlbillno.Enabled = false;
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
            cmd.CommandText = "P_Reports_VenwiseInvoiceTracking";
            conn.Close();
            //ImageButton1.Enabled = true;
            cmd.Parameters.AddWithValue("@VehicleNo", ddlvehicle.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@BillNo", ddlbillno.SelectedItem.Value);
            //cmd.Parameters.AddWithValue("@From", txtfrmDate.Text + " 00:00:00");
            //cmd.Parameters.AddWithValue("@To", txttodate.Text + " 23:59:59");
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
}
