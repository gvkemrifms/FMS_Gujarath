using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;
using GvkFMSAPP.PL;
using ServiceReference2;

public partial class PetroCardIssue : Page
{
    private readonly IFuelManagement _objFuelMan = new FuelManagement();
    private readonly FMSGeneral _fmsg = new FMSGeneral();
    private readonly Helper _helper = new Helper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {
            if (Session["UserdistrictId"] != null) _fmsg.UserDistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
            FillDistricts();
            FillAgency();
            FillCardType();
            FillGridPetroCard();
            FillFeUsers();
            btSave.Attributes.Add("onclick", "return isMandatory()");
            txtPetroCardNumber.Attributes.Add("onkeypress", "return isNumberKey(this,event)");
            var dsPerms = (DataSet) Session["PermissionsDS"];
            dsPerms.Tables[0].DefaultView.RowFilter = "Url='" + Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1] + "'";
            var p = new PagePermissions(dsPerms, dsPerms.Tables[0].DefaultView[0]["Url"].ToString(), dsPerms.Tables[0].DefaultView[0]["Title"].ToString());
        }
    }

    protected void FillFeUsers()
    {
        var client = new ACLServiceClient();
        var ds = client.GetRoleBasedUsersList(int.Parse(ConfigurationManager.AppSettings["roleID"]));
        _helper.FillDropDownHelperMethodWithDataSet(ds, "LOGIN_NAME", "PK_USER_ID", dd_listFe);
    }

    private void FillDistricts()
    {
        var ds = _objFuelMan.IFillDistricts();
        _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlFeuserDistrict);
        ddlFeuserDistrict.SelectedIndex = 0;
    }

    protected void ddlDistricts_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    private void FillCardType()
    {
        var ds = _objFuelMan.IFillCardType();
        _helper.FillDropDownHelperMethodWithDataSet(ds, "CardType", "CardTypeID", ddlCardType);
        ddlCardType.SelectedIndex = 0;
        ddlCardType.Enabled = true;
    }

    private void FillAgency()
    {
        var districtId = -1;
        if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        var ds = _objFuelMan.IFillAgency(districtId);
        _helper.FillDropDownHelperMethodWithDataSet(ds, "AgencyName", "AgencyID", ddlAgency);
        ddlAgency.SelectedIndex = 0;
        ddlAgency.Enabled = true;
    }

    protected void ddlAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCardType.Enabled = true;
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        switch (btSave.Text)
        {
            case "Save":
                InsPetroCardIssueDetails(Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt64(txtPetroCardNumber.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToInt32(ddlCardType.SelectedValue), Convert.ToDateTime(txtValidityEndDate.Text), Convert.ToInt32(dd_listFe.SelectedValue), Convert.ToDateTime(txtIssuedDate.Text), 0, 25, Convert.ToDateTime("05/24/2011"), 34, Convert.ToDateTime("05/25/2011"), Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(ddlFeuserDistrict.SelectedValue));
                FillGridPetroCard();
                break;
            default:
                UpdPetroCardIssueDetails(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt64(txtPetroCardNumber.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToInt32(ddlCardType.SelectedValue), Convert.ToDateTime(txtValidityEndDate.Text), Convert.ToInt32(dd_listFe.SelectedValue), Convert.ToDateTime(txtIssuedDate.Text), Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(ddlFeuserDistrict.SelectedValue));
                FillGridPetroCard();
                break;
        }
    }

    private void InsPetroCardIssueDetails(int districtId, long petroCardNum, int agencyId, int cardTypeId, DateTime validityEndDate, int issuedToFe, DateTime petroCardIssuedDate, int status, int createdBy, DateTime createdDate, int updatedBy, DateTime updatedDate, int vehicleId, int userDistrictId)
    {
        var res = _objFuelMan.IInsPetroCardIssueDetails(districtId, petroCardNum, agencyId, cardTypeId, validityEndDate, issuedToFe, petroCardIssuedDate, status, createdBy, createdDate, updatedBy, updatedDate, vehicleId, userDistrictId);
        switch (res)
        {
            case 1:
            {
                var strFmsScript = "Petro Card ISSUED";
                Show(strFmsScript);
                break;
            }
            default:
            {
                var strFmsScript = "Petro Card Already Issued to a District";
                Show(strFmsScript);
                break;
            }
        }

        FillGridPetroCard();
        Clearfields();
    }

    private void UpdPetroCardIssueDetails(int petroCardIssueId, int districtId, long petroCardNum, int agencyId, int cardTypeId, DateTime validityEndDate, int issuedToFe, DateTime petroCardIssuedDate, int vehicleId, int userDistrictId)
    {
        var res = _objFuelMan.IUpdPetroCardIssueDetails(petroCardIssueId, districtId, petroCardNum, agencyId, cardTypeId, validityEndDate, issuedToFe, petroCardIssuedDate, vehicleId, userDistrictId);
        switch (res)
        {
            case 1:
            {
                var strFmsScript = "Petro Card UPDATED";
                Show(strFmsScript);
                break;
            }
            default:
            {
                var strFmsScript = "Failure";
                Show(strFmsScript);
                break;
            }
        }

        FillGridPetroCard();
        Clearfields();
    }

    private void FillGridPetroCard()
    {
        var districtId = -1;
        if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        var ds = _objFuelMan.IFillGridPetroCard(districtId);
        gvPetroCardIssue.DataSource = ds;
        gvPetroCardIssue.DataBind();
        foreach (GridViewRow item in gvPetroCardIssue.Rows)
            if (item.Cells[2].Text != "&nbsp;")
            {
                ((LinkButton) item.FindControl("lnkEdit")).Enabled = false;
                ((LinkButton) item.FindControl("lnDeactivate")).Enabled = false;
            }
    }

    protected void gvPetroCardIssue_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPetroCardIssue.PageIndex = e.NewPageIndex;
        var districtId = -1;
        if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        var ds = _objFuelMan.IFillGridPetroCard(districtId);
        gvPetroCardIssue.DataSource = ds;
        gvPetroCardIssue.DataBind();
        foreach (GridViewRow item in gvPetroCardIssue.Rows)
            if (item.Cells[2].Text != null)
            {
                ((LinkButton) item.FindControl("lnkEdit")).Enabled = false;
                ((LinkButton) item.FindControl("lnDeactivate")).Enabled = false;
            }

        FillGridPetroCard();
    }

    protected void gvPetroCardIssue_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }

    protected void btReset_Click(object sender, EventArgs e)
    {
        Clearfields();
    }

    private void Clearfields()
    {
        txtPetroCardNumber.Text = "";
        ddlAgency.SelectedIndex = 0;
        ddlCardType.SelectedIndex = 0;
        txtValidityEndDate.Text = "";
        dd_listFe.SelectedIndex = 0;
        txtIssuedDate.Text = "";
        btSave.Text = "Save";
        ddlVehicles.SelectedIndex = 0;
        ddlFeuserDistrict.SelectedIndex = 0;
        ddlVehicles.Enabled = false;
    }

    protected void gvPetroCardIssue_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    protected void gvPetroCardIssue_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Edit":
            {
                FillDistricts();
                btSave.Text = "Update";
                var id = Convert.ToInt32(e.CommandArgument.ToString());
                var ds = _objFuelMan.IEditPetroCardDetails(id);
                txtEdit.Text = Convert.ToString(id);
                txtPetroCardNumber.Text = ds.Tables[0].Rows[0]["PetroCardNum"].ToString();
                FillAgency();
                ddlAgency.SelectedValue = ds.Tables[0].Rows[0]["AgencyID"].ToString();
                ddlCardType.SelectedValue = ds.Tables[0].Rows[0]["CardTypeID"].ToString();
                txtValidityEndDate.Text = ds.Tables[0].Rows[0]["ValidEndDate"].ToString();
                dd_listFe.SelectedValue = ds.Tables[0].Rows[0]["IssuedToFE"].ToString();
                txtIssuedDate.Text = ds.Tables[0].Rows[0]["PetroCardIssDate"].ToString();
                FillVehicles();
                FillDistricts();
                ddlVehicles.SelectedValue = ds.Tables[0].Rows[0]["IssuedToVehicle"].ToString();
                ddlFeuserDistrict.SelectedValue = ds.Tables[0].Rows[0]["IssuedToDistrict"].ToString();
                break;
            }
            case "Delete":
            {
                var id = Convert.ToInt32(e.CommandArgument.ToString());
                var result = _objFuelMan.IDeletePetroCardDetails(id);
                switch (result)
                {
                    case 1:
                    {
                        var strFmsScript = "Petro Card Deactivated";
                        Show(strFmsScript);
                        break;
                    }
                    default:
                    {
                        var strFmsScript = "Failure";
                        Show(strFmsScript);
                        break;
                    }
                }

                FillGridPetroCard();
                Clearfields();
                break;
            }
        }
    }

    protected void dd_listFe_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillUserDistrictandVehicle();
    }

    private void FillUserDistrictandVehicle()
    {
        var ds = _objFuelMan.IGetDistrictforUser(Convert.ToInt32(dd_listFe.SelectedValue));
        switch (ds.Tables[0].Rows.Count)
        {
            case 0:
                Show("Please map the Fe to some District and then issue Petro Cards");
                break;
            default:
                _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlFeuserDistrict);
                ddlFeuserDistrict.SelectedIndex = 0;
                break;
        }

        var ds1 = _objFuelMan.IGetVehiclesforUser(Convert.ToInt32(dd_listFe.SelectedValue));
        _helper.FillDropDownHelperMethodWithDataSet(ds1, "VehicleNumber", "VehicleID", null, ddlVehicles);
        ddlVehicles.SelectedIndex = 0;
        ddlVehicles.Enabled = true;
    }

    private void FillVehicles()
    {
        var districtId = -1;
        if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        _fmsg.UserDistrictId = districtId;
        var ds = _fmsg.GetVehicleNumberPetroCardEdit();
        _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", null, ddlVehicles);
        ddlVehicles.SelectedIndex = 0;
        ddlVehicles.Enabled = false;
    }
}