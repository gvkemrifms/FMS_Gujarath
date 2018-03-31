using System;
using System.Web.UI;

public partial class FuelEntryDetailsReport : Page
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
        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    #region CommentedCode
    //public void withoutdist()
    //{
    //    try
    //    {
    //        SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"].ToString());
    //        DataSet ds = new DataSet();
    //        DataTable dt = new DataTable();
    //        conn.Open();
    //        SqlCommand cmd = new SqlCommand();
    //        cmd.Connection = conn;
    //        SqlDataAdapter adp = new SqlDataAdapter(cmd);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.CommandText = "P_FMSReports_GetFuelEntryDetails";
    //        conn.Close();
    //        //ImageButton1.Enabled = true;
    //        //cmd.Parameters.AddWithValue("@DistrictID", ddldistrict.SelectedItem.Value);
    //        //cmd.Parameters.AddWithValue("@VehicleID", ddlvehicle.SelectedItem.Value);
    //        // cmd.Parameters.AddWithValue("@From", txtfrmDate.Text + " 00:00:00");
    //        // cmd.Parameters.AddWithValue("@End", txttodate.Text + " 23:59:59");
    //        adp.Fill(ds);
    //        dt = ds.Tables[0];
    //        if (dt.Rows.Count > 0)
    //        {
    //            Grddetails.DataSource = dt;
    //            Grddetails.DataBind();
    //        }
    //        else
    //        {
    //            Grddetails.DataSource = null;
    //            Grddetails.DataBind();
    //        }

    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}
    #endregion

    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_GetFuelEntryDetails", null, null, ddldistrict, null, null, null, "@DistrictID",null,null,null,null, Grddetails);
        }
        catch 
        {
            // ignored
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }

}
