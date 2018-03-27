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

public partial class OnroadReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        var select = " select distinct orv.OffRoadVehcileId OffRoadVehcileId,orv.District District, orv.OffRoadVehicleNo VehicleNumber,orv.ReasonForOffRoad ReasonForOffRoad, orv.OffRoadDate OffRoadDate,orv.ContactNumber ContactNumber, totEstCost,ExpDateOfRecovery, ";
		select = select + "orv.Odometer downodo,orv.RequestedBy RequestedBy,PilotName,totEstCost  from dbo.T_FMS_OffRoadVehicles  orv left join T_FMS_OffRoadVehAllocation va on orv.OffRoadVehicleNo=va.OffRoadVehicleNo  and orv.OffRoadDate=va.DownTime      where   OffRoadVehAlloId is null and    active = 1";

        var c = new SqlConnection("Data Source=localhost;Initial Catalog=FMS4.0;Persist Security Info=True;User ID=sa;password=emri123$;");
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