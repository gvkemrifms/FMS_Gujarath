using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Globalization;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class FuelReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {



  
var select = " SELECT distinct  v.VehicleNumber,tbl.fuelentryid , hist.Odometer 'Previous_odo',  tbl.Odometer 'present_odo', tbl.Quantity, "
       + " tbl.Location, tbl.KMPL, tbl.Odometer - hist.Odometer 'Totalkm_Run', tbl.EntryDate, tbl.Pilot, tbl.PilotName, "
	+ "         tbl.Amount  FROM dbo.T_FMS_FuelEntryDetails tbl join [dbo].[M_FMS_Vehicles] v on "
     + "  tbl.VehicleID = v.VehicleID  INNER JOIN dbo.T_FMS_FuelEntryDetails hist ON hist.VehicleID = tbl.VehicleID "
     + "   AND hist.EntryDate = (SELECT MAX(EntryDate) FROM dbo.T_FMS_FuelEntryDetails sub WHERE sub.VehicleID = tbl.VehicleID "
     + "   AND sub.EntryDate < tbl.EntryDate ) and tbl.EntryDate between '" + txtfromdate.Text.Trim().ToString() + "' and '" + txttodate.Text.Trim().ToString() + "' union "
+ " SELECT distinct v.VehicleNumber,tbl.fuelentryid , 0 'Previous_odo',  tbl.Odometer 'present_odo', tbl.Quantity, "
    + "   tbl.Location, tbl.KMPL, tbl.Odometer - 0 'Totalkm_Run', tbl.EntryDate, tbl.Pilot, tbl.PilotName, "
+ " tbl.Amount  FROM dbo.T_FMS_FuelEntryDetails tbl join [dbo].[M_FMS_Vehicles] v on  tbl.VehicleID = v.VehicleID join "
	 + "  (select min(EntryDate) EntryDate, VehicleID from T_FMS_FuelEntryDetails tbl where tbl.EntryDate  between '" + txtfromdate.Text.Trim().ToString() + "' and '" + txttodate.Text.Trim().ToString() + "' "
	+ "   group by VehicleID ) stbl on stbl.VehicleID = tbl.VehicleID and tbl.EntryDate = stbl.EntryDate left join "
	+ "   (SELECT distinct  v.VehicleNumber,tbl.fuelentryid , hist.Odometer 'Previous_odo',  tbl.Odometer 'present_odo', tbl.Quantity, "
    + "   tbl.Location, tbl.KMPL, tbl.Odometer - hist.Odometer 'Totalkm_Run', tbl.EntryDate, tbl.Pilot, tbl.PilotName, "
    + "   tbl.Amount  FROM dbo.T_FMS_FuelEntryDetails tbl join [dbo].[M_FMS_Vehicles] v on "
    + "   tbl.VehicleID = v.VehicleID  INNER JOIN dbo.T_FMS_FuelEntryDetails hist ON hist.VehicleID = tbl.VehicleID "
    + "    AND hist.EntryDate = (SELECT MAX(EntryDate) FROM dbo.T_FMS_FuelEntryDetails sub WHERE sub.VehicleID = tbl.VehicleID "
     + "   AND sub.EntryDate < tbl.EntryDate ) and tbl.EntryDate between '" + txtfromdate.Text.Trim().ToString() + " 00:00:00' and '" + txttodate.Text.Trim().ToString() + " 23:59:59') tblo on "
	+ " tblo.FuelEntryID = tbl.FuelEntryID where tblo.FuelEntryID is null order by VehicleNumber ";


        var c = new SqlConnection("Data Source=localhost;Initial Catalog=FMS4.0;Persist Security Info=True;User ID=sa;password=emri123$;Connection Timeout=0");
        var dataAdapter = new SqlDataAdapter(select, c);

        var commandBuilder = new SqlCommandBuilder(dataAdapter);
        var ds = new DataSet();
        dataAdapter.Fill(ds);

        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();


    }
    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=gvtoexcel.xls");
        Response.ContentType = "application/excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
}