using GvkFMSAPP.BLL;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
namespace GvkFMSAPP.PL.VAS
{
    public partial class VehicleOffroad : System.Web.UI.Page
    {
        GvkFMSAPP.BLL.BaseVehicleDetails fmsobj = new GvkFMSAPP.BLL.BaseVehicleDetails();
        GvkFMSAPP.BLL.VAS_BLL.VASGeneral vehallobj = new GvkFMSAPP.BLL.VAS_BLL.VASGeneral();
        public IInventory objInventory = new FMSInventory();
        GvkFMSAPP.BLL.FMSGeneral fmsgeneral = new GvkFMSAPP.BLL.FMSGeneral();
        DataTable dtBreakdown = new DataTable();
	protected void Page_PreInit(Object sender, EventArgs e)
        {

            if (Session["Role_Id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else {
                if (Session["Role_Id"].ToString() == "120")
                { 
                    this.MasterPageFile = "~/MasterERO.master";
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtAllEstimatedCost.Attributes.Add("onKeyPress", "javascript: return Integersonly(event);");
            txtEMEId.Attributes.Add("onKeyPress", "javascript: return Integersonly(event);");
            txtPilotId.Attributes.Add("onKeyPress", "javascript: return Integersonly(event);");
            if (Session["User_Name"] == null)
            {
                Response.Redirect("Error.aspx");
            }
            if (!IsPostBack)
            {
                divAggre.Visible = false;
                btnSubmit.Attributes.Add("onclick", "return validation()");
                GetDistrict();
                FillHoursandMins();
                GetTime();
                FillMaintenanceTypes();

                //txtReqBy.Text = Session["User_Name"].ToString();
                dtBreakdown = null;
                btnSubmit.Enabled = true;
                //ddlOFFHour.Items.FindByText(timenow[1].ToString()).Selected = true;
            }
        }


        public void FillMaintenanceTypes()
        {
            DataSet ds = fmsgeneral.GetMaintenanceType();
            ddlreasons.DataSource = ds.Tables[0];
            ddlreasons.DataValueField = "Maint_Type_ID";
            ddlreasons.DataTextField = "Maint_Desc";
            ddlreasons.DataBind();
            ddlreasons.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlreasons.Items.Insert(12, new ListItem("RESOURCE SHORTAGE", "13"));
            ddlreasons.Items.Insert(13, new ListItem("NO FUEL", "14"));
        }

        protected void GetTime()
        {
            // string[] timenow = DateTime.Now.ToString("dd/MM/yyyy hh:mm tt").Split(' ');
	        string[] timenow = DateTime.Now.ToString().Split(' ');
            txtOfftimeDate.Text = timenow[0].ToString();
            int hour = Convert.ToInt32(timenow[1].Split(':')[0].ToString());
            int minute = Convert.ToInt32(timenow[1].Split(':')[1].ToString());

            if (timenow.Length > 2)
            {
                if (timenow[2] != "PM")
                {

                    if (hour < 10)
                    {
                        ddlOFFHour.Items.FindByValue("0" + timenow[1].Split(':')[0].ToString()).Selected = true;
                    }
                    else
                    {
                        ddlOFFHour.Items.FindByValue(timenow[1].Split(':')[0].ToString()).Selected = true;
                    }

                }
                else
                {
                    if (hour == 12)
                    {
                        ddlOFFHour.Items.FindByValue(hour.ToString()).Selected = true;
                    }
                    else
                    {
                        hour = hour + 12;
                        ddlOFFHour.Items.FindByValue(hour.ToString()).Selected = true;
                    }
                }
            }
            else
            {
                if (hour == 12)
                    hour = 0;
                else if (hour > 12)
                    hour = hour - 12;

                hour = hour + 12;
                ddlOFFHour.Items.FindByValue(hour.ToString()).Selected = true;
            }


            if (minute < 10)
            {
                ddlOFFMin.Items.FindByValue(timenow[1].Split(':')[1]).Selected = true;
            }
            else
            {
                ddlOFFMin.Items.FindByValue(timenow[1].Split(':')[1]).Selected = true;
            }
        }

        public void insertdata(string smsContent,string name, string mobileno )
        {
            smsContent = smsContent.Replace("{name}", name);
            SqlConnection conn = new SqlConnection(ConfigurationSettings.AppSettings["Str"].ToString());
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into t_SMS(smsContent ,mobileno) values ('"+ smsContent + "', '"+ mobileno + "')";
            cmd.Connection = conn;
           // cmd.ExecuteNonQuery();
            conn.Close();

        }

        public void insertAgent(string offroadid, string vehicleNo, string AgentID)
        {
            string ip = GetLocalIPAddress();
            SqlConnection conn = new SqlConnection(ConfigurationSettings.AppSettings["Str"].ToString());
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into t_offroadAgent(offroadid ,vehicleNo, AgentID,AgentName,ip) values ('" + offroadid + "', '" + vehicleNo + "', '" + AgentID + "', '"+Session["User_Name"].ToString() +"','"+ ip + "')";
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            conn.Close();

        }


        public void sendSms(string vehicleno, string breakdownid, string reason)
        {
            DataTable dtPenData = new DataTable();
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationSettings.AppSettings["Str"].ToString());
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from m_vehicle_supervisors where VehicleNo = '" + vehicleno + "'";
                cmd.Connection = conn;
                adp.Fill(dtPenData);
                conn.Close();
                if(dtPenData.Rows.Count > 0)
                {
                    string smsContent = "Dear {name},\nVehicleNumber-"+ vehicleno + " is made off road with reason-"+ reason + " and breakdownid-"+ breakdownid+" and base location:" + dtPenData.Rows[0]["BaseLocation"].ToString() + " by ERO:" + Session["User_Name"].ToString();

                 //   insertdata(smsContent, dtPenData.Rows[0]["Emename"].ToString(), dtPenData.Rows[0]["EmeContactNumber"].ToString());
                   // insertdata(smsContent, dtPenData.Rows[0]["Pmname"].ToString(), dtPenData.Rows[0]["PmContactNumber"].ToString());
                 //   insertdata(smsContent, dtPenData.Rows[0]["Rmname"].ToString(), dtPenData.Rows[0]["RmContactNumber"].ToString());
                }
            }
            catch (Exception ex)
            {
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            btnSubmit.Enabled = false;
	DateTime entrydate = DateTime.ParseExact(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedValue.ToString() + ":"+ ddlOFFMin.SelectedValue.ToString() , "MM/dd/yyyy HH:mm", CultureInfo.InvariantCulture);
            if(entrydate > System.DateTime.Now)
            {
                Show("Off road date should not be greater than current date ");
              // Show("Success");
		 return;
            }

            //Declarations
            string segmentids = "", segmentnames = "", mandalids = "";
            DataSet dsmandalsupd = new DataSet();

	

            try
            {
                StringBuilder objStringBuilder = new StringBuilder();
                objStringBuilder.Append("<NewDataSet>");
                objStringBuilder.Append("<TransDtls>");

                vehallobj.ContactNumber = txtContactNumber.Text;
                vehallobj.Comments = txtComment.Text;
                vehallobj.District = ddlDistrict.SelectedItem.Text;
                vehallobj.OffRoadDate = Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text);
                vehallobj.OffRoadVehicleNo = ddlVehicleNumber.SelectedItem.Text;
                vehallobj.ReasonForOffRoad = ddlreasons.SelectedItem.Text;
                vehallobj.RequestedBy = txtReqBy.Text;
                vehallobj.EMEID = txtEMEId.Text;
                vehallobj.PilotID = txtPilotId.Text;
                vehallobj.PilotName = txtPilotName.Text;
                vehallobj.Odometer = txtOdo.Text;
                vehallobj.ExpDateOfRecovery = Convert.ToDateTime(txtExpDateOfRec.Text + " " + ddlExpDateOfRecHr.SelectedItem.Text + ":" + ddlExpDateOfRecMin.SelectedItem.Text);
                vehallobj.SegmentId = 0;
                vehallobj.totEstimated = txtAllEstimatedCost.Text;


                if (ddlreasons.SelectedItem != null && ddlreasons.SelectedIndex == 4)
                {
                    for (int intCount = 0; intCount < grdvwBreakdownDetails.Rows.Count; intCount++)
                    {
                        objStringBuilder.Append("<BreakdownDetails>");
                        objStringBuilder.Append("<Aggregates>" + Convert.ToString(grdvwBreakdownDetails.Rows[intCount].Cells[1].Text) + "</Aggregates>");
                        objStringBuilder.Append("<Categories>" + Convert.ToString(grdvwBreakdownDetails.Rows[intCount].Cells[2].Text) + "</Categories>");
                        objStringBuilder.Append("<Subcategories>" + Convert.ToString(grdvwBreakdownDetails.Rows[intCount].Cells[3].Text) + "</Subcategories>");
                        objStringBuilder.Append("<EstimatedCost>" + Convert.ToString(grdvwBreakdownDetails.Rows[intCount].Cells[4].Text) + "</EstimatedCost>");
                        objStringBuilder.Append("</BreakdownDetails> ");
                    }
                }
                else
                {
                    objStringBuilder.Append("<BreakdownDetails>");
                    objStringBuilder.Append("<Aggregates></Aggregates>");
                    objStringBuilder.Append("<Categories></Categories>");
                    objStringBuilder.Append("<Subcategories></Subcategories>");
                    objStringBuilder.Append("<EstimatedCost>0</EstimatedCost>");
                    objStringBuilder.Append("</BreakdownDetails>");
                }

                objStringBuilder.Append("</TransDtls> ");
                objStringBuilder.Append("</NewDataSet>");

                vehallobj.BreakDownDetails = objStringBuilder.ToString();

                if (pnlothersegment.Visible == true && grdvothersegment.Visible == true)
                {
                    dsmandalsupd = (DataSet)Session["dsmandals"];
                    for (int j = 0; j < dsmandalsupd.Tables[0].Rows.Count; j++)
                    {
                        mandalids = mandalids + dsmandalsupd.Tables[0].Rows[j][0].ToString() + ",";
                        segmentids = segmentids + ((DropDownList)grdvothersegment.Rows[j].Controls[1].Controls[1]).SelectedValue.ToString() + ",";
                        segmentnames = segmentnames + ((DropDownList)grdvothersegment.Rows[j].Controls[1].Controls[1]).SelectedItem.Text.ToString() + ",";
                    }

                    vehallobj.SegmentIds = segmentids;
                    vehallobj.MandalIds = mandalids;
                    vehallobj.SegmentNames = segmentnames;
                    makeVehicleoffRoad(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text).ToString("yyyy-MM-dd HH:mm:ss"), ddlreasons.SelectedItem.Text, Session["User_Name"].ToString(), txtOdo.Text, txtReqBy.Text, txtPilotName.Text,txtPilotId.Text);

                    int insres = vehallobj.InsertOffRoadVehicleDetail();
                    if (insres != 0)
                    {
                        insertAgent(insres.ToString(), ddlVehicleNumber.SelectedItem.Text, Session["User_Id"].ToString());
                        sendSms(ddlVehicleNumber.SelectedItem.Text, insres.ToString(), ddlreasons.SelectedItem.Text);
                        Show("Record Inserted Successfully!! And BreakDown Id=" + insres.ToString());
                    }
                    else
                    {
                        Show("Record not Inserted Successfully!!");
                    }
                }
                else if (pnlothervehicle.Visible == true && grdvothervehicle.Visible == true)
                {
                    dsmandalsupd = (DataSet)Session["dsmandals"];
                    for (int j = 0; j < dsmandalsupd.Tables[0].Rows.Count; j++)
                    {
                        mandalids = mandalids + dsmandalsupd.Tables[0].Rows[j][0].ToString() + ",";
                        segmentids = segmentids + Convert.ToInt32(Session["segmentid"]).ToString() + ",";  //((DropDownList)grdvothervehicle.Rows[j].Controls[1].Controls[1]).SelectedValue.ToString() + ",";
                        segmentnames = segmentnames + lblSegmentName.Text.ToString() + ",";//((DropDownList)grdvothervehicle.Rows[j].Controls[1].Controls[1]).SelectedItem.Text.ToString() + ",";
                    }

                    vehallobj.SegmentIds = segmentids;
                    vehallobj.MandalIds = mandalids;
                    vehallobj.SegmentNames = segmentnames;
                    vehallobj.OtherVehicleNumber = ddlothervehicle.SelectedItem.Text;
                    //     vehallobj.OtherSegmentId = Convert.ToInt32(Session["othersegmentid"]);
                    //  makeVehicleoffRoad(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text), ddlreasons.SelectedItem.Text);
                    makeVehicleoffRoad(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text).ToString("yyyy-MM-dd HH:mm:ss"), ddlreasons.SelectedItem.Text, Session["User_Name"].ToString(), txtOdo.Text, txtReqBy.Text, txtPilotName.Text, txtPilotId.Text);

                    int insres = vehallobj.InsertOtherOffRoadVehicleDetail();
                    Session["offId"] = insres;
                    if (insres != 0)
                    {
                        insertAgent(insres.ToString(), ddlVehicleNumber.SelectedItem.Text, Session["User_Id"].ToString());
                        sendSms(ddlVehicleNumber.SelectedItem.Text, insres.ToString(), ddlreasons.SelectedItem.Text);

                        Show("Record Inserted Successfully!! And Breakdown Id=" + insres.ToString());
                    }
                    else
                    {
                        Show("Record not Inserted Successfully!!");
                    }
                }
                else
                {
                    mandalids = ""; segmentids = ""; segmentnames = "";

                    vehallobj.SegmentIds = segmentids;
                    vehallobj.MandalIds = mandalids;
                    vehallobj.SegmentNames = segmentnames;

                  //  makeVehicleoffRoad(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text), ddlreasons.SelectedItem.Text);
                    makeVehicleoffRoad(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text).ToString("yyyy-MM-dd HH:mm:ss"), ddlreasons.SelectedItem.Text, Session["User_Name"].ToString(), txtOdo.Text, txtReqBy.Text, txtPilotName.Text, txtPilotId.Text);


                    int insres = vehallobj.InsertOffRoadVehicleDetail();
                    Session["offId"] = insres;
                    if (insres != 0)
                    {
                        insertAgent(insres.ToString(), ddlVehicleNumber.SelectedItem.Text, Session["User_Id"].ToString());
                        sendSms(ddlVehicleNumber.SelectedItem.Text, insres.ToString(), ddlreasons.SelectedItem.Text);
                        Show("Record Inserted Successfully!!And Breakdown Id=" + insres.ToString());
                    }
                    else
                    {
                        Show("Record not Inserted Successfully!!");
                    }
                }
              //  int i = Convert.ToInt32(ddlreasons.SelectedItem.Value.ToString());
              //  DataTable dtisPenalityUpdate = new DataTable();
              //  dtisPenalityUpdate = getPenalityData(i);
               // if (dtisPenalityUpdate.Rows.Count > 0)
               // {
                    // string isPenalityUpdate = dtisPenalityUpdate.Rows[0]["isPenalityUpdate"].ToString();
                   // if(isPenalityUpdate == "True")
                   // { 
                   //     if(Session["offId"] == null)
                   //     {
                    //        Session["offId"] = 0;
                     //   }
                      //     updateScheduledPanality(ddlVehicleNumber.SelectedItem.Text, Convert.ToDateTime(txtOfftimeDate.Text + " " + ddlOFFHour.SelectedItem.Text + ":" + ddlOFFMin.SelectedItem.Text).ToString("yyyy-MM-dd HH:mm:ss"), ddlreasons.SelectedItem.Value.ToString(), txtOdo.Text, Session["offId"].ToString());
                  //  }
              //  }
                ClearControls();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string GetLocalIPAddress()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            throw new Exception("Local IP Address Not Found!");
        }

        private void updateScheduledPanality(string VehicleNumber, string OfftimeDate, string reason,string odoReading, string offId)
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationSettings.AppSettings["Str"].ToString());
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "P_Update_Penality_RFP_new";
                cmd.Parameters.AddWithValue("@VechicleNo", VehicleNumber);
                cmd.Parameters.AddWithValue("@OfftimeDate", OfftimeDate);
                cmd.Parameters.AddWithValue("@reason", reason);
                cmd.Parameters.AddWithValue("@odoReading", odoReading);
                cmd.Parameters.AddWithValue("@offId", offId);
                // cmd.Parameters.AddWithValue("@offtype", offtype);
                cmd.Connection = conn;
                DataSet ds = new DataSet();
                adp.Fill(ds);
                conn.Close();

            }
            catch (Exception ex)
            {
                //Do Log
            }
            
            //return i;


        }

        private DataTable getPenalityData(int i)
        {
            DataTable dtPenData = new DataTable();
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationSettings.AppSettings["Str"].ToString());
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from [M_FMS_MaintenanceType] where [Maint_Type_ID] = " + i;
                cmd.Connection = conn;
                adp.Fill(dtPenData);
                conn.Close();
            }
            catch (Exception ex)
            {
            }
            return dtPenData;
        }

        private int makeVehicleoffRoad(string VehicleNumber, string offroaddate, string offroadtype, string Status_change_by, string odo_meter, string informer_name, string piliot_name, string piliot_gid)
        {
            int i = 0;
            try
            {
                MySqlConnection conn = new MySqlConnection(ConfigurationSettings.AppSettings["MySqlConn"].ToString());
                conn.Open();
                MySqlCommand cmd = new MySqlCommand();
                MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "UpdateVehicleStatus";
             //piliot_gid VARCHAR(10)
                cmd.Parameters.AddWithValue("VehicleNumber", VehicleNumber);
                cmd.Parameters.AddWithValue("offroaddate", offroaddate);
                cmd.Parameters.AddWithValue("offroadtype", offroadtype);
                cmd.Parameters.AddWithValue("Status_change_by", Status_change_by);
                cmd.Parameters.AddWithValue("odo_meter", odo_meter);
                cmd.Parameters.AddWithValue("informer_name", informer_name);
                cmd.Parameters.AddWithValue("piliot_name", piliot_name);
                cmd.Parameters.AddWithValue("piliot_gid", piliot_gid);


                cmd.Connection = conn;
                DataSet ds = new DataSet();
                adp.Fill(ds);
                conn.Close();

            }
            catch (Exception ex)
            {
                //Do Log
            }
            return i;
        }


        public void GetDistrict()
        {
            ddlDistrict.DataSource = fmsobj.GetDistricts_new();
            ddlDistrict.DataTextField = "district_name";
            ddlDistrict.DataValueField = "district_id";
            ddlDistrict.DataBind();
            ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));

        }


        public void Show(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
        }

        public void ClearControls()
        {
            //txtOfftimeDate.Text = "";
            txtContactNumber.Text = "";
            ddlDistrict.SelectedIndex = 0;
            ddlVehicleNumber.SelectedIndex = 0;
            ddlreasons.SelectedIndex = 0;
            txtReqBy.Text = "";
            txtEMEId.Text = "";
            txtPilotId.Text = "";
            txtPilotName.Text = "";
            txtOdo.Text = "";
            txtComment.Text = "";
            txtExpDateOfRec.Text = "";
            txtAllEstimatedCost.Text = "";
            if (ddlreasons.SelectedValue == "BREAKDOWN")
            {
                ddlAggregates.SelectedIndex = 0;
                ddlCategories.SelectedIndex = 0;
                ddlSubCategories.SelectedIndex = 0;
            }

            ddlExpDateOfRecHr.SelectedIndex = 0;
            ddlExpDateOfRecMin.SelectedIndex = 0;
            pnlRadioBtnList.Visible = false;
            pnlothersegment.Visible = false;
            pnlothervehicle.Visible = false;
            lblmsg.Visible = false;
            lblSegment.Visible = false;
            lblSegmentName.Visible = false;
            divAggre.Visible = false;
            Session["segmentid"] = ""; Session["locationid"] = "";
            Session["dsmandals"] = ""; Session["dsvehilce"] = ""; Session["dssegment"] = "";
            grdvwBreakdownDetails.DataSource = null;
            grdvwBreakdownDetails.DataBind();
            btnSubmit.Enabled = true;

        }

        private void FillHoursandMins()
        {
            int i;
            for (i = 0; i < 24; i++)
            {
                if (i < 10)
                {
                    this.ddlOFFHour.Items.Add(new ListItem("0" + i.ToString(), "0" + i.ToString()));
                    this.ddlExpDateOfRecHr.Items.Add(new ListItem("0" + i.ToString(), "0" + i.ToString()));
                }
                else
                {
                    this.ddlOFFHour.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    this.ddlExpDateOfRecHr.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }
            for (i = 0; i < 60; i++)
            {
                if (i < 10)
                {
                    this.ddlOFFMin.Items.Add(new ListItem("0" + i.ToString(), "0" + i.ToString()));
                    this.ddlExpDateOfRecMin.Items.Add(new ListItem("0" + i.ToString(), "0" + i.ToString()));
                }
                else
                {
                    this.ddlOFFMin.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    this.ddlExpDateOfRecMin.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }

        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDistrict.SelectedIndex != 0)
            {
                //ddlVehicleNumber.SelectedIndex = 0;
                //ddlVehicleNumber_SelectedIndexChanged(this, null);
                DataSet ds = new DataSet();
                vehallobj.DistrictId = int.Parse(ddlDistrict.SelectedItem.Value);
                ds = vehallobj.GetActiveVehiclesForOffRoad_new(); //objInventory.FillVehiclesWithDistrictID(int.Parse(ddlDistrict.SelectedItem.Value));
                ddlVehicleNumber.DataSource = ds;
                ddlVehicleNumber.DataValueField = "Vehicle";
                ddlVehicleNumber.DataTextField = "VehicleNumber";
                ddlVehicleNumber.DataBind();
                ddlVehicleNumber.Items.Insert(0, "Select");
                ddlVehicleNumber.Items[0].Value = "0";
                ddlVehicleNumber.SelectedIndex = 0;

                Session["dsvehilce"] = ds;
                lblSegmentName.Text = "";
                txtContactNumber.Text = "";
                ddlreasons.SelectedIndex = 0;
                ddlreasons_SelectedIndexChanged(this, null);
                grdvwBreakdownDetails.DataSource = null;
                grdvwBreakdownDetails.DataBind();

            }
            else
            {
                ddlVehicleNumber.SelectedIndex = 0;
                ddlVehicleNumber_SelectedIndexChanged(this, null);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearControls();
        }

        protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlVehicleNumber.SelectedIndex != 0)
            {
                ddlreasons.SelectedIndex = 0;
                ddlreasons_SelectedIndexChanged(this, null);
                txtContactNumber.Text = "";

                DataSet ds = objInventory.GetVehicleContactNumber(ddlVehicleNumber.SelectedItem.Text,
                                                               ConfigurationSettings.AppSettings["StrCTIAPPS"].ToString());

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    txtContactNumber.Text = dr["vi_VehicleContact"].ToString();
                }
                foreach (DataRow dr in ds.Tables[1].Rows)
                {
                    txtOdo.Text = dr["Odometer"].ToString();
                }

                //vehallobj.VehicleNumber =ddlVehicleNumber.SelectedItem.Text;

            }
            else
            {
                ddlreasons.SelectedIndex = 0;
                ddlreasons_SelectedIndexChanged(this, null);
            }

            lblmsg.Visible = false;

            DataSet dsvehiclev = new DataSet();
            dsvehiclev = (DataSet)Session["dsvehilce"];
            if (ddlVehicleNumber.SelectedIndex != 0)
            {

                //DataView dv = new DataView(dsvehiclev.Tables[0], "Vehicle ='" + ddlVehicleNumber.SelectedValue.ToString() + "'", "VehicleNumber", DataViewRowState.CurrentRows);
                //lblSegmentName.Text = dv[0][5].ToString();
                //lblSegmentName.Visible = true;
                //lblSegment.Visible = true;

                //Session["segmentid"] = Convert.ToInt32(dv[0][3]);

                //Session["locationid"] = Convert.ToInt32(dv[0][4]);

                //txtprevbaselocation.Text = Convert.ToString(dv[0][5]);
                //txtprevcontactno.Text = Convert.ToString(dv[0][6]);
            }
            //DataSet dssegmentv = new DataSet();
            //vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            //dssegmentv = vehallobj.GetSegments(); //GetSegments(Convert.ToInt16(DDLDistricts.SelectedValue));
            //Session["dssegment"] = dssegmentv;
            //DataView dvseg = new DataView(dssegmentv.Tables[0], "Sg_Segid <>" + Convert.ToInt32(Session["segmentid"]) + "", "Sg_SName", DataViewRowState.CurrentRows);
            //if (dvseg.Count > 0)
            //{
            //    DataSet ds = new DataSet();
            //    vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            //    vehallobj.SegmentId = Convert.ToInt32(Session["segmentid"]);
            //    ds = vehallobj.GetMandals();
            //    // mandalscount = ds.Tables[0].Rows.Count;

            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        pnlRadioBtnList.Visible = true;
            //        rdbtnlstOption.SelectedValue = "rdbothersegment";
            //        //rdbothervehicle.Checked = false;
            //        pnlothersegment.Visible = true;
            //        grdvothersegment.DataSource = ds.Tables[0];
            //        grdvothersegment.DataBind();
            //        //dsmandals = ds;
            //        Session["dsmandals"] = ds;
            //    }
            //    else
            //        pnlothersegment.Visible = false;


            //}
            
        }

        protected void rdbtnlstOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdbtnlstOption.SelectedValue == "rdbothersegment")
            {
                pnlothersegment.Visible = true;
                pnlothervehicle.Visible = false;
            }
            else
            {
                if (ddlothervehicle.Items.Count > 0)
                    ddlothervehicle.Items.Clear();

                DataSet dsvehicler = new DataSet();
                dsvehicler = (DataSet)Session["dsvehilce"];
                DataView dv = new DataView(dsvehicler.Tables[0], "Vehicle <>'" + ddlVehicleNumber.SelectedValue.ToString() + "'", "Sg_SName", DataViewRowState.CurrentRows);

                ddlothervehicle.DataSource = dv;
                ddlothervehicle.DataTextField = "VehicleNumber";
                ddlothervehicle.DataValueField = "Vehicle";
                ddlothervehicle.DataBind();
                ddlothervehicle.Items.Insert(0, "--Select--");
                //txtothervsegment.Text = "";
                txtotherbaselocation.Text = "";
                txtothercontactno.Text = "";
                lblOtherVehSegment.Visible = false;
                lblOtherVehSegmentName.Visible = false;
                rdbtnlstOption.SelectedValue = "rdbothervehicle";
                //rdbothersegment.Checked = false;
                grdvothervehicle.Visible = false;

                pnlothervehicle.Visible = true;
                pnlothersegment.Visible = false;
            }

        }

        protected void grdvothersegment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            DataSet dssegmentgot = new DataSet();
            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            dssegmentgot = vehallobj.GetMappedSegments(); //(DataSet)Session["dssegment"];
            DataView dv = new DataView(dssegmentgot.Tables[0], "Sg_Segid <>" + Convert.ToInt32(Session["segmentid"]), "Sg_SName", DataViewRowState.CurrentRows);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");
                ddl.DataSource = dv;
                ddl.DataTextField = "Sg_SName";
                ddl.DataValueField = "Sg_Segid";
                ddl.DataBind();
                //ddl.Items.Insert(0, "Select");
            }
        }

        protected void grdvothervehicle_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            DataSet dsvehiclevgvo = new DataSet();
            dsvehiclevgvo = (DataSet)Session["dsvehilce"];

            DataSet dssegmentgvo = new DataSet();
            dssegmentgvo = (DataSet)Session["dssegment"];
            DataView dv1 = new DataView(dsvehiclevgvo.Tables[0], "Vehicle ='" + ddlothervehicle.SelectedValue.ToString() + "'", "Sg_SName", DataViewRowState.CurrentRows);
            //othersegmentid = Convert.ToInt32(dv1[0][3]);
            Session["othersegmentid"] = Convert.ToInt32(dv1[0][3]);
            DataView dv = new DataView(dssegmentgvo.Tables[0], "Sg_Segid <>" + Convert.ToInt32(Session["othersegmentid"]), "Sg_SName", DataViewRowState.CurrentRows);
            //othermandalscount = dv.Table.Rows.Count;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList2");
                ddl.DataSource = dv;
                ddl.DataTextField = "Sg_SName";
                ddl.DataValueField = "Sg_Segid";
                ddl.DataBind();
                //ddl.Items.Insert(0, "Select");
            }
        }

        protected void ddlothervehicle_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet dsvehiclevov = new DataSet();
            dsvehiclevov = (DataSet)Session["dsvehilce"];

            DataView dv = new DataView(dsvehiclevov.Tables[0], "Vehicle ='" + ddlothervehicle.SelectedValue.ToString() + "'", "Sg_SName", DataViewRowState.CurrentRows);
            //othersegmentid = Convert.ToInt32(dv[0][3]); 
            Session["othersegmentid"] = Convert.ToInt32(dv[0][3]);
            // txtothervsegment.Text=dv[0][2].ToString();
            lblOtherVehSegmentName.Text = dv[0][2].ToString();
            lblOtherVehSegmentName.Visible = true;
            lblOtherVehSegment.Visible = true;
            txtotherbaselocation.Text = Convert.ToString(dv[0][5]);
            txtothercontactno.Text = Convert.ToString(dv[0][6]);
            //locationid = Convert.ToInt32(dv[0][4]);
            Session["locationid"] = Convert.ToInt32(dv[0][4]);
            DataSet ds = new DataSet();

            vehallobj.DistrictId = Convert.ToInt32(ddlDistrict.SelectedItem.Value);
            vehallobj.SegmentId = Convert.ToInt32(Session["othersegmentid"]);
            ds = vehallobj.GetMandals();
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlothervehicle.Visible = true;
                grdvothervehicle.Visible = true;
                grdvothervehicle.DataSource = ds.Tables[0];
                grdvothervehicle.DataBind();
                //dsmandals = ds;
                Session["dsmandals"] = ds;
            }
            else
                //pnlothervehicle.Visible = false;
                grdvothervehicle.Visible = false;
            DataView dvvehicleos = new DataView(dsvehiclevov.Tables[0], "SegmentId ='" + Convert.ToInt32(Session["othersegmentid"]) + "'", "Sg_SName", DataViewRowState.CurrentRows);
            if (dvvehicleos.Count > 1)
            {
                grdvothervehicle.Visible = false;
            }
        }
        public void getAggregates()
        {
            vehallobj.Aggregates = ddlAggregates.SelectedValue;
            DataSet ds = new DataSet();
            vehallobj.VehicleNumber = ddlVehicleNumber.SelectedItem.Text;
            ds = vehallobj.GetAggregatesOffRoad();
            ddlAggregates.DataSource = ds.Tables[0];
            ddlAggregates.DataValueField = "Aggregate_Id";
            ddlAggregates.DataTextField = "Aggregates";
            ddlAggregates.DataBind();

        }
        protected void ddlreasons_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlreasons.SelectedIndex == 4)
            {
                txtAllEstimatedCost.Enabled = false;
                divAggre.Visible = true;
                ddlCategories.Enabled = false;
                ddlSubCategories.Enabled = false;
                getAggregates();
            }
            else
            {
                txtAllEstimatedCost.Text = "";
                txtAllEstimatedCost.Enabled = true;
                divAggre.Visible = false;
                grdvwBreakdownDetails.DataSource = null;
                grdvwBreakdownDetails.DataBind();
                dtBreakdown = null;
            }

        }
        public void getCategories()
        {
            vehallobj.Aggregates2 = Convert.ToInt16(ddlAggregates.SelectedValue);
            vehallobj.VehicleNumber = ddlVehicleNumber.SelectedItem.Text;
            DataSet ds = new DataSet();
            ds = vehallobj.GetCategories();
            ddlCategories.DataSource = ds.Tables[0];
            ddlCategories.DataValueField = "Category_Id";
            ddlCategories.DataTextField = "Categories";
            ddlCategories.DataBind();
        }
        protected void ddlAggregates_SelectedIndexChanged(object sender, EventArgs e)
        {

            txtEstCost.Text = "";
            if (ddlAggregates.SelectedIndex != 0)
            {
                getCategories();
                ddlCategories.Enabled = true;
                ddlSubCategories.Enabled = false;
            }
            else
            {
                ddlCategories.SelectedIndex = 0;
                ddlSubCategories.SelectedIndex = 0;
                ddlCategories.Enabled = false;
            }
        }
        public void getSubCategories()
        {
            vehallobj.Categories2 = Convert.ToInt16(ddlCategories.SelectedValue);
            DataSet ds = new DataSet();
            ds = vehallobj.GetSubcategories();
            ddlSubCategories.DataSource = ds.Tables[0];
            ddlSubCategories.DataValueField = "SubCategory_Id";
            ddlSubCategories.DataTextField = "SubCategories";
            ddlSubCategories.DataBind();
        }
        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlSubCategories.SelectedIndex = 0;
            txtEstCost.Text = "";
            if (ddlCategories.SelectedIndex != 0)
            {
                ddlSubCategories.Enabled = true;
                getSubCategories();
            }

            else
            {

                ddlSubCategories.SelectedIndex = 0;
                ddlSubCategories.Enabled = false;
            }
        }

        protected void ddlSubCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtEstCost.Text = "";
            if (ddlSubCategories.SelectedIndex != 0)
            {
                vehallobj.SubCategories2 = Convert.ToInt16(ddlSubCategories.SelectedValue);
                string text = vehallobj.GetEstCost();
                txtEstCost.Text = text;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            double sum = 0;
            string aggregates, categories, subcategories, estimatedCost;
            aggregates = ddlAggregates.SelectedItem.ToString();
            categories = ddlCategories.SelectedItem.ToString();
            subcategories = ddlSubCategories.SelectedItem.ToString();
            estimatedCost = txtEstCost.Text;
            if (ViewState["dtBreakdown"] != null)
                dtBreakdown = (DataTable)ViewState["dtBreakdown"];
            if (dtBreakdown == null || dtBreakdown.Columns.Count == 0)
            {
                dtBreakdown.Columns.Add("Aggregates", typeof(string));
                dtBreakdown.Columns.Add("Categories", typeof(string));
                dtBreakdown.Columns.Add("Subcategories", typeof(string));
                dtBreakdown.Columns.Add("EstimatedCost", typeof(string));

            }

            dtBreakdown.Rows.Add(aggregates, categories, subcategories, estimatedCost);
            ViewState["dtBreakdown"] = dtBreakdown;
            grdvwBreakdownDetails.DataSource = dtBreakdown;
            grdvwBreakdownDetails.DataBind();
            foreach (GridViewRow item in grdvwBreakdownDetails.Rows)
            {
                //if (item.RowIndex!=0)
                //{
                sum = Convert.ToDouble(item.Cells[4].Text) + sum;
                //}
            }
            txtAllEstimatedCost.Text = sum.ToString();
            ddlAggregates.SelectedIndex = 0;
            ddlCategories.SelectedIndex = 0;
            ddlSubCategories.SelectedIndex = 0;
            txtEstCost.Text = "";
            ddlCategories.Enabled = false;
            ddlSubCategories.Enabled = false;
        }


        protected void grdvwBreakdownDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            double sum = Convert.ToDouble(txtAllEstimatedCost.Text);
            int index = Convert.ToInt32(e.RowIndex);
            DataTable dt = ViewState["dtBreakdown"] as DataTable;
            sum = sum - Convert.ToDouble(dt.Rows[index][3].ToString());
            dt.Rows[index].Delete();
            ViewState["dt"] = dt;
            txtAllEstimatedCost.Text = sum.ToString();
            BindGrid();
        }
        protected void BindGrid()
        {
            grdvwBreakdownDetails.DataSource = ViewState["dt"] as DataTable;
            grdvwBreakdownDetails.DataBind();
        }
    }
}