﻿using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;
using GvkFMSAPP.BLL.VAS_BLL;

public partial class KmplMaster : Page
{
    readonly Helper _helper = new Helper();
    private DataSet _dataset = new DataSet();
    private readonly BaseVehicleDetails _fmsobj = new BaseVehicleDetails();
    private VASGeneral _obj = new VASGeneral();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Error.aspx");
        if (!IsPostBack)
        {
            BindData();
            Bindgrid();
            txtKMPL.Attributes.Add("onkeypress", "javascript:return numeric(this,event)");
        }
    }

    private void BindData()
    {
        _dataset = null;
        _dataset = _fmsobj.GetVehicleNumber();
        _helper.FillDropDownHelperMethodWithDataSet(_dataset, "VehicleNumber", "VehicleID", null, ddlVehNumber);
        ViewState["dsVehicles"] = _dataset;
    }

    private void Bindgrid()
    {
        var ds = _fmsobj.GetGridVehKMPL();
        gvVehKmplDetails.DataSource = ds.Tables[0];
        gvVehKmplDetails.DataBind();
        ViewState["dsGrid"] = ds;
    }

    protected void ddlVehNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlVehNumber.SelectedIndex == 0) return;
        _fmsobj.VehicleID = Convert.ToInt16(ddlVehNumber.SelectedValue);
        var text = _fmsobj.GetKMPL();
        txtKMPL.Text = text;
    }

    protected void gvVehKmplDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "MainEdit":
                var gvr = (GridViewRow) ((LinkButton) e.CommandSource).NamingContainer;
                var index = gvr.RowIndex;
                ClearAll();
                btnUpdate.Visible = true;
                txtKMPL.Text = ((Label) gvVehKmplDetails.Rows[index].FindControl("lblKMPL")).Text;
                var dsVeh = (DataSet) ViewState["dsVehicles"];
                var dvVeh = dsVeh.Tables[0].DefaultView;
                dvVeh.RowFilter = "VehicleNumber='" + ((Label) gvVehKmplDetails.Rows[index].FindControl("lblVehNumber")).Text + "'";
                ddlVehNumber.SelectedValue = Convert.ToString(dvVeh.ToTable().Rows[0]["VehicleID"]);
                var ds = (DataSet) ViewState["dsGrid"];
                var dv = new DataView(ds.Tables[0]);
                dv.RowFilter = "KMPL='" + txtKMPL.Text + "' and VehicleNumber='" + ddlVehNumber.SelectedItem.Text + "'";
                var dt = dv.ToTable();
                Session["Id"] = Convert.ToString(dt.Rows[0]["VehicleID"]);
                break;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        var id = Session["Id"] != null ? Convert.ToInt16(Session["Id"]) : 0;
        _fmsobj.VehKMPL = Convert.ToDecimal(txtKMPL.Text);
        _fmsobj.VehicleID = Convert.ToInt16(ddlVehNumber.SelectedValue);
        _fmsobj.GridId = id;
        if (true)
        {
            var output = _fmsobj.UpdVehKMPL();
            if (output <= 0)
            {
                Show("Not Updated");
            }
            else
            {
                Show("Updated Succesfully");
                ClearAll();
                Bindgrid();
            }
        }
    }

    private void ClearAll()
    {
        txtKMPL.Text = "";
        ddlVehNumber.SelectedIndex = 0;
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    protected void gvVehKmplDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvVehKmplDetails.PageIndex = e.NewPageIndex;
        Bindgrid();
    }
}