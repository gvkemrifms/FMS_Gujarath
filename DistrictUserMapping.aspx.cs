using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL.Admin;
using ServiceReference2;

public partial class DistrictUserMapping : Page
{
    private readonly DistrictVehicleMapping _distvehmapp = new DistrictVehicleMapping();
    readonly DistrictUserMappping _distUserMapping = new DistrictUserMappping();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Error.aspx");
        if (!IsPostBack)
        {
            btnMapping.Attributes.Add("onclick", "return validation()");
            FillUserList();
            GetDistrict();
        }
    }

    public void FillUserList()
    {
        ACLServiceClient client = new ACLServiceClient();
        DataSet ds = client.GetUsersList(0, 0, "FMSGlobalization", "");
        if (ds != null) _helper.FillDropDownHelperMethodWithDataSet(ds, "Login_Name", "PK_USER_ID", ddlUserList);
        ddlUserList.Items.Remove("FMSAdminUser");
    }

    public void GetDistrict()
    {
        DataSet ds = _distvehmapp.GetDistrict();
        if (ds != null)
        {
            chkDistrictList.DataSource = ds;
            chkDistrictList.DataTextField = "district_name";
            chkDistrictList.DataValueField = "district_id";
            chkDistrictList.DataBind();
        }
    }

    protected void btnMapping_Click(object sender, EventArgs e)
    {
        ArrayList districtIds = new ArrayList();
        foreach (ListItem lstSelectedDistrict in chkDistrictList.Items)
        {
            if (lstSelectedDistrict.Selected) districtIds.Add(lstSelectedDistrict.Value);
        }

        if (districtIds.Count > 0)
        {
            int ret = _distUserMapping.InsertDistrictUserMapping(Convert.ToInt32(ddlUserList.SelectedItem.Value), districtIds);
            Show(ret != 0 ? "User Mapped to district Successfully" : "Error");
        }
        else
            Show("Select District");

        ClearControls();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearControls();
    }

    protected void ddlUserList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ArrayList districtId = new ArrayList();
        if (ddlUserList.SelectedIndex == 0) return;
        DataSet ds = _distUserMapping.GetSelectedDistrictByUserList(Convert.ToInt32(ddlUserList.SelectedItem.Value));
        foreach (DataRow dr in ds.Tables[0].Rows) districtId.Add(dr["DistrictId"].ToString());
        foreach (ListItem lstSelectedDistrict in chkDistrictList.Items) lstSelectedDistrict.Selected = districtId.Contains(lstSelectedDistrict.Value);
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    public void ClearControls()
    {
        ddlUserList.SelectedIndex = 0;
        foreach (ListItem lstSelectedDistricts in chkDistrictList.Items) lstSelectedDistricts.Selected = false;
    }
}