﻿using System;
using System.Web.UI;

public partial class VehicleSummaryAll : Page
{
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            _helper.FillDropDownHelperMethodWithSp("vas_allvehicleregin", null, null, null, null, null, null, null, null, null, null, null, GrdtotalData);
        }
        catch
        {
            //
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            _helper.LoadExcelSpreadSheet(this,Panel2, "VehicleSummaryAll.xls");
        }
        catch
        {
            // Response.Write(ex.Message.ToString());
        }
    }
}
   