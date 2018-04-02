using System;
using System.Web.UI;

public partial class InvoiceTrackingReport : Page
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
            AccidentReport.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", null, ddlvehicle);
 
        }
        catch 
        {
//
        }
    }
    protected void ddlvehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlvehicle.SelectedIndex <= 0)
        {
            ddlbillno.Enabled = false;
        }
        else
        {
            ddlbillno.Enabled = true;


            try
            {
                AccidentReport.FillDropDownHelperMethodWithSp("P_GetBillNo", "Billno", "Billno", ddlvehicle, ddlbillno,
                    null, null, "@vehNo");
            }
            catch
            {
                //
            }
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_Reports_VenwiseInvoiceTracking", "", "", ddlvehicle, ddlbillno, null, null, "@VehicleNo", "@BillNo",null,null,null,Grddetails);
           
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
}
