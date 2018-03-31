using System;
using System.Web.UI;

public partial class BillsOutstandingSummaryReport : Page
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
        catch (Exception)
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
                AccidentReport.FillDropDownHelperMethodWithSp("P_Get_Agency", "AgencyName", "AgencyID", ddldistrict, ddlvendor, null, null, "@DistrictID");


            }
            catch (Exception)
            {
                // ignored
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
            AccidentReport.FillDropDownHelperMethodWithSp("P_Report_VendorWiseBillsOutstandingSummaryReport", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grddetails);


        }
        catch (Exception)
        {
            // ignored
        }
    }
}