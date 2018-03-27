 using MySql.Data.MySqlClient;
 using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
 using System.Web.UI.WebControls;

namespace GvkFMSAPP.PL.Prior_MaintenanceStage
{
    public partial class DistrictVehicleMapping : System.Web.UI.Page
    {
        GvkFMSAPP.BLL.Admin.DistrictVehicleMapping distvehmapp = new GvkFMSAPP.BLL.Admin.DistrictVehicleMapping();
        GvkFMSAPP.BLL.VAS_BLL.VASGeneral vehallobj = new GvkFMSAPP.BLL.VAS_BLL.VASGeneral();

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
            DataSet ds = distvehmapp.GetVehicleTypes();

            if (ds != null)
            {
                ddlVehType.DataSource = ds.Tables[0];
                ddlVehType.DataValueField = "vehicle_type_id";
                ddlVehType.DataTextField = "vehicle_type_name";
                ddlVehType.DataBind();
                ddlVehType.Items.Insert(0, new ListItem("--Select--", "0"));

            }
        }

        public void GetVehicles()
        {
            DataSet ds = distvehmapp.GetVehicles();

            if (ds != null)
            {
                ddlVehicleNumber.DataSource = ds.Tables[0];
                ddlVehicleNumber.DataValueField = "VehicleID";
                ddlVehicleNumber.DataTextField = "VehicleNumber";
                ddlVehicleNumber.DataBind();
                ddlVehicleNumber.Items.Insert(0, new ListItem("--Select--", "0"));

            }
        }

        public void GetDistrict()
        {
            DataSet ds = distvehmapp.GetDistrict();

            if (ds != null)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "district_name";
                ddlDistrict.DataValueField = "district_id";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
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
            // txtLatitude.Visible = false;
            // txtLongitude.Visible = false;
            txtLatitude.Text = "";
            txtLongitude.Text = "";
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlSegments.Items.Clear();
            //ddlSegments.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlMandal.Items.Clear();
            ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));

            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));

            //ddlBaseLocation.Items.Clear();
            //ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));

            //txtBaseLocation.Text = "";
            txtContactNumber.Text = "";
            //txtNewSegment.Text = "";
            //ddlSegments.Visible = true;
            //txtNewSegment.Visible = false;
            //lnkbtnNewSegment.Visible = true;
            //lnkbtnExtngSegment.Visible = false;

            //ddlBaseLocation.Visible = true;
            //txtBaseLocation.Visible = false;
            //lnkbtnNewBaseLoc.Visible = true;
            //lnkbtnExtngBaseLoc.Visible = false;
            GetMandals();
            //  pnlmandals.Visible = false;

            //  GetSegments();
        }

        //public void GetSegments()
        //{
        //    ddlSegments.Items.Clear();
        //    vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
        //    ddlSegments.DataSource = vehallobj.GetSegments();
        //    ddlSegments.DataTextField = "Sg_SName";
        //    ddlSegments.DataValueField = "Sg_Segid";
        //    ddlSegments.DataBind();
        //    ddlSegments.Items.Insert(0, new ListItem("--Select--", "0"));
        //}

        public void GetMandals()
        {
            ddlMandal.Items.Clear();
            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            // vehallobj.SegmentId = Convert.ToInt32(ddlSegments.SelectedItem.Value);
            ddlMandal.DataSource = vehallobj.GetMandals_new();
            ddlMandal.DataTextField = "mandal_name";
            ddlMandal.DataValueField = "mandal_id";
            ddlMandal.DataBind();
            ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        public void GetCity()
        {
            ddlCity.Items.Clear();
            vehallobj.MandalId = Convert.ToInt32(ddlMandal.SelectedItem.Value);
            ddlCity.DataSource = vehallobj.GetCities_new();
            ddlCity.DataTextField = "ct_lname";
            ddlCity.DataValueField = "city_id";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        public void GetBaseLocation()
        {
            // ddlBaseLocation.Items.Clear();
            vehallobj.CityId = Convert.ToInt32(ddlCity.SelectedItem.Value);
            //vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            //vehallobj.SegmentId = Convert.ToInt32(ddlSegments.SelectedItem.Value);
            DataSet dsbl = new DataSet();
            dsbl = vehallobj.GetBaseLocation();
            ViewState["ContactNumber"] = dsbl;
            ddlBaseLocation.DataSource = dsbl;
            // ddlBaseLocation.DataSource = vehallobj.GetBaseLocation();
            ddlBaseLocation.DataTextField = "Base_Location";
            ddlBaseLocation.DataValueField = "Location_ID";
            ddlBaseLocation.DataBind();
            ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));
        }


        protected void ddlSegments_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetMandals();
            GetDistrictMandals();
        }

        public void GetDistrictMandals()
        {
            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            // vehallobj.SegmentId = Convert.ToInt32(ddlSegments.SelectedItem.Value);
            DataSet ds = vehallobj.GetMandalsDistAndSegwise();

            //if (ds != null)
            //{
            //    chkblstmandals.DataSource = ds;
            //    chkblstmandals.DataTextField = "Sg_LName";
            //    chkblstmandals.DataValueField = "Sg_Mdid";
            //    chkblstmandals.DataBind();
            //}
            //pnlmandals.Visible = true;
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

            //if(us2lat.Text == "" || us2lon.Text == "" )
            //{
            //    Show("Please Select Latitude or Longitude");
            //    return;
            //}

            vehallobj.OffRoadVehcileId = Convert.ToInt32(ddlVehicleNumber.SelectedItem.Value);
            vehallobj.OffRoadVehicleNo = ddlVehicleNumber.SelectedItem.Text;
            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            vehallobj.District = ddlDistrict.SelectedItem.Text;

            string manids = "";
            //if (ddlSegments.Visible)
            //{
            //    vehallobj.SegmentId = Convert.ToInt32(ddlSegments.SelectedItem.Value);
            //    vehallobj.Segment = ddlSegments.SelectedItem.Text;
            //    //vehallobj.NewSegFlag = "Old";
            //    //vehallobj.NewSegMandalIds = "";
            //    vehallobj.NewSegFlag = "New";
            //    for (int i = 1; i < ddlMandal.Items.Count; i++)
            //        manids = manids + ddlMandal.Items[i].Value.ToString() + ",";
            //    vehallobj.NewSegMandalIds = manids;
            //}
            //else
            //{
            //    //string manids = "";
            //    vehallobj.SegmentId = 0;
            //    // vehallobj.Segment = txtNewSegment.Text;
            //    vehallobj.NewSegFlag = "New";
            //    for (int i = 1; i < ddlMandal.Items.Count; i++)
            //        manids = manids + ddlMandal.Items[i].Value.ToString() + ",";
            //    vehallobj.NewSegMandalIds = manids;
            //}
            vehallobj.MandalId = Convert.ToInt32(ddlMandal.SelectedItem.Value);
            vehallobj.Mandal = ddlMandal.SelectedItem.Text;
            vehallobj.CityId = Convert.ToInt32(ddlCity.SelectedItem.Value);
            vehallobj.City = ddlCity.SelectedItem.Text;
            if (ddlBaseLocation.Visible)
            {
                vehallobj.BaseLocationId = Convert.ToInt32(ddlBaseLocation.SelectedItem.Value);
                vehallobj.BaseLocation = ddlBaseLocation.SelectedItem.Text;
                vehallobj.Flag = "Old";
                vehallobj.Latitude = "0.00";
                vehallobj.Longitude = "0.00";


                // Bind Lat Longs
            }
            else
            {
                vehallobj.BaseLocationId = 0;
                vehallobj.BaseLocation = txtBaseLocation.Text;
                vehallobj.Flag = "New";
                vehallobj.Latitude = txtLatitude.Text;
                vehallobj.Longitude = txtLongitude.Text;
            }


            vehallobj.SegmentId = 0;
            vehallobj.Segment = "";
            vehallobj.NewSegFlag = "New";
            for (int i = 1; i < ddlMandal.Items.Count; i++)
                manids = manids + ddlMandal.Items[i].Value.ToString() + ",";
            vehallobj.NewSegMandalIds = manids;

            vehallobj.SegmentId = 0;
            // vehallobj.BaseLocationId = 0;
            //   vehallobj.BaseLocation = "";
            // vehallobj.Flag = "New";
            vehallobj.Latitude = txtLatitude.Text;
            vehallobj.Longitude = txtLongitude.Text;
            vehallobj.ContactNumber = txtContactNumber.Text;
            vehallobj.VehType = ddlVehType.SelectedItem.Value.ToString();
            DataTable dtGetVehData = new DataTable();
            ClsGeneral clsGen = new ClsGeneral();


            dtGetVehData = clsGen.getVehicleData(ddlVehicleNumber.SelectedItem.Text.ToString());
             int insres = vehallobj.InsNewVehAllocation_new();
            if (insres != 0)
            {
                if (ddlBaseLocation.Visible) { clsGen.InsertVehicle(ddlVehicleNumber.SelectedItem.Value, ddlVehicleNumber.SelectedItem.Text, "1", txtContactNumber.Text, txtLatitude.Text, txtLongitude.Text, ddlVehType.SelectedItem.Text.ToString(), ddlDistrict.SelectedItem.Value, ddlMandal.SelectedItem.Value, ddlBaseLocation.SelectedItem.Text); }
                else
                {

                    clsGen.InsertVehicle(ddlVehicleNumber.SelectedItem.Value, ddlVehicleNumber.SelectedItem.Text, "1", txtContactNumber.Text, txtLatitude.Text, txtLongitude.Text, ddlVehType.SelectedItem.Text.ToString(), ddlDistrict.SelectedItem.Value, ddlMandal.SelectedItem.Value, txtBaseLocation.Text);
                }

                if (dtGetVehData.Rows.Count > 0)
                {
                    UpdateData(ddlVehicleNumber.SelectedItem.Value, ddlVehicleNumber.SelectedItem.Text,  txtContactNumber.Text, txtLatitude.Text, txtLongitude.Text, ddlVehType.SelectedItem.Text.ToString(), ddlDistrict.SelectedItem.Value, ddlMandal.SelectedItem.Value, ddlBaseLocation.SelectedItem.Text);
                }
                else
                {

                }
                Show("Record Inserted Successfully!!");
            }
            else
                Show("Error!!");

            ClearAll();

            //if (!ddlSegments.Visible)
            //{
            //    if (vehallobj.ChkExistingSegment().Tables[0].Rows.Count > 0)
            //    {
            //        Show("Segment Already Exist!!");
            //    }
            //    else
            //    {
            //        int insres = vehallobj.InsNewVehAllocation();
            //        if (insres != 0)
            //            Show("Record Inserted Successfully!!");
            //        else
            //            Show("Error!!");

            //        ClearAll();
            //    }
            //}
            //else
            //{
            //    int insres = vehallobj.InsNewVehAllocation();
            //    if (insres != 0)
            //        Show("Record Inserted Successfully!!");
            //    else
            //        Show("Error!!");

            //    ClearAll();
            //}

        }
private void UpdateData(string VehicleNumberValue, string VehicleNumber, string ContactNumber, string Latitude, string Longitude, string ddlVehType, string District, string Mandal, string BaseLocation)
        {
            string statement = "";
            statement = statement + "update m_vehicle set  `contact_number` = '"+ ContactNumber + "',`latitude`= '" + Latitude + "',`longitude` = '" + Longitude + "',`mandal_id`  = '" + Mandal + "',`location_name`  = '" + BaseLocation + "', district_id= '"+District+"'";
            statement = statement + "  where `vehicle_no` = '" + VehicleNumber + "' ;";
            int i = executeInsertStatement(statement);
        }

        private int executeInsertStatement(string insertStmt)
        {
            int i = 0;
            using (MySqlConnection conn = new MySqlConnection(ConfigurationSettings.AppSettings["MySqlConn"].ToString()))
            {
                using (MySqlCommand comm = new MySqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = insertStmt;
                    try
                    {
                        conn.Open();
                        i = comm.ExecuteNonQuery();
                        TraceService(insertStmt);
                        return i;
                    }
                    catch (MySqlException ex)
                    {
                        TraceService(" executeInsertStatement " + ex.ToString() + insertStmt);
                        return i;
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
            string path1 = str.Substring(0, str.LastIndexOf("\\"));
            string path2 = str.Substring(0, str.LastIndexOf(".txt")) + "-" + DateTime.Today.ToString("yyyy-MM-dd") + ".txt";
            try
            {
                if (!Directory.Exists(path1))
                    Directory.CreateDirectory(path1);
                if (path2.Length >= Convert.ToInt32(4000000))
                {
                    path2 = str.Substring(0, str.LastIndexOf(".txt")) + "-" + "2" + ".txt";
                }
                StreamWriter streamWriter = File.AppendText(path2);
                streamWriter.WriteLine("====================" + DateTime.Now.ToLongDateString() + "  " + DateTime.Now.ToLongTimeString());
                streamWriter.WriteLine(content.ToString());
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
            //ddlSegments.Items.Clear();
            //ddlSegments.Items.Insert(0, new ListItem("--Select--", "0"));

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
            //us2lat.Text = "";
            //us2lon.Text = "";
        }

        protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            vehallobj.OffRoadVehicleNo = ddlVehicleNumber.SelectedItem.Text;

            DataSet dsvehalldet = new DataSet();
            dsvehalldet = vehallobj.GetVehAllocationDet();
            if (dsvehalldet.Tables[0].Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("Vehicle is already allocated to :\\n").ToString();
                sb.Append("\\nDistrict      - " + dsvehalldet.Tables[0].Rows[0]["District"].ToString());
                sb.Append("\\nSegment       - " + dsvehalldet.Tables[0].Rows[0]["Segment"].ToString());
                sb.Append("\\nMandal        - " + dsvehalldet.Tables[0].Rows[0]["Mandal"].ToString());
                sb.Append("\\nCity/Village  - " + dsvehalldet.Tables[0].Rows[0]["City"].ToString());
                sb.Append("\\nBase Location - " + dsvehalldet.Tables[0].Rows[0]["BaseLocation"].ToString());
                string str = sb.ToString();
                Show(str);
            }
        }

        protected void lnkbtnNewSegment_Click(object sender, EventArgs e)
        {
            //ddlSegments.Visible = false;
            //txtNewSegment.Visible = true;
            //lnkbtnNewSegment.Visible = false;
            //lnkbtnExtngSegment.Visible = true;

            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            DataSet ds = vehallobj.GetMandalsDistictwise();

            //if (ds != null)
            //{
            //    chkblstmandals.DataSource = ds;
            //    chkblstmandals.DataTextField = "Md_LName";
            //    chkblstmandals.DataValueField = "MD_Mdid";
            //    chkblstmandals.DataBind();
            //}
            // pnlmandals.Visible = true;
            ddlMandal.Items.Clear();
            ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlBaseLocation.Items.Clear();
            //ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));
            txtContactNumber.Text = "";
        }

        protected void lnkbtnExtngSegment_Click(object sender, EventArgs e)
        {
            //ddlSegments.Visible = true;
            //txtNewSegment.Visible = false;
            //lnkbtnNewSegment.Visible = true;
            //lnkbtnExtngSegment.Visible = false;
            //pnlmandals.Visible = false;
            //txtNewSegment.Text = "";
            //ddlSegments.SelectedIndex = 0;
            ddlMandal.Items.Clear();
            ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlBaseLocation.Items.Clear();
            //ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));
            txtContactNumber.Text = "";
        }

        protected void chkblstmandals_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (pnlmandals.Visible == true)
            //{
            //    ddlMandal.Items.Clear();
            //    if (ddlSegments.Visible)
            //    {
            //        GetMandals();
            //    }

            //    for (int i = 0; i < chkblstmandals.Items.Count; i++)
            //    {
            //        if (chkblstmandals.Items[i].Selected)
            //        {
            //            ddlMandal.Items.Add(new ListItem(chkblstmandals.Items[i].Text, chkblstmandals.Items[i].Value));
            //        }
            //    }
            //    if (!ddlSegments.Visible)
            //        ddlMandal.Items.Insert(0, new ListItem("--Select--", "0"));

            //}
            //if (ddlCity.Items.Count > 0)
            //{
            //    ddlCity.Items.Clear();
            //    ddlCity.Items.Insert(0, new ListItem("--Select--", "0"));
            //}

            //if (ddlBaseLocation.Visible == true && ddlBaseLocation.Items.Count > 0)
            //{
            //    ddlBaseLocation.Items.Clear();
            //    ddlBaseLocation.Items.Insert(0, new ListItem("--Select--", "0"));
            //}
            //if (txtBaseLocation.Visible == true)
            //    txtBaseLocation.Text = "";
        }

        protected void ddlBaseLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBaseLocation.SelectedIndex != 0)
            {
                DataSet dsblcn = new DataSet();
                dsblcn = (DataSet)ViewState["ContactNumber"];
                DataView dv = new DataView(dsblcn.Tables[0], "Location_ID =" + Convert.ToInt32(ddlBaseLocation.SelectedItem.Value), "Contact_Number", DataViewRowState.CurrentRows);
                txtContactNumber.Text = dv[0]["Contact_Number"].ToString();
                txtLatitude.Text = dv[0]["latitude"].ToString();
                txtLongitude.Text = dv[0]["longitude"].ToString();
                ClsGeneral csg = new ClsGeneral();
                DataTable dtVehData = new DataTable();
                dtVehData = csg.getVehiclesinRadius(txtLatitude.Text, txtLongitude.Text, ConfigurationSettings.AppSettings["Locateveh"].ToString());

                if (dtVehData.Rows.Count > 0)
                {
                    lblVeh.Text = "Vehicles that are under " + ConfigurationSettings.AppSettings["Locateveh"].ToString() + "KMs to base location ";
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
}