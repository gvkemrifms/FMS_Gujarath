﻿using System;
using System.Web.UI;

public partial class AnalysisHourwiseReport : Page
{
    readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
        }
    }

    private void BindDistrictdropdown()
    {
        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }

    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvehicle.Enabled = true;
            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddlvehicle, null, null, null, "@districtID");
            }
            catch (Exception)
            {
                // ignored
            }
        }
        else
        {
            ddlvehicle.Enabled = false;
        }
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

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }

    public void Loaddata()
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("P_Report_AccidentAnalysisHourwise", null, null, ddldistrict, ddlvehicle, txtfrmDate, txttodate, "@DistrictID", "@VehicleID", "@From", "@To", null, Grddetails);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}