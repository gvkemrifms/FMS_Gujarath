﻿using System;
using System.Web.UI;

public partial class BillProcessingManagementReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDistrictdropdown();
            Withoutdist();
        }
    }

    private void BindDistrictdropdown()
    {
        try
        {
            var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
            AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public void Withoutdist()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_Report_BillProcessingManagement", null, null, null, null, null, null, null, null, null, null, null, Grdtyre);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_Report_BillProcessingManagement", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, Grdtyre);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (ddldistrict != null && ddldistrict.SelectedValue == "0")
            Withoutdist();
        else
            Loaddata();
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            var report = new AccidentReport();
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch (Exception)
        {
            // Response.Write(ex.Message.ToString());
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}