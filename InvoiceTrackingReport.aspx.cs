using System;
using System.Web.UI;

public partial class InvoiceTrackingReport : Page
{
    readonly Helper _helper = new Helper();
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
            _helper.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", null, ddlvehicle);
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
                _helper.FillDropDownHelperMethodWithSp("P_GetBillNo", "Billno", "Billno", ddlvehicle, ddlbillno, null, null, "@vehNo");
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
            _helper.LoadExcelSpreadSheet(this,Panel2, "VehicleSummaryDistrictwise.xls");
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
            _helper.FillDropDownHelperMethodWithSp("P_Reports_VenwiseInvoiceTracking", "", "", ddlvehicle, ddlbillno, null, null, "@VehicleNo", "@BillNo", null, null, null, Grddetails);
        }
        catch
        {
            //
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}