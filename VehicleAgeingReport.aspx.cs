using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;

public partial class VehicleAgeingReport : Page
{
    private readonly VehicleRegistration _vehreg = new VehicleRegistration();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDistricts();
            CheckUser();
            GetVehicleAgeingReport();
        }
    }

    protected void GetVehicleAgeingReport()
    {
        var reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        var vehicleageingreport = reportpath + "FMSReport_VehicleAging&rs%3aCommand=Render&rc:Parameters=false&rc:Toolbar=false&districtid=" + _vehreg.DistrictId;
        iframe_VehicleAgeingReport.Attributes.Add("src", vehicleageingreport);
    }

    public void GetDistricts()
    {
        var ds = _vehreg.GetDistrcts(); //FMS.BLL.VehicleRegistration.GetDistrcts();
        if (ds == null) return;
        _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlDistrict);
        ddlDistrict.Items.Insert(1, new ListItem("All", "-1"));
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        var reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        var vehicleageingreport = reportpath + "FMSReport_VehicleAging&rs%3aCommand=Render&rc:Parameters=false&rs:Format=EXCEL&districtid=" + Convert.ToInt16(ddlDistrict.SelectedItem.Value);
        Response.Redirect(vehicleageingreport);
    }

    protected void CheckUser()
    {
        _vehreg.DistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        switch (_vehreg.DistrictId)
        {
            case -1:
                ddlDistrict.Items.FindByValue("-1").Selected = true;
                break;
            default:
                ddlDistrict.Items.FindByValue(_vehreg.DistrictId.ToString()).Selected = true;
                ddlDistrict.Enabled = false;
                break;
        }
    }

    protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        _vehreg.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        GetVehicleAgeingReport();
    }
}