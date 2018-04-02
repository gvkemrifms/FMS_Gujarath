using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class DistrictVehicleMapping : Page
{
    readonly GvkFMSAPP.BLL.Admin.DistrictVehicleMapping _distvehmapp = new GvkFMSAPP.BLL.Admin.DistrictVehicleMapping();
    readonly GvkFMSAPP.BLL.VAS_BLL.VASGeneral _vehallobj = new GvkFMSAPP.BLL.VAS_BLL.VASGeneral();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "abc()", true);
            btnSave.Attributes.Add("onclick", "return validation()");
            GetVehicles();
            GetDistrict();
            GetVehicleTypes();
        }
    }

    private void GetVehicleTypes()
    {
        DataSet ds = _distvehmapp.GetVehicleTypes();

        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "vehicle_type_name", "vehicle_type_id", ddlVehType);
           

        }
    }

    public void GetVehicles()
    {
        DataSet ds = _distvehmapp.GetVehicles();

        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "VehicleNumber", "VehicleID", ddlVehicleNumber);

        }
    }

    public void GetDistrict()
    {
        DataSet ds = _distvehmapp.GetDistrict();

        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "district_name", "district_id", ddlDistrict);
           
        }
    }

    protected void lnkbtnNewBaseLoc_Click(object sender, EventArgs e)
    {
        ddlBaseLocation.Visible = false;
        txtBaseLocation.Visible = true;
        lnkbtnExtngBaseLoc.Visible = true;
        lnkbtnNewBaseLoc.Visible = false;
        ddlBaseLocation.SelectedIndex = 0;
        txtContactNumber.Text = "";
        lblLatitude.Visible = true;
        lblLongitude.Visible = true;
        lblMandatory1.Visible = true;
        lblMandatory2.Visible = true;
        txtLatitude.Visible = true;
        txtLongitude.Visible = true;
        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "open()", true);

    }

    protected void lnkbtnExtngBaseLoc_Click(object sender, EventArgs e)
    {
        ddlBaseLocation.Visible = true;
        txtBaseLocation.Visible = false;
        lnkbtnExtngBaseLoc.Visible = false;
        lnkbtnNewBaseLoc.Visible = true;
        lblLatitude.Visible = false;
        lblLongitude.Visible = false;
        lblMandatory1.Visible = false;
        lblMandatory2.Visible = false;
        txtLatitude.Text = "";
        txtLongitude.Text = "";
    }

    protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {

        ddlMandal.Items.Clear();
        ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));

        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));

        txtContactNumber.Text = "";
        
        GetMandals();
        
    }



    public void GetMandals()
    {
        _vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        DataSet ds = _vehallobj.GetMandals_new();
        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "mandal_name", "mandal_id", ddlMandal);
           
        }
    }

    public void GetCity()
    {
        _vehallobj.MandalId = Convert.ToInt32(ddlMandal.SelectedItem.Value);
        DataSet ds = _vehallobj.GetCities_new();
        ddlCity.DataSource = ds;
        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "ct_lname", "city_id", ddlCity);
            
        }
    }

    public void GetBaseLocation()
    {
        _vehallobj.CityId = Convert.ToInt32(ddlCity.SelectedItem.Value);
        var ds = _vehallobj.GetBaseLocation();
        ViewState["ContactNumber"] = ds;
        ddlBaseLocation.DataSource = ds;
        if (ds != null)
        {
            AccidentReport.FillDropDownHelperMethodWithDataSet(ds, "Base_Location", "Location_ID", ddlBaseLocation);
            
        }
    }

    protected void ddlSegments_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetMandals();
        GetDistrictMandals();
    }

    public void GetDistrictMandals()
    {
        _vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        
        DataSet ds = _vehallobj.GetMandalsDistAndSegwise();

        
    }

    protected void ddlMandal_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetCity();
    }

    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetBaseLocation();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlVehType.SelectedIndex <= 0)
        {
            Show("Please Select vehicle type");
            return;
        }

        

        _vehallobj.OffRoadVehcileId = Convert.ToInt32(ddlVehicleNumber.SelectedItem.Value);
        _vehallobj.OffRoadVehicleNo = ddlVehicleNumber.SelectedItem.Text;
        _vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        _vehallobj.District = ddlDistrict.SelectedItem.Text;

        string manids = "";
        
        _vehallobj.MandalId = Convert.ToInt32(ddlMandal.SelectedItem.Value);
        _vehallobj.Mandal = ddlMandal.SelectedItem.Text;
        _vehallobj.CityId = Convert.ToInt32(ddlCity.SelectedItem.Value);
        _vehallobj.City = ddlCity.SelectedItem.Text;
        if (ddlBaseLocation.Visible)
        {
            _vehallobj.BaseLocationId = Convert.ToInt32(ddlBaseLocation.SelectedItem.Value);
            _vehallobj.BaseLocation = ddlBaseLocation.SelectedItem.Text;
            _vehallobj.Flag = "Old";
            _vehallobj.Latitude = "0.00";
            _vehallobj.Longitude = "0.00";

 // Bind Lat Longs
        }
        else
        {
            _vehallobj.BaseLocationId = 0;
            _vehallobj.BaseLocation = txtBaseLocation.Text;
            _vehallobj.Flag = "New";
            _vehallobj.Latitude = txtLatitude.Text;
            _vehallobj.Longitude = txtLongitude.Text;
        }


        _vehallobj.SegmentId = 0;
        _vehallobj.Segment = "";
        _vehallobj.NewSegFlag = "New";
        for (int i = 1; i < ddlMandal.Items.Count; i++)
            manids = manids + ddlMandal.Items[i].Value + ",";
        _vehallobj.NewSegMandalIds = manids;

        _vehallobj.SegmentId = 0;
       
        _vehallobj.Latitude = txtLatitude.Text;
        _vehallobj.Longitude = txtLongitude.Text;
        _vehallobj.ContactNumber = txtContactNumber.Text;
        _vehallobj.VehType = ddlVehType.SelectedItem.Value;
        ClsGeneral clsGen = new ClsGeneral();


        var dtGetVehData = clsGen.getVehicleData(ddlVehicleNumber.SelectedItem.Text);
        int insres = _vehallobj.InsNewVehAllocation_new();
        if (insres != 0)
        {
            clsGen.InsertVehicle(ddlVehicleNumber.SelectedItem.Value, ddlVehicleNumber.SelectedItem.Text, "1",
                txtContactNumber.Text, txtLatitude.Text, txtLongitude.Text, ddlVehType.SelectedItem.Text,
                ddlDistrict.SelectedItem.Value, ddlMandal.SelectedItem.Value,
                ddlBaseLocation.Visible ? ddlBaseLocation.SelectedItem.Text : txtBaseLocation.Text);

            if (dtGetVehData.Rows.Count > 0)
            {
                UpdateData(ddlVehicleNumber, txtContactNumber.Text, txtLatitude.Text, txtLongitude.Text, ddlDistrict.SelectedItem.Value, ddlMandal.SelectedItem.Value, ddlBaseLocation.SelectedItem.Text);
            }

            Show("Record Inserted Successfully!!");
        }
        else
            Show("Error!!");

        ClearAll();

       
    }
    private void UpdateData(DropDownList vehicleNumber, string contactNumber, string latitude, string longitude, string district, string mandal, string baseLocation)
    {
        string statement = "";
        statement = statement + "update m_vehicle set  `contact_number` = '" + contactNumber + "',`latitude`= '" + latitude + "',`longitude` = '" + longitude + "',`mandal_id`  = '" + mandal + "',`location_name`  = '" + baseLocation + "', district_id= '" + district + "'";
        statement = statement + "  where `vehicle_no` = '" + vehicleNumber.SelectedItem.Text + "' ;";
       ExecuteInsertStatement(statement);
    }

    private void ExecuteInsertStatement(string insertStmt)
    {
        using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["MySqlConn"]))
        {
            using (MySqlCommand comm = new MySqlCommand())
            {
                comm.Connection = conn;
                comm.CommandText = insertStmt;
                try
                {
                    conn.Open();
                    comm.ExecuteNonQuery();
                    TraceService(insertStmt);
        
                }
                catch (MySqlException ex)
                {
                    TraceService(" executeInsertStatement " + ex + insertStmt);
                
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
    private void TraceService(string content)
    {
        string str = @"d:\SmsLog_1\Log.txt";
        string path1 = str.Substring(0, str.LastIndexOf("\\", StringComparison.Ordinal));
        string path2 = str.Substring(0, str.LastIndexOf(".txt", StringComparison.Ordinal)) + "-" + DateTime.Today.ToString("yyyy-MM-dd") + ".txt";
        try
        {
            if (!Directory.Exists(path1))
                Directory.CreateDirectory(path1);
            if (path2.Length >= Convert.ToInt32(4000000))
            {
                path2 = str.Substring(0, str.LastIndexOf(".txt", StringComparison.Ordinal)) + "-" + "2" + ".txt";
            }
            StreamWriter streamWriter = File.AppendText(path2);
            streamWriter.WriteLine("====================" + DateTime.Now.ToLongDateString() + "  " + DateTime.Now.ToLongTimeString());
            streamWriter.WriteLine(content);
            streamWriter.Flush();
            streamWriter.Close();
        }

        catch (Exception ex)
        {
            traceService(ex.ToString());
        }
    }

    private void traceService(string content)
    {
        FileStream fs = new FileStream(@"d:\SmsLog\logException.txt", FileMode.OpenOrCreate, FileAccess.Write);
        //set up a streamwriter for adding text
        StreamWriter sw = new StreamWriter(fs);
        //find the end of the underlying filestream
        sw.BaseStream.Seek(0, SeekOrigin.End);
        //add the text
        sw.WriteLine(content);
        //add the text to the underlying filestream
        sw.Flush();
        //close the writer
        sw.Close();
    }
    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);

    }

    public void ClearAll()
    {
        ddlVehicleNumber.SelectedIndex = 0;
        ddlDistrict.SelectedIndex = 0;
        ddlVehType.SelectedIndex = 0;
        ddlMandal.Items.Clear();
        ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlBaseLocation.Items.Clear();
        ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));
        txtBaseLocation.Text = "";
        txtContactNumber.Text = "";
        lblLatitude.Visible = false;
        lblLongitude.Visible = false;
        lblMandatory1.Visible = false;
        lblMandatory2.Visible = false;
        txtLatitude.Visible = false;
        txtLongitude.Visible = false;
        txtLatitude.Text = "";
        txtLongitude.Text = "";
       
    }

    protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        _vehallobj.OffRoadVehicleNo = ddlVehicleNumber.SelectedItem.Text;

        var dsvehalldet = _vehallobj.GetVehAllocationDet();
        if (dsvehalldet.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Vehicle is already allocated to :\\n");
            sb.Append("\\nDistrict      - " + dsvehalldet.Tables[0].Rows[0]["District"]);
            sb.Append("\\nSegment       - " + dsvehalldet.Tables[0].Rows[0]["Segment"]);
            sb.Append("\\nMandal        - " + dsvehalldet.Tables[0].Rows[0]["Mandal"]);
            sb.Append("\\nCity/Village  - " + dsvehalldet.Tables[0].Rows[0]["City"]);
            sb.Append("\\nBase Location - " + dsvehalldet.Tables[0].Rows[0]["BaseLocation"]);
            string str = sb.ToString();
            Show(str);
        }
    }

    protected void lnkbtnNewSegment_Click(object sender, EventArgs e)
    {
        
        _vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
           _vehallobj.GetMandalsDistictwise();
            ddlMandal.Items.Clear();
            ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));

            txtContactNumber.Text = "";
    }

    protected void lnkbtnExtngSegment_Click(object sender, EventArgs e)
    {
       
        ddlMandal.Items.Clear();
        ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
        txtContactNumber.Text = "";
    }

    protected void chkblstmandals_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void ddlBaseLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlBaseLocation.SelectedIndex != 0)
        {
            var dsblcn = (DataSet)ViewState["ContactNumber"];
            DataView dv = new DataView(dsblcn.Tables[0], "Location_ID =" + Convert.ToInt32(ddlBaseLocation.SelectedItem.Value), "Contact_Number", DataViewRowState.CurrentRows);
            txtContactNumber.Text = dv[0]["Contact_Number"].ToString();
            txtLatitude.Text = dv[0]["latitude"].ToString();
            txtLongitude.Text = dv[0]["longitude"].ToString();
            ClsGeneral csg = new ClsGeneral();
            var dtVehData = csg.getVehiclesinRadius(txtLatitude.Text, txtLongitude.Text, ConfigurationManager.AppSettings["Locateveh"]);

            if (dtVehData.Rows.Count > 0)
            {
                lblVeh.Text = "Vehicles that are under " + ConfigurationManager.AppSettings["Locateveh"] + "KMs to base location ";
                grdVehicleData.DataSource = dtVehData;
                grdVehicleData.DataBind();
            }

        }
        else
        {
            txtContactNumber.Text = "";
            txtLatitude.Text = "";
            txtLongitude.Text = "";
        }

    }
}