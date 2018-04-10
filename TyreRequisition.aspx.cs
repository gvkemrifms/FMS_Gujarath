using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;
using GvkFMSAPP.PL;

public partial class TyreRequisition : System.Web.UI.Page
{
    public IInventory ObjInventory = new FMSInventory();
    readonly GvkFMSAPP.BLL.FMSGeneral _fmsg = new GvkFMSAPP.BLL.FMSGeneral();
    private readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
            Response.Redirect("Error.aspx");
        if (!IsPostBack)
        {
            FillVehicles();
            btSave.Attributes.Add("OnClick", "return validationInventoryBatteryVehicleType()");
            RequisitionHistory.Visible = false;
            DataSet dsPerms = (DataSet)Session["PermissionsDS"];
            dsPerms.Tables[0].DefaultView.RowFilter = "Url='" + Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1] + "'";
            PagePermissions p = new PagePermissions(dsPerms, dsPerms.Tables[0].DefaultView[0]["Url"].ToString(), dsPerms.Tables[0].DefaultView[0]["Title"].ToString());
            gvTyrePendingForApproval.Columns[3].Visible = false;
            pnlNewTyreRequisition.Visible = false;
            gvTyrePendingForApproval.Visible = false;
            if (p.View )
            {
                gvTyrePendingForApproval.Visible = true;
                gvTyrePendingForApproval.Columns[5].Visible = false;
            }
            if (p.Add )
            {
                pnlNewTyreRequisition.Visible = true;
                gvTyrePendingForApproval.Visible = true;
                gvTyrePendingForApproval.Columns[5].Visible = false;
            }       
            if (p.Approve)
            {
                gvTyrePendingForApproval.Visible = true;
                gvTyrePendingForApproval.Columns[5].Visible = true;
            }

        }

    }

    private void FillVehicles()
    {
       
        _fmsg.UserDistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        DataSet ds = _fmsg.GetVehicleNumber();
        if (ds != null)
            _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", null, ddlVehicles);
    }

    protected void ddlVehicles_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlVehicles.SelectedIndex)
        {
            case 0:
                gvTyreRequisition.Visible = false;
                gvTyrePendingForApproval.Visible = false;
                break;
            default:
                FillGridTyreRequisition(Convert.ToInt32(ddlVehicles.SelectedValue));
                FillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
                FillGrid_RequisitionHistory(Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(Session["UserdistrictId"].ToString()), 1);
                break;
        }
    }

    private void FillGridTyreRequisition(int vehicleId)
    {
        var ds = ObjInventory.FillGridTyreRequisition(vehicleId);
        gvTyreRequisition.DataSource = ds;
        gvTyreRequisition.DataBind();
        gvTyreRequisition.Visible = true;
    }

    protected void gvTyreRequisition_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTyreRequisition.PageIndex = e.NewPageIndex;
        FillGridTyreRequisition(Convert.ToInt32(ddlVehicles.SelectedValue));
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        int chk = 0;
        DataTable dtAddRequisition = new DataTable();
        dtAddRequisition.Columns.Add("VehicleID", typeof(Int32));
        dtAddRequisition.Columns.Add("VehicleNum", typeof(String));
        dtAddRequisition.Columns.Add("DistrictID", typeof(Int32));
        dtAddRequisition.Columns.Add("FleetInventoryCategory", typeof(Int32));
        dtAddRequisition.Columns.Add("TyrePosition", typeof(String));
        dtAddRequisition.Columns.Add("TyreNumber", typeof(String));
        dtAddRequisition.Columns.Add("RequestedQty", typeof(Int32));
        dtAddRequisition.Columns.Add("Remarks", typeof(String));
        dtAddRequisition.Columns.Add("RequestedBy", typeof(Int32));

        foreach (GridViewRow row in gvTyreRequisition.Rows)
        {
            if (((CheckBox)row.FindControl("chk")).Checked)
            {
                TextBox txt = (TextBox)row.FindControl("txtRemarks");

                switch (txt.Text)
                {
                    case "":
                        chk++;
                        break;
                }
                var dr = dtAddRequisition.NewRow();
                dr["VehicleID"] = Convert.ToInt16(ddlVehicles.SelectedValue);
                dr["VehicleNum"] = Convert.ToString(ddlVehicles.SelectedItem);
                dr["DistrictID"] = Convert.ToInt32(Session["UserdistrictId"].ToString());
                dr["FleetInventoryCategory"] = 1;
                dr["TyrePosition"] = row.Cells[1].Text;
                dr["TyreNumber"] = row.Cells[2].Text;
                dr["RequestedQty"] = 1;
                dr["Remarks"] = ((TextBox)row.FindControl("txtRemarks")).Text;
                dr["RequestedBy"] = Convert.ToInt32(Session["User_Id"].ToString());
                dtAddRequisition.Rows.Add(dr);
            }
        }
        if (chk > 0)
        {
            Show("Please Fill The Remarks");
        }
        else
        {

            switch (dtAddRequisition.Rows.Count)
            {
                case 0:
                    string strFmsScript = "Please Check And Submit";
                    Show(strFmsScript);
                    break;
                default:
                    bool updResult = ObjInventory.InsertingTyreRequisitionRow(dtAddRequisition);
                    Show(updResult ? "Tyre Details Submitted" : "Failure");
                    break;
            }

            FillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
            FillGridTyreRequisition(Convert.ToInt32(ddlVehicles.SelectedValue));
        }
    }

    private void FillGridTyrePendingForApproval(int fleetInventoryId, int vehicleId)
    {
        var ds = ObjInventory.GetFillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
        gvTyrePendingForApproval.DataSource = ds.Tables[0];
        gvTyrePendingForApproval.DataBind();
        gvTyrePendingForApproval.Visible = true;
    }

    protected void gvTyrePendingForApproval_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTyrePendingForApproval.PageIndex = e.NewPageIndex;
        FillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
    }

    protected void BtnViewDetails_Click(object sender, EventArgs e)
    {
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(txtInvReqID.Text);
        var res = ObjInventory.ApproveRejectTyreRequisition(id, 2);
        if (res > 0)
        {
            string strFmsScript = "<script language=JavaScript>alert('" + "Tyre Request Approved" + "')</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Success", strFmsScript);
        }
        else
        {
            string strFmsScript = "<script language=JavaScript>alert('" + "Failure " + "')</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "failure", strFmsScript);
        }
        FillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
        FillGridTyreRequisition(Convert.ToInt32(ddlVehicles.SelectedValue));
        Show("New Tyre Request Approved");
    }

    protected void btnNo_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(txtInvReqID.Text);
        var res = ObjInventory.ApproveRejectTyreRequisition(id, 3);
        if (res > 0)
        {
            string strFmsScript = "<script language=JavaScript>alert('" + "Spare Parts Request Rejected" + "')</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Success", strFmsScript);
        }
        else
        {
            string strFmsScript = "<script language=JavaScript>alert('" + "Failure " + "')</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "failure", strFmsScript);
        }
        FillGridTyrePendingForApproval(1, Convert.ToInt32(ddlVehicles.SelectedValue));
        FillGridTyreRequisition(Convert.ToInt32(ddlVehicles.SelectedValue));
        Show("New Tyre Request Rejected");

    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {
        ddlVehicles.SelectedValue = "0";
        gvTyreRequisition.Visible = false;
        gvTyrePendingForApproval.Visible = false;
        RequisitionHistory.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        gv_ModalPopupExtender1.Hide();
    }

    public void FillGrid_RequisitionHistory(int vehicleId, int @districtId, int fleetInventoryItemId)
    {
        var ds = ObjInventory.IFillFleetInventoryRequisitionHistory(vehicleId, districtId, 1);
        grvRequisitionHistory.DataSource = ds.Tables[0];
        grvRequisitionHistory.DataBind();
    }


    protected void btnTyreReqHistory_Click(object sender, EventArgs e)
    {
        RequisitionHistory.Visible = true;
        FillGrid_RequisitionHistory(Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(Session["UserdistrictId"].ToString()), 1);
        hideHistory.Visible = true;

    }

    protected void grvRequisitionHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvRequisitionHistory.PageIndex = e.NewPageIndex;
        FillGrid_RequisitionHistory(Convert.ToInt32(ddlVehicles.SelectedValue), Convert.ToInt32(Session["UserdistrictId"].ToString()), 1);

    }

    protected void gvTyrePendingForApproval_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument.ToString());
        var ds = ObjInventory.GetTyreRequisitionForApproval(id);
        txtInvReqID.Text = e.CommandArgument.ToString();
        txtVehicleNo.Text = ds.Tables[0].Rows[0]["VehicleNum"].ToString();
        gvTyreRequisitionDetails.DataSource = ds.Tables[1];
        gvTyreRequisitionDetails.DataBind();
        gv_ModalPopupExtender1.Show();
    }

    protected void hideHistory_Click(object sender, EventArgs e)
    {
        hideHistory.Visible = false;
        RequisitionHistory.Visible = false;
    }

}

