using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ServiceStation : Page
{
    DataSet _ds = new DataSet();
    readonly GvkFMSAPP.BLL.BaseVehicleDetails _fmsobj = new GvkFMSAPP.BLL.BaseVehicleDetails();
    readonly GvkFMSAPP.BLL.FMSGeneral _fmsg = new GvkFMSAPP.BLL.FMSGeneral();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
        {
            Response.Redirect("Error.aspx");
        }
        if (!IsPostBack)
        {
            if (Session["UserdistrictId"] != null)
            {
                _fmsg.UserDistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }

            Bindgrid();
            FillVehicles();
            BindData();
            btnUpdate.Visible = false;
            txtServiceSrationName.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
        }
    }

    private void FillVehicles()
    {
        if (Session["UserdistrictId"] != null)
        {
        }
        _ds = null;
        _ds = _fmsg.GetVehicleNumber();
        AccidentReport.FillDropDownHelperMethodWithDataSet(_ds, "VehicleNumber", "VehicleID", null, ddlVehicleNumber);
        ViewState["dsVehicles"] = _ds;

    }
    public void BindData()
    {
        //DataSet dsDistricts = new DataSet();
        _ds = null;
        _ds = _fmsobj.GetDistricts_new();
        AccidentReport.FillDropDownHelperMethodWithDataSet(_ds, "district_name", "district_id", ddlDistricts);
        ViewState["dsDistricts"] = _ds;
    }

    public void Bindgrid()
    {
        DataSet ds = _fmsobj.GetGridServiceNames();
        if (ds != null)
        {
            gvServiceStationDetails.DataSource = ds.Tables[0];
            gvServiceStationDetails.DataBind();
        }

        ViewState["dsGrid"] = ds;
        //Session["griddataset"] = ds.Tables[0];
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        _fmsobj.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);
        _fmsobj.ServiceName = txtServiceSrationName.Text;
        _fmsobj.DistrictId = Convert.ToInt16(ddlDistricts.SelectedValue);


        // DataSet ds1 = fmsobj.CheckServiceName();

        int output = _fmsobj.InsertServiceName();
        if (output <= 0)
        {
            Show("Not Inserted");
        }
        else
        {
            Show("Inserted Succesfully");
            ClearAll();
            Bindgrid();
        }

    }

    private void ClearAll()
    {
        txtServiceSrationName.Text = "";
        ddlDistricts.SelectedIndex = 0;
        ddlVehicleNumber.SelectedIndex = 0;
    }
    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }



    protected void gvServiceStationDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "MainEdit":
                {
                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                    //int index = Convert.ToInt32(e.CommandArgument.ToString());
                    GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                    int index = gvr.RowIndex;
                    txtServiceSrationName.Text = ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblServiceStation")))).Text;
                    DataSet dsDist = (DataSet)ViewState["dsDistricts"];
                    DataView dvDistrict = dsDist.Tables[0].DefaultView;
                    dvDistrict.RowFilter = "ds_lname='" + ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblDistricts")))).Text + "'";
                    ddlDistricts.SelectedValue = Convert.ToString(dvDistrict.ToTable().Rows[0]["ds_dsid"]);
                    DataSet dsVeh = (DataSet)ViewState["dsVehicles"];
                    DataView dvVehicles = dsVeh.Tables[0].DefaultView;
                    dvVehicles.RowFilter = "VehicleNumber='" + ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblVehNum")))).Text + "'";
                    ddlVehicleNumber.SelectedValue = Convert.ToString(dvVehicles.ToTable().Rows[0]["VehicleID"]);
                    DataSet ds1 = (DataSet)ViewState["dsGrid"];
                    DataView dv = new DataView(ds1.Tables[0])
                    {
                        RowFilter = "ServiceStation_Name='" + txtServiceSrationName.Text + "' and ds_lname='" +
                                    ddlDistricts.SelectedItem.Text + "' and VehicleNumber='" +
                                    ddlVehicleNumber.SelectedItem.Text + "'"
                    };
                    DataTable dt = dv.ToTable();
                    Session["Id"] = Convert.ToString(dt.Rows[0]["Id"]);
                    break;
                }
            case "MainDelete":
                {

                    DataSet ds2 = (DataSet)ViewState["dsGrid"];
                    DataView dv = new DataView(ds2.Tables[0]);
                    GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                    int index = gvr.RowIndex;
                    txtServiceSrationName.Text = ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblServiceStation")))).Text;
                    DataSet dsDist = (DataSet)ViewState["dsDistricts"];
                    DataView dvDistrict = dsDist.Tables[0].DefaultView;
                    dvDistrict.RowFilter = "ds_lname='" + ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblDistricts")))).Text + "'";
                    ddlDistricts.SelectedValue = Convert.ToString(dvDistrict.ToTable().Rows[0]["ds_dsid"]);
                    DataSet dsVeh = (DataSet)ViewState["dsVehicles"];
                    DataView dvVehicles = dsVeh.Tables[0].DefaultView;
                    dvVehicles.RowFilter = "VehicleNumber='" + ((Label)((gvServiceStationDetails.Rows[index].FindControl("lblVehNum")))).Text + "'";
                    ddlVehicleNumber.SelectedValue = Convert.ToString(dvVehicles.ToTable().Rows[0]["VehicleID"]);
                    dv.RowFilter = "ServiceStation_Name='" + txtServiceSrationName.Text + "' and ds_lname='" + ddlDistricts.SelectedItem.Text + "' and VehicleNumber='" + ddlVehicleNumber.SelectedItem.Text + "'";
                    DataTable dt = dv.ToTable();
                    Session["Id"] = Convert.ToString(dt.Rows[0]["Id"]);
                    _fmsobj.GridId = Convert.ToInt16(Session["Id"]);
                    int delres = _fmsobj.DeleteServiceName();
                    Show(delres != 0 ? "Record Deleted Successfully!!" : "Error!!");
                    ClearAll();
                    Bindgrid();

                    break;
                }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        var id = Session["Id"] == null ? 0 : Convert.ToInt16(Session["Id"]);
        _fmsobj.ServiceName = txtServiceSrationName.Text;
        _fmsobj.DistrictId = Convert.ToInt16(ddlDistricts.SelectedValue);
        _fmsobj.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);

        _fmsobj.GridId = id;
        DataSet ds1 = _fmsobj.CheckServiceName();
        bool isExists = false;
        if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0 &&
            (Convert.ToString(ds1.Tables[0].Rows[0]["Vehicle_ID"]) == ddlVehicleNumber.SelectedValue))
        {
            Show("Service Station already exists for Selected Vehicle");
            isExists = true;
            // ClearAll();
        }

        if (isExists) return;
        int output = _fmsobj.UpdServiceName();
        if (output <= 0)
        {
            Show("Not Inserted");
        }
        else
        {
            Show("Updated Succesfully");
            ClearAll();
            Bindgrid();
            btnUpdate.Visible = false;
            btnSave.Visible = true;
        }
    }

    protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDistrict();
        FillBunks();
    }

    private void FillDistrict()
    {
        _fmsg.vehicle = ddlVehicleNumber.SelectedItem.ToString();
        DataSet dsDistrict = _fmsg.GetDistrictLoc();
        BindData();
        if (dsDistrict.Tables[0].Rows.Count <= 0)
            ddlDistricts.Enabled = true;
        else
            ddlDistricts.Items.FindByText(dsDistrict.Tables[0].Rows[0]["District"].ToString()).Selected = true;
    }

    private void FillBunks()
    {
        _fmsg.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);
        DataSet dsServiceNames = _fmsg.GetBunkNames();
        txtServiceSrationName.Text = dsServiceNames.Tables[0].Rows.Count > 0 ? dsServiceNames.Tables[0].Rows[0]["ServiceStnName"].ToString() : "";
    }

    protected void gvServiceStationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvServiceStationDetails.PageIndex = e.NewPageIndex;
        Bindgrid();

    }
}