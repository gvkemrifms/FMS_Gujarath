using System;
using System.Web.UI;
using GvkFMSAPP.BLL;

public partial class HrDisciplinaryActions : Page
{
    private readonly VAS _obj = new VAS();
    readonly Helper _helper = new Helper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Error.aspx");

        if (!IsPostBack)
        {
            BindData();
            GetVehicleNumbers();
            ddlCause.Enabled = true;
        }
    }

    private void GetVehicleNumbers()
    {
        var ds = _obj.GetHRDiscVeh();
        if (ds != null) _helper.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", ddlVehicleno);
    }

    private void BindData()
    {
        var ds = _obj.GetHRDiscDropDown();
        if (ds != null && ds.Tables.Count > 0)
        {
            _helper.FillDifferentDataTables(ddlFatalAcc, ds.Tables[0], "FA_Details", "FA_ID");
            _helper.FillDifferentDataTables(ddlMajor, ds.Tables[1], "MajA_Details", "MajA_ID");
            _helper.FillDifferentDataTables(ddlFatalAcc, ds.Tables[2], "MajlossA_Details", "MajlossA_ID");
            _helper.FillDifferentDataTables(ddlFatalAcc, ds.Tables[3], "MA_Details", "MA_ID");
            _helper.FillDifferentDataTables(ddlFatalAcc, ds.Tables[4], "SevInj_Details", "SevInj_ID");
            _helper.FillDifferentDataTables(ddlFatalAcc, ds.Tables[5], "SituationOfAccident", "AccidentId");
        }
    }

    protected void ddlSitIfAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlSitIfAction.SelectedIndex)
        {
            case 0:
                ddlCause.Items.Clear();
                ddlCause.Enabled = false;
                break;
            default:
                ddlCause.Enabled = true;
                var x = ddlSitIfAction.SelectedIndex;
                var ds = _obj.GetCausesforAcc(x);
                _helper.FillDropDownHelperMethodWithDataSet(ds, "CauseOfAccident", "CauseId", ddlCause);
                break;
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlSitIfAction.SelectedIndex = 0;
        ddlSevereInj.SelectedIndex = 0;
        ddlMajorOrtotLoss.SelectedIndex = 0;
        ddlFatalAcc.SelectedIndex = 0;
        ddlMinorAcc.SelectedIndex = 0;
        ddlMajor.SelectedIndex = 0;
        ddlCause.SelectedIndex = 0;
        ddlVehicleno.SelectedIndex = 0;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlVehicleno != null) _obj.VehicleNumber = Convert.ToString(ddlVehicleno.SelectedItem.Text);
        if (ddlSitIfAction != null) _obj.sitOfAcc = ddlSitIfAction.SelectedItem.ToString();
        if (ddlCause != null) _obj.CauseAcc = ddlCause.SelectedItem.ToString();
        if (ddlMinorAcc != null) _obj.minAcc = ddlMinorAcc.SelectedItem.ToString();
        if (ddlMajor != null) _obj.majACC = ddlMajor.SelectedItem.ToString();
        if (ddlMajorOrtotLoss != null) _obj.majLoss = ddlMajorOrtotLoss.SelectedIndex.ToString();
        if (ddlSevereInj != null) _obj.sevInj = ddlSevereInj.SelectedItem.ToString();
        if (ddlFatalAcc != null) _obj.fatalAcc = ddlFatalAcc.SelectedItem.ToString();
        var i = _obj.InsertHRDisciplinaryActions();
        switch (i)
        {
            case 0:
                Show("Insertion Failed");
                break;
            default:
                Show("Disciplinary Action Successfully inserted");
                btnClear_Click(this, null);
                break;
        }
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }
}