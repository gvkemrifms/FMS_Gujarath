using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using GvkFMSAPP.BLL;
using GvkFMSAPP.PL;

public partial class FuelEntry : Page
{
    public IFuelManagement ObjFuelEntry = new FuelManagement();
    private double _kmplInt;
    private double _mSkmplInt;
    private bool _flag;
    private string _bunkname;
    private readonly FMSGeneral _fmsg = new FMSGeneral();

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["Role_Id"] != null)
            switch (Session["Role_Id"].ToString())
            {
                case "120":
                    MasterPageFile = "~/MasterERO.master";
                    break;
            }
        else
            Response.Redirect("Login.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null) Response.Redirect("Error.aspx");

        if (!IsPostBack)
        {
            if (Session["UserdistrictId"] != null) _fmsg.UserDistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());

            linkExisting.Visible = false;
            lnkNew.Visible = true;
            txtBunkName.Visible = true;
            txtBunkName.Enabled = false;
            ddlBunkName.Visible = false;
            FillVehicles();
            FillPayMode();

            //FillGridFuelEntry();
            txtAmount.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
            txtBillNumber.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
            txtLocation.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
            txtOdometer.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
            txtLocation.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
            txtPilotID.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
            txtPilotName.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
            var dsPerms = (DataSet) Session["PermissionsDS"];
            dsPerms.Tables[0].DefaultView.RowFilter = "Url='" + Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1] + "'";
            var p = new PagePermissions(dsPerms, dsPerms.Tables[0].DefaultView[0]["Url"].ToString(), dsPerms.Tables[0].DefaultView[0]["Title"].ToString());
            if (p.Add)
            {
            }

            if (p.Modify)
            {
            }

            if (p.View)
            {
            }

            if (p.Approve)
            {
            }
        }
    }

    private void FillDistricts()
    {
        var districtId = -1;
        if (Session["UserdistrictId"] != null) districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());

        var ds = ObjFuelEntry.IFillVehiclesWithMappedCards(districtId);
        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", ddlDistrict);
            ddlDistrict.Items[0].Value = "0";
            ddlDistrict.SelectedIndex = 0;
        }

        var itemToRemove = ddlDistrict.Items.FindByValue(ddlVehicleNumber.SelectedValue);
        if (itemToRemove != null) ddlDistrict.Items.Remove(itemToRemove);

        ddlDistrict.Enabled = true;
    }

    protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillCardNumber(Convert.ToInt32(ddlDistrict.SelectedValue));
        ddlPetroCardNumber.Enabled = false;
    }

    //Shiva...GetVehicleNumber() method
    private void FillVehicles()
    {
        if (Session["UserdistrictId"] != null)
        {
        }

        var ds = _fmsg.GetVehicleNumber();
        if (ds == null) return;
        AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", null, ddlVehicleNumber);
        ddlVehicleNumber.Items[0].Value = "0";
        ddlVehicleNumber.SelectedIndex = 0;
        ddlVehicleNumber.Enabled = true;
    }

    private void FillDistrictLocation()
    {
        _fmsg.vehicle = ddlVehicleNumber.SelectedItem.ToString();
        var dsDistrict = _fmsg.GetDistrictLoc();
        lblDistrict.Text = dsDistrict.Tables[0].Rows[0]["District"].ToString();
        lblLocation.Text = dsDistrict.Tables[0].Rows[0]["BaseLocation"].ToString();
    }

    private void FillServiceStn()
    {
        _fmsg.ServiceStn = lblDistrict.Text;
        var dsServiceStn = _fmsg.GetServiceStns();
        if (dsServiceStn == null) return;
        AccidentReport.FillDropDownHelperMethodWithDataSet(dsServiceStn, "ServiceStnName", "Id", ddlBunkName);
        ddlBunkName.Items[0].Value = "0";
        ddlBunkName.SelectedIndex = 0;
        ddlBunkName.Enabled = true;
    }

    private void FillServiceStnVeh()
    {
        _fmsg.ServiceStnVeh = Convert.ToInt32(ddlVehicleNumber.SelectedValue);
        var dsServiceStn = _fmsg.GetServiceStnsVeh();
        switch (dsServiceStn.Tables[0].Rows.Count)
        {
            case 0:
                txtBunkName.Enabled = true;
                break;
            default:
                txtBunkName.Text = Convert.ToString(dsServiceStn.Tables[0].Rows[0][1]);
                break;
        }
    }

    protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillCardNumber(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        FillGridFuelEntry(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        ViewState["VehicleID"] = ddlVehicleNumber.SelectedValue;
        ddlPetroCardNumber.Enabled = false;
        var dsOdo = ObjFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        switch (dsOdo.Tables[0].Rows.Count)
        {
            case 0:
                maxOdo.Value = "0";
                break;
            default:
                maxOdo.Value = dsOdo.Tables[0].Rows[0]["ODO"].ToString() != string.Empty ? dsOdo.Tables[0].Rows[0]["ODO"].ToString() : "0";
                break;
        }

        FillDistricts();
        FillDistrictLocation();
        FillServiceStnVeh();
    }

    private void FillPayMode()
    {
        var ds = ObjFuelEntry.IFillPayMode();
        if (ds == null) return;
        AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "PayMode", "PayModeID", ddlPaymode);
        ddlPaymode.Items[0].Value = "0";
        ddlPaymode.SelectedIndex = 0;
        ddlPaymode.Enabled = true;
    }

    protected void ddlPaymode_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlPaymode.SelectedValue)
        {
            case "1":
                ddlPetroCardNumber.Enabled = true;
                ddlCardSwiped.Enabled = true;
                break;
            default:
                ddlPetroCardNumber.Enabled = false;
                ddlAgency.Enabled = false;
                ddlCardSwiped.SelectedIndex = 1;
                ddlCardSwiped.Enabled = false;
                break;
        }
    }

    private void FillCardNumber(int vehicleId)
    {
        var ds = ObjFuelEntry.IFillCardNumber(vehicleId);
        switch (ds.Tables[0].Rows.Count)
        {
            case 0:
                var strFmsScript = "No cards mapped to this Vehicle";
                Show(strFmsScript);
                ddlPaymode.SelectedIndex = 2;
                ddlPaymode.Enabled = false;
                ddlCardSwiped.SelectedIndex = 1;
                ddlCardSwiped.Enabled = false;
                ddlPetroCardNumber.SelectedIndex = -1;
                break;
            default:
                AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "PetroCardNum", "PetroCardIssueID", ddlPetroCardNumber);
                if (ds.Tables[0].Rows.Count > 0)
                {
                }

                ddlPaymode.Enabled = true;
                break;
        }
    }

    protected void ddlPetroCardNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillFuelAgency(Convert.ToInt32(ddlPetroCardNumber.SelectedValue));
    }

    private void FillFuelAgency(int petroCardIssueId)
    {
        var ds = ObjFuelEntry.IFillFuelAgency(petroCardIssueId);
        AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "AgencyName", "AgencyID", ddlAgency);
        if (ds.Tables[0].Rows.Count > 0)
        {
        }

        ddlAgency.Enabled = true;
    }

    protected void Save_Click(object sender, EventArgs e)
    {
        var dsOdo = ObjFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        switch (dsOdo.Tables[0].Rows.Count)
        {
            case 0:
                maxOdo.Value = "0";
                break;
            default:
                if (dsOdo.Tables[0].Rows[0]["ODO"].ToString() == string.Empty)
                {
                    maxOdo.Value = "0";
                }
                else
                {
                    maxOdo.Value = dsOdo.Tables[0].Rows[0]["ODO"].ToString();
                    ViewState["maxodometer"] = dsOdo.Tables[0].Rows[0]["ODO"].ToString();
                }

                break;
        }

        // Show(txtFuelEntryDate.Text);
        var entrydate = DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
        if (entrydate > DateTime.Now)
        {
            Show("Fuel entry date should not be greater than current date ");
            return;
        }

        Save.Enabled = false;
        var fmsGeneral = new FMSGeneral();
        var ds = fmsGeneral.GetRegistrationDate(int.Parse(ddlVehicleNumber.SelectedItem.Value));
        Save.Enabled = true;
        switch (ds.Tables[0].Rows.Count)
        {
            case 0:
                Show("Fuel Entry cannot be done as vehicle is not yet Registered");
                break;
            default:
                if (txtOdometer.Text.Trim() == string.Empty)
                {
                    Show("Enter Odo value");
                    return;
                }
                else
                {
                    if (Convert.ToInt32(ViewState["maxodometer"].ToString()) != 0)
                    {
                        var maxno = Convert.ToInt32(ViewState["maxodometer"].ToString()) + 1000;
                        if (maxno <= Convert.ToInt32(txtOdometer.Text) || Convert.ToInt32(txtOdometer.Text) <= Convert.ToInt32(ViewState["maxodometer"].ToString()))
                        {
                            Show("Odo value between  " + ViewState["maxodometer"] + " And " + maxno);
                            txtOdometer.Text = "";
                            txtOdometer.Focus();
                            return;
                        }
                    }
                }

                // Show(ds.Tables[0].Rows[0]["RegDate"].ToString());
                var dtofRegistration = DateTime.ParseExact(ds.Tables[0].Rows[0]["RegDate"].ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture);
                var fuelEntry = DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                if (dtofRegistration > fuelEntry)
                {
                    Show("Fuel entry date should be greater than date of registration ");
                    return;
                }

                var dtpreviousentryDate = getpreviousODO(int.Parse(ddlVehicleNumber.SelectedItem.Value));
                if (dtpreviousentryDate.Rows.Count > 0 && dtpreviousentryDate.Rows[0]["maxentry"].ToString() != "")
                {
                    var dtprvrefill = Convert.ToDateTime(dtpreviousentryDate.Rows[0]["maxentry"].ToString());
                    if (dtprvrefill > DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture))
                    {
                        Show("Fuel entry date must be greater than previous fuel entry date");
                        return;
                    }
                }

                //Shiva end
                Save.Enabled = false;
                if (Save.Text == "Save" && ddlPetroCardNumber.Enabled)
                {
                    _bunkname = ddlBunkName.Visible ? ddlBunkName.SelectedItem.Text : txtBunkName.Text;
                    InsFuelEntry(Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), Convert.ToInt32(ddlDistrict.SelectedValue), fuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), _bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToInt64(ddlPetroCardNumber.SelectedValue), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToString(txtLocation.Text), Convert.ToInt32(Session["User_Id"].ToString()), DateTime.Now, 1, Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                    FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                }
                else if (Save.Text == "Save" && ddlPetroCardNumber.Enabled == false)
                {
                    _bunkname = ddlBunkName.Visible ? ddlBunkName.SelectedItem.Text : txtBunkName.Text;
                    InsFuelEntry1(Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), fuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), _bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToString(txtLocation.Text), Convert.ToInt32(Session["User_Id"].ToString()), DateTime.Now, 1, Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                    FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                }
                else if (Save.Text == "Update" && ddlPetroCardNumber.Enabled)
                {
                    _bunkname = ddlBunkName.Visible ? ddlBunkName.SelectedItem.Text : txtBunkName.Text;
                    UpdFuelEntry(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), Convert.ToInt32(ddlDistrict.SelectedValue), fuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), _bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToInt64(ddlPetroCardNumber.SelectedValue), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToString(txtLocation.Text), Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                    FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                }
                else
                {
                    _bunkname = ddlBunkName.Visible ? ddlBunkName.SelectedItem.Text : txtBunkName.Text;
                    UpdFuelEntry1(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), fuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), _bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToString(txtLocation.Text), Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                    FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                }

                break;
        }
    }

    private DataTable getpreviousODO(int vehicleId)
    {
        DataTable dtVehData;
        string connetionString = null;
        var adapter = new SqlDataAdapter();
        var ds = new DataSet();
        connetionString = ConfigurationManager.AppSettings["Str"];
        using (var connection = new SqlConnection(connetionString))
        {
            try
            {
                connection.Open();
                adapter.SelectCommand = new SqlCommand("select max(entrydate) maxentry from T_FMS_FuelEntryDetails where vehicleid = '" + vehicleId + "' and status = 1", connection);
                adapter.Fill(ds);
                connection.Close();
                dtVehData = ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
        }

        return dtVehData;
    }

    private void ShowKmpl()
    {
        var ds = ObjFuelEntry.GetKMPL(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        if (ds.Tables[0].Rows.Count > 0)
        {
            switch (ds.Tables[0].Rows[0]["KMPL"].ToString())
            {
                case "":
                    _flag = false;
                    _kmplInt = 0;
                    break;
                default:
                    var kmpl = ds.Tables[0].Rows[0]["KMPL"].ToString();
                    _kmplInt = Convert.ToDouble(kmpl);
                    _flag = true;
                    break;
            }
        }
        else
        {
            _flag = false;
            _kmplInt = 0;
        }
    }

    private void ShowMasterKmpl()
    {
        var ds = ObjFuelEntry.GetMasterKMPL(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        if (ds.Tables[0].Rows.Count > 0)
        {
            switch (ds.Tables[0].Rows[0]["KMPL"].ToString())
            {
                case "":
                    _flag = false;
                    _mSkmplInt = 0;
                    break;
                default:
                    var masterkmpl = ds.Tables[0].Rows[0]["KMPL"].ToString();
                    _mSkmplInt = Convert.ToDouble(masterkmpl);
                    _flag = true;
                    break;
            }
        }
        else
        {
            _flag = false;
            _kmplInt = 0;
        }

        //ClearFields();
    }

    private void UpdFuelEntry1(int fuelEntryId, int districtId, int vehicleId, DateTime entryDate, long billNumber, long odometer, string bunkName, int paymode, decimal quantity, decimal unitPrice, string location, decimal amount, int pilotId, string pilotName, int cardSwipedStatus, string remarks)
    {
        var res = ObjFuelEntry.IUpdFuelEntry1(fuelEntryId, districtId, vehicleId, entryDate, billNumber, odometer, bunkName, paymode, quantity, unitPrice, location, amount, pilotId, pilotName, cardSwipedStatus, remarks);
        ShowKmpl();
        ShowMasterKmpl();
        string strFmsScript;
        switch (res)
        {
            case 1:
                if (Math.Abs(Math.Abs(_kmplInt)) <= 0 && _flag == false)
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (_kmplInt < 8)
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt;
                    Show(strFmsScript);
                }
                else
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt;
                    Show(strFmsScript);
                }

                break;
            default:
                strFmsScript = "Failure";
                Show(strFmsScript);
                break;
        }

        ClearFields();
    }

    private void InsFuelEntry(int districtId, int vehicleId, int borrowedVehicle, DateTime entryDate, long billNumber, long odometer, string bunkName, int paymode, decimal quantity, long petroCardNumber, decimal unitPrice, int agencyId, string location, int createdBy, DateTime createdDate, int status, decimal amount, int pilotId, string pilotName, int cardSwipedStatus, string remarks)
    {
        var dsOdo = ObjFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        var maxodo = Convert.ToInt32(dsOdo.Tables[0].Rows[0]["ODO"].ToString());
        if (maxodo < odometer)
        {
            var dsres = ObjFuelEntry.IInsFuelEntry(districtId, vehicleId, borrowedVehicle, entryDate, billNumber, odometer, bunkName, paymode, quantity, petroCardNumber, unitPrice, agencyId, location, createdBy, createdDate, status, amount, pilotId, pilotName, cardSwipedStatus, remarks);
            ShowKmpl();
            ShowMasterKmpl();
            if (dsres.Tables[0].Rows.Count > 0)
            {
                var resid = dsres.Tables[0].Rows[0][0].ToString();
                if (Math.Abs(_kmplInt) <= 0 && _flag == false)
                {
                    var strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (_kmplInt < 8)
                {
                    var strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt + "\\nTransaction Id = " + resid;
                    Show(strFmsScript);
                }
                else
                {
                    var strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt + "\\nTransaction Id = " + resid;
                    Show(strFmsScript);
                }
            }
            else
            {
                var strFmsScript = "Failure";
                Show(strFmsScript);
            }

            ClearFields();
        }
        else
        {
            var strFmsScript = "Odometer Reading can't be less than the Previous Odometer Reading";
            Show(strFmsScript);
        }
    }

    private void InsFuelEntry1(int districtId, int vehicleId, DateTime entryDate, long billNumber, long odometer, string bunkName, int paymode, decimal quantity, decimal unitPrice, string location, int createdBy, DateTime createdDate, int status, decimal amount, int pilotId, string pilotName, int cardSwipedStatus, string remarks)
    {
        var ds = ObjFuelEntry.IInsFuelEntry1(districtId, vehicleId, entryDate, billNumber, odometer, bunkName, paymode, quantity, unitPrice, location, createdBy, createdDate, status, amount, pilotId, pilotName, cardSwipedStatus, remarks);
        ShowKmpl();
        ShowMasterKmpl();
        if (ds.Tables[0].Rows.Count > 0)
        {
            var resid = ds.Tables[0].Rows[0][0].ToString();
            if (Math.Abs(_kmplInt) >= 0 && _flag == false)
            {
                var strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                Show(strFmsScript);
            }
            else if (_kmplInt < 8)
            {
                var strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt + "\\nTransaction Id = " + resid;
                Show(strFmsScript);
            }
            else
            {
                var strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt + "\\nTransaction Id = " + resid;
                Show(strFmsScript);
            }
        }
        else
        {
            var strFmsScript = "Failure";
            Show(strFmsScript);
        }

        ClearFields();
    }

    private void UpdFuelEntry(int fuelEntryId, int districtId, int vehicleId, int borrowedVehicle, DateTime entryDate, long billNumber, long odometer, string bunkName, int paymode, decimal quantity, long petroCardNumber, decimal unitPrice, int agencyId, string location, decimal amount, int pilotId, string pilotName, int cardSwipedStatus, string remarks)
    {
        var res = ObjFuelEntry.IUpdFuelEntry(fuelEntryId, districtId, vehicleId, borrowedVehicle, entryDate, billNumber, odometer, bunkName, paymode, quantity, petroCardNumber, unitPrice, agencyId, location, amount, pilotId, pilotName, cardSwipedStatus, remarks);
        ShowKmpl();
        ShowMasterKmpl();
        string strFmsScript;
        switch (res)
        {
            case 1:
                if (Math.Abs(_kmplInt) <= 0 && _flag == false)
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (_kmplInt < 8)
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt;
                    Show(strFmsScript);
                }
                else
                {
                    strFmsScript = "Fuel Entry Inserted and KMPL = " + _kmplInt + "\\nBenchMark KMPL =" + _mSkmplInt;
                    Show(strFmsScript);
                }

                break;
            default:
                strFmsScript = "Failure";
                Show(strFmsScript);
                break;
        }

        ClearFields();
    }

    private void FillGridFuelEntry(int vehicleId)
    {
        gvFuelEntry.Visible = true;
        if (Session["UserdistrictId"] != null)
        {
            var districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        }

        var ds = ObjFuelEntry.IFillGridFuelEntry(vehicleId);
        if (ds != null && ds.Tables.Count > 0)
        {
            gvFuelEntry.DataSource = ds;
            gvFuelEntry.DataBind();
            ViewState["maxodometer"] = ds.Tables[0].Rows[0]["odo"].ToString();
        }
        else
        {
            ViewState["maxodometer"] = 0;
        }
    }

    protected void gvFuelEntry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFuelEntry.PageIndex = e.NewPageIndex;
        if (Session["UserdistrictId"] != null)
        {
            var districtId = Convert.ToInt32(Session["UserdistrictId"].ToString());
        }

        var ds = ObjFuelEntry.IFillGridFuelEntry(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
        gvFuelEntry.DataSource = ds;
        gvFuelEntry.DataBind();
    }

    protected void Reset_Click(object sender, EventArgs e)
    {
        ClearFields();
    }

    private void ClearFields()
    {
        txtAmount.Text = string.Empty;
        ;
        txtBillNumber.Text = string.Empty;
        if (ddlBunkName.Visible)
            ddlBunkName.Items.Clear();
        else
            txtBunkName.Text = string.Empty;

        txtEdit.Text = string.Empty;
        txtFuelEntryDate.Text = string.Empty;
        txtLocation.Text = string.Empty;
        txtOdometer.Text = string.Empty;
        txtQuantity.Text = string.Empty;
        txtSegmentID.Text = string.Empty;
        txtUnitPrice.Text = string.Empty;
        txtPilotID.Text = string.Empty;
        txtPilotName.Text = string.Empty;
        var ds = new DataSet();
        if (ddlAgency.Items.Count != 0) ddlAgency.SelectedIndex = -1;

        ddlPaymode.SelectedIndex = 0;
        if (ddlAgency.Items.Count != 0) ddlPetroCardNumber.SelectedIndex = -1;

        if (ddlAgency.Items.Count != 0) ddlVehicleNumber.SelectedIndex = -1;

        txtRemarks.Text = "";
        ddlAgency.Enabled = true;
        ddlAgency.Items.Clear();
        ddlPaymode.Enabled = true;
        ddlPetroCardNumber.Enabled = true;
        ddlPetroCardNumber.Items.Clear();
        ddlVehicleNumber.Enabled = true;
        ddlDistrict.Enabled = true;
        ddlDistrict.Items.Clear();
        ddlCardSwiped.SelectedIndex = -1;
        Save.Text = "Save";
        ddlVehicleNumber.SelectedIndex = 0;
        txtOdometer.Enabled = true;
        ddlCardSwiped.SelectedIndex = -1;
        ddlCardSwiped.Enabled = true;
        gvLastTransactions.Visible = false;
        gvFuelEntry.Visible = false;
        lblDistrict.Visible = false;
        lblLocation.Visible = false;
        txtBunkName.Visible = true;
        txtBunkName.Text = "";
        txtBunkName.Enabled = false;
        ddlBunkName.Visible = false;
        Save.Enabled = true;
    }

    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    protected void gvFuelEntry_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "EditFuel":
            {
                Save.Text = "Update";
                var id = Convert.ToInt32(e.CommandArgument.ToString());
                var ds = ObjFuelEntry.IEditFuelEntryDetails(id);
                FillCardNumber(Convert.ToInt32(ds.Tables[0].Rows[0]["VehicleID"].ToString()));
                ddlPetroCardNumber.Enabled = false;
                txtEdit.Text = Convert.ToString(id);
                ddlPaymode.ClearSelection();
                ddlPaymode.Items.FindByValue(ds.Tables[0].Rows[0]["Paymode"].ToString()).Selected = true;
                ddlVehicleNumber.ClearSelection();
                ddlVehicleNumber.Items.FindByValue(ds.Tables[0].Rows[0]["VehicleID"].ToString()).Selected = true;
                ddlCardSwiped.ClearSelection();
                ddlCardSwiped.Items.FindByValue(ds.Tables[0].Rows[0]["CardSwipedStatus"].ToString()).Selected = true;
                ddlCardSwiped.Enabled = false;
                FillDistricts();
                maxOdo.Value = "0";
                txtFuelEntryDate.Text = ds.Tables[0].Rows[0]["EntryDate"].ToString();
                txtBillNumber.Text = ds.Tables[0].Rows[0]["BillNumber"].ToString();
                txtOdometer.Text = ds.Tables[0].Rows[0]["Odometer"].ToString();
                //  txtOdometer.Enabled = false;
                txtBunkName.Text = ds.Tables[0].Rows[0]["BunkName"].ToString();
                var coBGrade = Convert.ToString(ds.Tables[0].Rows[0]["Quantity"].ToString()).Split('.');
                txtQuantity.Text = coBGrade[0] + '.' + coBGrade[1].Substring(0, 2);
                txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                var cGrade = Convert.ToString(ds.Tables[0].Rows[0]["UnitPrice"].ToString()).Split('.');
                txtUnitPrice.Text = cGrade[0] + '.' + cGrade[1].Substring(0, 2);
                var coAGrade = Convert.ToString(ds.Tables[0].Rows[0]["Amount"].ToString()).Split('.');
                txtAmount.Text = coAGrade[0] + '.' + coAGrade[1].Substring(0, 2);
                txtPilotID.Text = ds.Tables[0].Rows[0]["Pilot"].ToString();
                txtPilotName.Text = ds.Tables[0].Rows[0]["PilotName"].ToString();
                txtRemarks.Text = ds.Tables[0].Rows[0]["RemarksFuel"].ToString();
                if (ds.Tables[0].Rows[0]["PetroCardNumber"].ToString() != string.Empty)
                {
                    switch (Convert.ToInt32(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString()))
                    {
                        case 0:
                        {
                            var vid = Convert.ToInt32(ds.Tables[0].Rows[0]["VehicleID"].ToString());
                            ddlPetroCardNumber.ClearSelection();
                            FillCardNumber(vid);
                            ddlPetroCardNumber.Items.FindByValue(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString()).Selected = true;
                            var pid = Convert.ToInt32(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString());
                            ddlAgency.ClearSelection();
                            FillFuelAgency(pid);
                            ddlAgency.Items.FindByValue(ds.Tables[0].Rows[0]["AgencyID"].ToString()).Selected = true;
                            break;
                        }
                        default:
                        {
                            var vid = Convert.ToInt32(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString());
                            ddlDistrict.ClearSelection();
                            ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString()).Selected = true;
                            ddlPetroCardNumber.ClearSelection();
                            FillCardNumber(vid);
                            ddlPetroCardNumber.Items.FindByValue(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString()).Selected = true;
                            var pid = Convert.ToInt32(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString());
                            ddlAgency.ClearSelection();
                            FillFuelAgency(pid);
                            ddlAgency.Items.FindByValue(ds.Tables[0].Rows[0]["AgencyID"].ToString()).Selected = true;
                            break;
                        }
                    }
                }
                else
                {
                    FillFuelAgency(0);
                    var vid = Convert.ToInt32(ds.Tables[0].Rows[0]["VehicleID"].ToString());
                    ObjFuelEntry.IFillCardNumber(vid);
                    ObjFuelEntry.IFillAgencyWoDistrictID();
                }

                ddlAgency.Enabled = false;
                ddlPaymode.Enabled = false;
                ddlPetroCardNumber.Enabled = false;
                ddlVehicleNumber.Enabled = false;
                ddlDistrict.Enabled = false;
                break;
            }
            case "DeleteFuel":
            {
                var id = Convert.ToInt32(e.CommandArgument.ToString());
                var result = ObjFuelEntry.IDeleteFuelEntry(id);
                switch (result)
                {
                    case 1:
                    {
                        var strFmsScript = "Fuel Entry Deactivated";
                        Show(strFmsScript);
                        break;
                    }
                    default:
                    {
                        var strFmsScript = "failure";
                        Show(strFmsScript);
                        break;
                    }
                }

                ClearFields();
                FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                break;
            }
        }
    }

    protected void lnkNew_Click(object sender, EventArgs e)
    {
        txtBunkName.Visible = false;
        ddlBunkName.Visible = true;
        linkExisting.Visible = true;
        lnkNew.Visible = false;
        FillServiceStn();
    }

    protected void linkExisting_Click(object sender, EventArgs e)
    {
        txtBunkName.Visible = true;
        ddlBunkName.Visible = false;
        linkExisting.Visible = false;
        lnkNew.Visible = true;
        FillServiceStnVeh();
    }
}