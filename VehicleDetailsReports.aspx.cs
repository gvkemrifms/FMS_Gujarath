using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;

public partial class VehicleDetailsReports : Page
{
    private readonly VehicleRegistration _vehreg = new VehicleRegistration();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {
            GetDistricts();
            CheckUser();
            ddlVehNumber.Enabled = false;
        }
    }

    protected void GetVehicleDetailsReport()
    {
        var reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        var vehicleDetailsreport = reportpath + "FMSReport_VehicleInsuranceDetails&rs%3aCommand=Render&rc:Parameters=false&rc:Toolbar=false&DistrictID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&VehicleID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&From=" + Convert.ToDateTime(txtFrom.Text) + "&To=" + Convert.ToDateTime(txtEnd.Text);
        iframe_VehicleDetailsReport.Attributes.Add("src", vehicleDetailsreport);
    }

    public void GetDistricts()
    {
        try
        {
            var ds = _vehreg.GetDistrcts(); //FMS.BLL.VehicleRegistration.GetDistrcts();
            if (ds == null) return;
            _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlDistrict);
            ddlDistrict.Items.Insert(1, new ListItem("All", "-1"));
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        var reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        var vehicleDetailsReport = reportpath + "FMSReport_VehicleInsuranceDetails&rs%3aCommand=Render&rc:Parameters=false&rs:Format=EXCEL&DistrictID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&VehicleID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&From=" + Convert.ToDateTime(txtFrom.Text) + "&To=" + Convert.ToDateTime(txtEnd.Text);
        Response.Redirect(vehicleDetailsReport);
    }

    protected void CheckUser()
    {
        _vehreg.DistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        switch (_vehreg.DistrictId)
        {
            case -1:
                ddlDistrict.Items.FindByValue("0").Selected = true;
                break;
            default:
                ddlDistrict.Items.FindByValue(_vehreg.DistrictId.ToString()).Selected = true;
                ddlDistrict.Enabled = false;
                break;
        }
    }

    protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlVehNumber.Enabled = true;
            var districtIdssn = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            var ds = _vehreg.VehicleNumber(districtIdssn);
            if (ds == null) return;
            _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", ddlVehNumber);
            ddlVehNumber.Items.Insert(1, new ListItem("All", "-1"));
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    protected void btnShowReport_Click(object sender, EventArgs e)
    {      
          _vehreg.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
           GetVehicleDetailsReport();
    }


    protected void ddlVehNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        _vehreg.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }
}