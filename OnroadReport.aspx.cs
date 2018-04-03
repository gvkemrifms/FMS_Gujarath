using System;
using System.Web.UI;
using System.Data;

public partial class OnroadReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        var select = " select distinct orv.OffRoadVehcileId OffRoadVehcileId,orv.District District, orv.OffRoadVehicleNo VehicleNumber,orv.ReasonForOffRoad ReasonForOffRoad, orv.OffRoadDate OffRoadDate,orv.ContactNumber ContactNumber, totEstCost,ExpDateOfRecovery, ";
        select = select + "orv.Odometer downodo,orv.RequestedBy RequestedBy,PilotName,totEstCost  from dbo.T_FMS_OffRoadVehicles  orv left join T_FMS_OffRoadVehAllocation va on orv.OffRoadVehicleNo=va.OffRoadVehicleNo  and orv.OffRoadDate=va.DownTime      where   OffRoadVehAlloId is null and    active = 1";
        var dt = AccidentReport.ExecuteSelectStmt(select);
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        var report = new AccidentReport();
        report.LoadExcelSpreadSheet(null, "gvtoexcel.xls", GridView1);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}