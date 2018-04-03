﻿using System;
using System.Web.UI;

public partial class TyreAndBatteryReport : Page
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
            string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
            AccidentReport.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
            
        }
        catch 
        {
            //
        }
    }
    public void Withoutdist()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_TyreReportBattery1", null, null, null, null, null, null, null, null, null, null, null, GrdtyreBattery);
            

        }
        catch 
        {
            // ignored
        }
    }
    public void Loaddata()
    {
        try
        {
            AccidentReport.FillDropDownHelperMethodWithSp("P_FMSReports_TyreReportBattery1", null, null, ddldistrict, null, null, null, "@DistrictID", null, null, null, null, GrdtyreBattery);
            
        }
        catch 
        {
            //
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        switch (ddldistrict.SelectedValue)
        {
            case "0":
                Withoutdist();
                break;
            default:
                Loaddata();
                break;
        }
    }
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            AccidentReport report = new AccidentReport();
            report.LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");
            
        }
        catch
        {
            // Response.Write(ex.Message.ToString());
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }

}