﻿using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleInsuranceClaims : Page
{
    private readonly GvkFMSAPP.BLL.StatutoryCompliance.InsuranceClaims.VehicleInsuranceClaims _insClaims = new GvkFMSAPP.BLL.StatutoryCompliance.InsuranceClaims.VehicleInsuranceClaims();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Error.aspx");
        if (!IsPostBack)
        {
            GetInsuranceClaims();
            pnlVehicleInsuranceClaims.Visible = false;
        }
    }

    public void GetInsuranceClaims()
    {
        gvInsuranceClaim.DataSource = _insClaims.GetInsuranceClaims();
        gvInsuranceClaim.DataBind();
    }

    protected void gvInsuranceClaim_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "EditInsurance":
                var gvr = (GridViewRow) ((LinkButton) e.CommandSource).NamingContainer;
                var vehicleStatus = (Label) gvr.FindControl("lblStatus");
                var dsinsurancedit = _insClaims.GetInsuranceClaims();
                var drinsurance = dsinsurancedit.Tables[0].Select("VehicleID=" + e.CommandArgument);
                Session["VehicleID"] = Convert.ToInt32(drinsurance[0][0].ToString());
                Session["VehicleNumber"] = drinsurance[0][1].ToString();
                Session["VehicleStatus"] = vehicleStatus.Text;
                Response.Redirect("~/InsuranceClaimsPaymentStatus.aspx", false);
                break;
        }
    }
}