using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;

public partial class VehicleHistoryReport : Page
{
    private readonly VehicleRegistration _vehreg = new VehicleRegistration();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDistricts();
            CheckUser();
            ddlVehNumber.Enabled = false;
            ddlMonth.Enabled = false;
            ddlYear.Enabled = false;
        }
    }

    protected void GetVehicleHistoryReport()
    {
        var reportpath = ConfigurationManager.AppSettings["reportServerPath"] + "?%2f" + ConfigurationManager.AppSettings["reportFolderPath"] + "%2f";
        var vehiclehistoryreport = reportpath + "FMSReport_VehicleHistory&rs%3aCommand=Render&rc:Parameters=false&rc:Toolbar=false&district_id=" + _vehreg.DistrictId + "&VehID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&Month=" + Convert.ToInt16(ddlMonth.SelectedItem.Value) + "&Year=" + Convert.ToInt16(ddlYear.SelectedItem.Value);
        iframe_VehicleHistoryReport.Attributes.Add("src", vehiclehistoryreport);
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
        var vehiclehistoryreport = reportpath + "FMSReport_VehicleHistory&rs%3aCommand=Render&rc:Parameters=false&rs:Format=EXCEL&district_id=" + Convert.ToInt16(ddlDistrict.SelectedItem.Value) + "&VehID=" + Convert.ToInt16(ddlVehNumber.SelectedItem.Value) + "&Month=" + Convert.ToInt16(ddlMonth.SelectedItem.Value) + "&Year=" + Convert.ToInt16(ddlYear.SelectedItem.Value);
        Response.Redirect(vehiclehistoryreport);
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
        ddlVehNumber.Enabled = true;
        var districtIdssn = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        var ds = _vehreg.VehicleNumber(districtIdssn);
        if (ds == null) return;
        _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", ddlVehNumber);
        ddlVehNumber.Items.Insert(1, new ListItem("All", "-1"));
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlYear.Enabled = true;
    }

    protected void btnShowRpt_Click(object sender, EventArgs e)
    {
        if (ddlDistrict.SelectedIndex == 0)
            Show("Select District");
        else if (ddlVehNumber.SelectedIndex == 0)
            Show("Select Vehicle");
        else
        {
            if (ddlMonth.SelectedIndex == 0)
                Show("Select Month");
            else
                switch (ddlYear.SelectedIndex)
                {
                    case 0:
                        Show("Select Year");
                        break;
                    default:
                        _vehreg.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
                        GetVehicleHistoryReport();
                        break;
                }
        }
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    protected void ddlVehNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlMonth.Enabled = true;
    }

    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        iframe_VehicleHistoryReport.Visible = false;
    }
}