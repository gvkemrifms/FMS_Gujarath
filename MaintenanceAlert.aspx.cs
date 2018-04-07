using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;

public partial class MaintenanceAlert : Page
{
    readonly Helper _helper = new Helper();
    private readonly GvkFMSAPP.BLL.Alert.Alert _fmsAlert = new GvkFMSAPP.BLL.Alert.Alert();
    private readonly VehicleRegistration _vehreg = new VehicleRegistration();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
           
        GetVehicles();          
    }

    protected void FillGrid()
    {
        _fmsAlert.UserDistId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        _fmsAlert.VehNum = Convert.ToString(ddlVehicle.SelectedItem.Text);
        var ds = _fmsAlert.GetMaintenanceAlert();
        ViewState["ds"] = ds;
        grdMaintAlert.DataSource = ds;
        grdMaintAlert.DataBind();
    }

    public void GetVehicles()
    {
        var ds = _vehreg.GetvehiclesReport(); //FMS.BLL.VehicleRegistration.GetDistrcts();
        if (ds != null) _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", null, ddlVehicle);
    }

    public string CreateHtml(DataSet ds)
    {
        var htmlText = "";
        if (ds.Tables.Count > 0)
        {
            htmlText = "<table border='1' cellpadding='2'  WIDTH='75%' ";
            htmlText += "<tr><th>Vehicle Number</th><th>Latest Odometer</th><th>Last Maintenance Odo</th>";
            htmlText += "<th>Last Maintenance Date</th><th>Service Alert</th>";
            htmlText += "</tr>";
            if (ds.Tables.Count > 0)
            {
                for (var i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    htmlText += "<tr>";
                    htmlText += "<td> " + ds.Tables[0].Rows[i]["VehicleNumber"] + " </td>";
                    htmlText += "<td>" + ds.Tables[0].Rows[i]["Latest_odo"] + "</td>";
                    htmlText += "<td>" + ds.Tables[0].Rows[i]["LastMaintenanceOdo"] + "</td>";
                    htmlText += "<td>" + ds.Tables[0].Rows[i]["LastMaintenanceDate"] + "</td>";
                    htmlText += "<td> " + ds.Tables[0].Rows[i]["servicealert"] + " </td>";
                    htmlText += "</tr>";
                }

                htmlText += "</table>";
            }
        }

        return htmlText;
    }

    protected void grdMaintAlert_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdMaintAlert.PageIndex = e.NewPageIndex;
        FillGrid();
    }

    protected void btnSendMail_Click1(object sender, EventArgs e)
    {
        var subject = "";
        var mailBody = "";
        subject = "Vehicle Maintenance Alert";
        mailBody = CreateHtml((DataSet) ViewState["ds"]);
        MailHelper.SendMailMessage(ConfigurationManager.AppSettings["MasterMailid"], ConfigurationManager.AppSettings["AdminMailid"], "", "", subject, mailBody);
    }

    protected void ddlVehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlVehicle.SelectedItem.Text != string.Empty) FillGrid();
    }
}