using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleSummaryAll : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
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
            cmd.CommandText = "vas_allvehicleregin";
            conn.Close();
            //ImageButton1.Enabled = true;
            //cmd.Parameters.AddWithValue("@dsid", ddldistrict.SelectedItem.Value);
            //cmd.Parameters.AddWithValue("@fromtime", txtfromdate.Text + " 00:00:00");
            // cmd.Parameters.AddWithValue("@totime", txttodate.Text + " 23:59:59");
            adp.Fill(ds);
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                GrdtotalData.DataSource = dt;
                GrdtotalData.DataBind();
            }
            else
            {
                GrdtotalData.DataSource = null;
                GrdtotalData.DataBind();
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
            Response.AddHeader("content-disposition", "attachment; filename=VehicleSummaryAll.xls");
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
   