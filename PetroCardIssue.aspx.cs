﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;
using GvkFMSAPP.DLL;
using ServiceReference2;
using FMSGeneral = GvkFMSAPP.BLL.FMSGeneral;
using System.Globalization;

public partial class PetroCardIssue : Page
{
    private readonly FMSGeneral _fmsg = new FMSGeneral();
    private readonly Helper _helper = new Helper();
    private readonly IFuelManagement _objFuelMan = new FuelManagement();

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
            if (dsPerms == null) throw new ArgumentNullException(nameof(dsPerms));
            dsPerms.Tables[0].DefaultView.RowFilter = "Url='" + Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1] + "'";
        }
    }

    protected void FillFeUsers()
    {
        try
        {
            var client = new ACLServiceClient();
            var ds = client.GetRoleBasedUsersList(int.Parse(ConfigurationManager.AppSettings["roleID"]));
            _helper.FillDropDownHelperMethodWithDataSet(ds, "LOGIN_NAME", "PK_USER_ID", dd_listFe);
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    private void FillDistricts()
    {
        try
        {
            var ds = _objFuelMan.IFillDistricts();
            _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlFeuserDistrict);
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    protected void ddlDistricts_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    private void FillCardType()
    {
        try
        {
            var ds = _objFuelMan.IFillCardType();
            _helper.FillDropDownHelperMethodWithDataSet(ds, "CardType", "CardTypeID", ddlCardType);
            ddlCardType.Enabled = true;
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    private void FillAgency()
    {
        try
        {
            var districtId = -1;
            if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
            var ds = _objFuelMan.IFillAgency(districtId);
            if (ds == null) throw new ArgumentNullException(nameof(ds));
            _helper.FillDropDownHelperMethodWithDataSet(ds, "AgencyName", "AgencyID", ddlAgency);
            ddlAgency.Enabled = true;
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
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
                InsPetroCardIssueDetails(Convert.ToInt32(Session["UserdistrictId"].ToString()), txtPetroCardNumber.Text, Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToInt32(ddlCardType.SelectedValue), DateTime.ParseExact(txtValidityEndDate.Text,"MM/dd/yyyy",CultureInfo.InvariantCulture), Convert.ToInt32(dd_listFe.SelectedValue), DateTime.ParseExact(txtIssuedDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture), 0, 25, Convert.ToDateTime("05/24/2011"), 34, Convert.ToDateTime("05/25/2011"), Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(ddlFeuserDistrict.SelectedValue));
                FillGridPetroCard();
                break;
            default:
                UpdPetroCardIssueDetails(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt64(txtPetroCardNumber.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToInt32(ddlCardType.SelectedValue), DateTime.ParseExact(txtValidityEndDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture), Convert.ToInt32(dd_listFe.SelectedValue), DateTime.ParseExact(txtIssuedDate.Text,"MM/dd/yyyy",CultureInfo.InvariantCulture), Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(ddlFeuserDistrict.SelectedValue));
                FillGridPetroCard();
                break;
        }
    }

    private void InsPetroCardIssueDetails(int districtId, string petroCardNum, int agencyId, int cardTypeId, DateTime validityEndDate, int issuedToFe, DateTime petroCardIssuedDate, int status, int createdBy, DateTime createdDate, int updatedBy, DateTime updatedDate, int vehicleId, int userDistrictId)
    {
        var res = InsertPetroCardIssueDetails(districtId, petroCardNum, agencyId, cardTypeId, validityEndDate, issuedToFe, petroCardIssuedDate, status, createdBy, createdDate, updatedBy, updatedDate, vehicleId, userDistrictId);
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
        if (ds == null) throw new ArgumentNullException(nameof(ds));
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
        if (ds == null) throw new ArgumentNullException(nameof(ds));
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
        ddlFeuserDistrict.Enabled = true;
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
        if (e.CommandName == null) return;
        switch (e.CommandName)
        {
            case "Edit":
            {
                FillDistricts();
                ddlFeuserDistrict.Enabled = false;
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
        try
        {
            var ds = _objFuelMan.IGetDistrictforUser(Convert.ToInt32(dd_listFe.SelectedValue));
            if (ds == null) throw new ArgumentNullException(nameof(ds));
            switch (ds.Tables[0].Rows.Count)
            {
                case 0:
                    Show("Please map the Fe to some District and then issue Petro Cards");
                    break;
                default:
                    _helper.FillDropDownHelperMethodWithDataSet(ds, "ds_lname", "ds_dsid", ddlFeuserDistrict);
                    ddlFeuserDistrict.SelectedIndex = 0;
                    ddlFeuserDistrict.Enabled = true;
                    break;
            }

            var ds1 = _objFuelMan.IGetVehiclesforUser(Convert.ToInt32(dd_listFe.SelectedValue));
            if (ds1 == null) throw new ArgumentNullException(nameof(ds1));
            _helper.FillDropDownHelperMethodWithDataSet(ds1, "VehicleNumber", "VehicleID", null, ddlVehicles);
            ddlVehicles.SelectedIndex = 0;
            ddlVehicles.Enabled = true;
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    private void FillVehicles()
    {
        try
        {
            var districtId = -1;
            if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
            _fmsg.UserDistrictId = districtId;
            var ds = _fmsg.GetVehicleNumberPetroCardEdit();
            if (ds == null) throw new ArgumentNullException(nameof(ds));
            _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", null, ddlVehicles);
            ddlVehicles.Enabled = false;
        }
        catch (Exception ex)
        {
            _helper.ErrorsEntry(ex);
        }
    }

    public int InsertPetroCardIssueDetails(int DistrictID, string PetroCardNum, int AgencyID, int CardTypeID, DateTime ValidityEndDate, int IssuedToFE, DateTime PetroCardIssuedDate, int Status, int CreatedBy, DateTime CreatedDate, int UpdatedBy, DateTime UpdatedDate, int VehicleID, int UserDistrictID)
    {
        var num = 0;
        try
        {
            var cmd = new SqlCommand();
            cmd.Parameters.Add("@DistrictID", SqlDbType.Int);
            cmd.Parameters["@DistrictID"].Value = DistrictID;
            cmd.Parameters.AddWithValue("@PetroCardNum", PetroCardNum);
            cmd.Parameters.Add("@AgencyID", SqlDbType.Int);
            cmd.Parameters["@AgencyID"].Value = AgencyID;
            cmd.Parameters.Add("@CardTypeID", SqlDbType.Int);
            cmd.Parameters["@CardTypeID"].Value = CardTypeID;
            cmd.Parameters.Add("@ValidityEndDate", SqlDbType.DateTime);
            cmd.Parameters["@ValidityEndDate"].Value = ValidityEndDate;
            cmd.Parameters.Add("@IssuedToFE", SqlDbType.Int);
            cmd.Parameters["@IssuedToFE"].Value = IssuedToFE;
            cmd.Parameters.Add("@PetroCardIssuedDate", SqlDbType.DateTime);
            cmd.Parameters["@PetroCardIssuedDate"].Value = PetroCardIssuedDate;
            cmd.Parameters.Add("@Status", SqlDbType.Bit);
            cmd.Parameters["@Status"].Value = 0;
            cmd.Parameters.Add("@CreatedBy", SqlDbType.Int);
            cmd.Parameters["@CreatedBy"].Value = CreatedBy;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime);
            cmd.Parameters["@CreatedDate"].Value = CreatedDate;
            cmd.Parameters.Add("@UpdatedBy", SqlDbType.Int);
            cmd.Parameters["@UpdatedBy"].Value = UpdatedBy;
            cmd.Parameters.Add("@UpdatedDate", SqlDbType.DateTime);
            cmd.Parameters["@UpdatedDate"].Value = UpdatedDate;
            cmd.Parameters.Add("@VehicleID", SqlDbType.Int);
            cmd.Parameters["@VehicleID"].Value = VehicleID;
            cmd.Parameters.Add("@UserDistrictID", SqlDbType.Int);
            cmd.Parameters["@UserDistrictID"].Value = UserDistrictID;
            num = SQLHelper.ExecuteNonQuery(cmd, CommandType.StoredProcedure, "[P_InsPetroCardIssueDetails]");
        }
        catch (Exception ex)
        {
            ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "class: FuelManagement ;Method: btSave_Click-InsPetroCardIssueDetails", 0L);
        }

        return num;
    }
}