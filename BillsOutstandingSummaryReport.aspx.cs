﻿using System;
using System.Web.UI;

public partial class BillsOutstandingSummaryReport : Page
{
    readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindDistrictdropdown();
    }

    private void BindDistrictdropdown()
    {
        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            _helper.LoadExcelSpreadSheet(this, Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch (Exception)
        {
            // Response.Write(ex.Message.ToString());
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex <= 0)
            ddlvendor.Enabled = false;
        else
        {
            ddlvendor.Enabled = true;
            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_Get_Agency", "AgencyName", "AgencyID", ddldistrict, ddlvendor, null, null, "@DistrictID");
            }
            catch (Exception)
            {
                // ignored
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
            _helper.FillDropDownHelperMethodWithSp("P_Report_VendorWiseBillsOutstandingSummaryReport", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grddetails);
        }
        catch (Exception)
        {
            // ignored
        }
    }
}