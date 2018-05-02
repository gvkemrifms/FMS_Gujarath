using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;

public partial class VehicleCardTypeReport : Page
{
    readonly VehicleRegistration _vehreg = new VehicleRegistration();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {
            GetDistricts();
            CheckUser();
        }
    }

    protected void GetVehicleCardTypeReport()
    {
        string reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        string vehicleCardTypeReport = reportpath + "FMSReport_GetCardType&rs%3aCommand=Render&rc:Parameters=false&rc:Toolbar=false&DistrictID=" + _vehreg.DistrictId + "&BunkID=" + Convert.ToInt16(ddlSSN.SelectedItem.Value);
        iframe_VehicleCardTypeReport.Attributes.Add("src", vehicleCardTypeReport);
    }

    public void GetDistricts()
    {
        try
        {
            DataSet ds = _vehreg.GetDistrcts(); //FMS.BLL.VehicleRegistration.GetDistrcts();
            if (ds != null)
            {
                _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlDistrict);
                ddlDistrict.Items.Insert(1, new ListItem("All", "-1"));
            }
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        string reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        string vehicleCardTypeReport = reportpath + "FMSReport_GetCardType&rs%3aCommand=Render&rc:Parameters=false&rs:Format=EXCEL&DistrictID=" + Convert.ToInt16(ddlDistrict.SelectedItem.Value) + "&BunkID=" + Convert.ToInt16(ddlSSN.SelectedItem.Value);
        Response.Redirect(vehicleCardTypeReport);
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
            int districtIdssn = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            DataSet ds = _vehreg.GetServiceStn(districtIdssn);
            if (ds != null)
            {
                _helper.FillDropDownHelperMethodWithDataSet(ds, "ServiceStation_Name", "Id", ddlSSN);
                ddlSSN.Items.Insert(1, new ListItem("All", "-1"));
            }
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    protected void ddlSSN_SelectedIndexChanged(object sender, EventArgs e)
    {
        _vehreg.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        GetVehicleCardTypeReport();
    }
}