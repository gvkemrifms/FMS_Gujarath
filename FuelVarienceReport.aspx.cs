﻿using System;
using System.Web.UI;

public partial class FuelVarienceReport : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
            Bindbunkdropdown();
        }
    }

    private void Bindbunkdropdown()
    {
        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddlbunk);
    }

    private void BindDistrictdropdown()
    {
        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        _helper.FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }

    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex <= 0)
            ddlvehicle.Enabled = false;
        else
        {
            ddlvehicle.Enabled = true;
            try
            {
                _helper.FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@districtID");
            }
            catch
            {
                //Ex
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
            _helper.FillDropDownHelperMethodWithSp("P_FMSReports_FuelVariance", null, null, ddldistrict, ddlvehicle, txtfrmDate, txttodate, "@districtID", "@VehicleID", "@From", "@To", null, Grddetails);
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