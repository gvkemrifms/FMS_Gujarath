using GvkFMSAPP.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace GvkFMSAPP.PL
{
    public partial class FuelEntry : System.Web.UI.Page
    {
        public IFuelManagement objFuelEntry = new FuelManagement();
        double kmplInt = 0;
        double MSkmplInt = 0;
        bool flag = false;
        string bunkname;
        GvkFMSAPP.BLL.FMSGeneral fmsg = new GvkFMSAPP.BLL.FMSGeneral();
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

            if (Session["User_Name"] == null)
            {
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {

                if (Session["UserdistrictId"] != null)
                {
                    fmsg.UserDistrictId = Convert.ToInt32(Session["UserdistrictId"].ToString());
                }

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
                //txtBunkName.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");

                txtLocation.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
                txtOdometer.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
                //txtQuantity.Attributes.Add("onkeypress", "javascript:return isNumberKey(this,event)");
                //txtUnitPrice.Attributes.Add("onkeypress", "javascript:return isDecimalNumberKey(event)");
                txtLocation.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
                txtPilotID.Attributes.Add("onkeypress", "javascript:return isNumberKey(event)");
                txtPilotName.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");

                DataSet dsPerms = (DataSet)Session["PermissionsDS"];
                dsPerms.Tables[0].DefaultView.RowFilter = "Url='" + Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1] + "'";
                PagePermissions p = new PagePermissions(dsPerms, dsPerms.Tables[0].DefaultView[0]["Url"].ToString(), dsPerms.Tables[0].DefaultView[0]["Title"].ToString());

                if (p.Add == true)
                {

                }
                if (p.Modify == true)
                {
                }
                if (p.View == true)
                {
                }
                if (p.Approve == true)
                {
                }

            }
        }

        private void FillDistricts()
        {
            int districtID = -1;

            if (Session["UserdistrictId"] != null)
            {
                districtID = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }
            DataSet ds = new DataSet();
            ds = objFuelEntry.IFillVehiclesWithMappedCards(districtID);
            ddlDistrict.DataSource = ds.Tables[0];
            ddlDistrict.DataValueField = "VehicleID";
            ddlDistrict.DataTextField = "VehicleNumber";
            ddlDistrict.DataBind();
            ddlDistrict.Items.Insert(0, "--Select--");
            ddlDistrict.Items[0].Value = "0";
            ddlDistrict.SelectedIndex = 0;

            ListItem itemToRemove = ddlDistrict.Items.FindByValue(ddlVehicleNumber.SelectedValue.ToString());
            if (itemToRemove != null)
            {
                ddlDistrict.Items.Remove(itemToRemove);
            }
            else
            {

            }


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
            int districtID = -1;

            if (Session["UserdistrictId"] != null)
            {
                districtID = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }
            DataSet ds = fmsg.GetVehicleNumber();
            //ds = objFuelEntry.IFillVehicles(districtID);
            ddlVehicleNumber.DataSource = ds.Tables[0];
            ddlVehicleNumber.DataValueField = "VehicleID";
            ddlVehicleNumber.DataTextField = "VehicleNumber";
            ddlVehicleNumber.DataBind();
            ddlVehicleNumber.Items.Insert(0, "--Select--");
            ddlVehicleNumber.Items[0].Value = "0";
            ddlVehicleNumber.SelectedIndex = 0;
            ddlVehicleNumber.Enabled = true;

        }


        private void FillDistrictLocation()
        {
            fmsg.vehicle = (ddlVehicleNumber.SelectedItem.ToString());
            DataSet dsDistrict = fmsg.GetDistrictLoc();
            lblDistrict.Text = dsDistrict.Tables[0].Rows[0]["District"].ToString();
            lblLocation.Text = dsDistrict.Tables[0].Rows[0]["BaseLocation"].ToString();

        }

        private void FillServiceStn()
        {
            fmsg.ServiceStn = lblDistrict.Text;
            DataSet dsServiceStn = fmsg.GetServiceStns();
            ddlBunkName.DataSource = dsServiceStn.Tables[0];
            ddlBunkName.DataValueField = "Id";
            ddlBunkName.DataTextField = "ServiceStnName";
            ddlBunkName.DataBind();
            ddlBunkName.Items.Insert(0, "--Select--");
            ddlBunkName.Items[0].Value = "0";
            ddlBunkName.SelectedIndex = 0;

            ddlBunkName.Enabled = true;
        }

        private void FillServiceStnVeh()
        {
            fmsg.ServiceStnVeh = Convert.ToInt32(ddlVehicleNumber.SelectedValue);
            DataSet dsServiceStn = fmsg.GetServiceStnsVeh();
            if (dsServiceStn.Tables[0].Rows.Count != 0)
            {
                txtBunkName.Text = Convert.ToString(dsServiceStn.Tables[0].Rows[0][1]);
            }
            else
            {
                txtBunkName.Enabled = true;
            }

        }



        protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillCardNumber(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            //FillGridLastFiveTransactions(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            FillGridFuelEntry(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            ViewState["VehicleID"] = ddlVehicleNumber.SelectedValue;

            ddlPetroCardNumber.Enabled = false;


            DataSet dsOdo = new DataSet();
            dsOdo = objFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            if (dsOdo.Tables[0].Rows.Count != 0)
            {
                if (dsOdo.Tables[0].Rows[0]["ODO"].ToString() != string.Empty)
                {
                    maxOdo.Value = dsOdo.Tables[0].Rows[0]["ODO"].ToString();
                }
                else
                {
                    maxOdo.Value = "0";
                }
            }
            else
            {
                maxOdo.Value = "0";
            }
            FillDistricts();
            FillDistrictLocation();
            FillServiceStnVeh();
        }





        //private void FillSegmentandBaseLocation(int VehicleID)
        //{
        //    DataSet ds = new DataSet();
        //    ds = objFuelEntry.IFillSegmentandBaseLocation(VehicleID);
        //    txtSegmentID.Text = ds.Tables[0].Rows[0][0].ToString();
        //    txtSegment.Text = ds.Tables[0].Rows[0][1].ToString();
        //    txtBaseLocation.Text = ds.Tables[0].Rows[0][2].ToString();
        //    txtSegment.DataBind();
        //    txtBaseLocation.DataBind();


        //}




        private void FillPayMode()
        {
            DataSet ds = new DataSet();
            ds = objFuelEntry.IFillPayMode();
            ddlPaymode.DataSource = ds.Tables[0];
            ddlPaymode.DataValueField = "PayModeID";
            ddlPaymode.DataTextField = "PayMode";
            ddlPaymode.DataBind();
            ddlPaymode.Items.Insert(0, "--Select--");
            ddlPaymode.Items[0].Value = "0";
            ddlPaymode.SelectedIndex = 0;

            ddlPaymode.Enabled = true;
        }




        protected void ddlPaymode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPaymode.SelectedValue == "1")
            {

                ddlPetroCardNumber.Enabled = true;
                ddlCardSwiped.Enabled = true;

            }

            else
            {
                ddlPetroCardNumber.Enabled = false;
                ddlAgency.Enabled = false;
                ddlCardSwiped.SelectedIndex = 1;
                ddlCardSwiped.Enabled = false;
            }
        }




        private void FillCardNumber(int VehicleID)
        {
            DataSet ds = new DataSet();
            ds = objFuelEntry.IFillCardNumber(VehicleID);
            if (ds.Tables[0].Rows.Count == 0)
            {
                string strFmsScript = "No cards mapped to this Vehicle";
                Show(strFmsScript);
                ddlPaymode.SelectedIndex = 2;
                ddlPaymode.Enabled = false;
                ddlCardSwiped.SelectedIndex = 1;
                ddlCardSwiped.Enabled = false;
                ddlPetroCardNumber.SelectedIndex = -1;

            }
            else
            {
                ddlPetroCardNumber.DataSource = ds.Tables[0];
                ddlPetroCardNumber.DataValueField = "PetroCardIssueID";
                ddlPetroCardNumber.DataTextField = "PetroCardNum";
                ddlPetroCardNumber.DataBind();
                ddlPetroCardNumber.Items.Insert(0, "--Select--");
                //ddlPetroCardNumber.Items[0].Value = "0";
                //ddlPetroCardNumber.SelectedIndex = 0;
                if (ds.Tables[0].Rows.Count > 0)
                {
                //    ddlPetroCardNumber.SelectedIndex = 1;
                 //   ddlPaymode.SelectedIndex = 1;
                 //   FillFuelAgency(Convert.ToInt32(ddlPetroCardNumber.SelectedValue));
                 //   ddlCardSwiped.SelectedIndex = 2;
                }
                ddlPaymode.Enabled = true;
            }
        }




        protected void ddlPetroCardNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillFuelAgency(Convert.ToInt32(ddlPetroCardNumber.SelectedValue));
        }

        private void FillFuelAgency(int PetroCardIssueID)
        {
            DataSet ds = new DataSet();
            ds = objFuelEntry.IFillFuelAgency(PetroCardIssueID);
            ddlAgency.DataSource = ds.Tables[0];
            ddlAgency.DataValueField = "AgencyID";
            ddlAgency.DataTextField = "AgencyName";
            ddlAgency.DataBind();
            ddlAgency.Items.Insert(0, "--Select--");
            if (ds.Tables[0].Rows.Count > 0)
            {
             //   ddlAgency.SelectedIndex = 1;
             //   ddlCardSwiped.SelectedIndex = 2;
            }
            ddlAgency.Enabled = true;
        }

        protected void Save_Click(object sender, EventArgs e)
        {
             DataSet dsOdo = new DataSet();
            dsOdo = objFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            if (dsOdo.Tables[0].Rows.Count != 0)
            {
                if (dsOdo.Tables[0].Rows[0]["ODO"].ToString() != string.Empty)
                {
                    maxOdo.Value = dsOdo.Tables[0].Rows[0]["ODO"].ToString();
                    ViewState["maxodometer"] = dsOdo.Tables[0].Rows[0]["ODO"].ToString();
                }
                else
                {
                    maxOdo.Value = "0";
                }
            }
            else
            {
                maxOdo.Value = "0";
            }
 // Show(txtFuelEntryDate.Text);
 DateTime entrydate = DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            
            if(entrydate > System.DateTime.Now)
            {
                Show("Fuel entry date should not be greater than current date ");
                return;
            }

            Save.Enabled = false;
            GvkFMSAPP.BLL.FMSGeneral fmsGeneral = new GvkFMSAPP.BLL.FMSGeneral();

            DataSet ds = fmsGeneral.GetRegistrationDate(int.Parse(ddlVehicleNumber.SelectedItem.Value));
            Save.Enabled = true;
            if (ds.Tables[0].Rows.Count == 0)
            {
                Show("Fuel Entry cannot be done as vehicle is not yet Registered");
            }
            else
            {
                if (txtOdometer.Text.Trim() != string.Empty)
                {
                    if (Convert.ToInt32(ViewState["maxodometer"].ToString()) != 0)
                    {
                        int maxno = Convert.ToInt32(ViewState["maxodometer"].ToString()) + 1000;
                        if (maxno <= Convert.ToInt32(txtOdometer.Text) || Convert.ToInt32(txtOdometer.Text) <= Convert.ToInt32(ViewState["maxodometer"].ToString()))
                        {

                            Show("Odo value between  " + ViewState["maxodometer"].ToString() + " And " + maxno);
                            txtOdometer.Text = "";
                            txtOdometer.Focus();
                            return;
                        }
                        else
                        {
                            // Show(ViewState["maxodometer"].ToString());
                        }
                    }


                }
                else
                {
                    Show("Enter Odo value");
                    return;
                }
                // Show(ds.Tables[0].Rows[0]["RegDate"].ToString());
                DateTime dtofRegistration = DateTime.ParseExact(ds.Tables[0].Rows[0]["RegDate"].ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture);
                DateTime.Now.ToString();
                DateTime FuelEntry = DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
if(dtofRegistration > FuelEntry)
                {
                    Show("Fuel entry date should be greater than date of registration ");
                    return;
                }

 DataTable dtpreviousentryDate = new DataTable();

            dtpreviousentryDate = getpreviousODO(int.Parse(ddlVehicleNumber.SelectedItem.Value));
            if(dtpreviousentryDate != null )
            {
               if (dtpreviousentryDate.Rows.Count > 0)
                {
                    if (dtpreviousentryDate.Rows[0]["maxentry"].ToString() != "")
                    {
                        DateTime dtprvrefill = Convert.ToDateTime(dtpreviousentryDate.Rows[0]["maxentry"].ToString());
                        if (dtprvrefill > DateTime.ParseExact(txtFuelEntryDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture))
                        {
                            Show("Fuel entry date must be greater than previous fuel entry date");
                            return;
                        }
                    }
                }
            }
                //Shiva end
                Save.Enabled = false;
                if (Save.Text == "Save" && ddlPetroCardNumber.Enabled == true)
                {
                    if (ddlBunkName.Visible == true)
                    {

                        bunkname = ddlBunkName.SelectedItem.Text;
                    }
                    else
                    {
                        bunkname = txtBunkName.Text;
                    }
                    // int distid = Convert.ToInt32(Session["UserdistrictId"].ToString());
                    // int ddlVehicleNumberz = Convert.ToInt32(ddlVehicleNumber.SelectedValue);
                    //  int ddlDistrictz = Convert.ToInt32(ddlDistrict.SelectedValue);
                    //  DateTime txtFuelEntryDatez = Convert.ToDateTime(txtFuelEntryDate.Text);
                    //  Int64 txtBillNumberz = Convert.ToInt64(txtBillNumber.Text);
                    //  Int64 txtOdometerz = Convert.ToInt64(txtOdometer.Text);
                    // string bunknamez = bunkname;
                    // int ddlPaymodez = Convert.ToInt32(ddlPaymode.SelectedValue);
                    // decimal txtQuantityz = Convert.ToDecimal(txtQuantity.Text);
                    // Int64 ddlPetroCardNumberz = Convert.ToInt64(ddlPetroCardNumber.SelectedValue);
                    // decimal txtUnitPricez = Convert.ToDecimal(txtUnitPrice.Text);
                    // int ddlAgencyz = Convert.ToInt32(ddlAgency.SelectedValue);
                    // string txtLocationz = Convert.ToString(txtLocation.Text);
                    // int User_Idz = Convert.ToInt32(Session["User_Id"].ToString());
                    //  decimal txtAmountz = Convert.ToDecimal(txtAmount.Text);
                    // int txtPilotIDz = Convert.ToInt32(txtPilotID.Text);
                    // string txtPilotNamez = Convert.ToString(txtPilotName.Text);
                    // int ddlCardSwipedz = Convert.ToInt32(ddlCardSwiped.SelectedValue);
                    // string txtRemarksz = Convert.ToString(txtRemarks.Text);

                    InsFuelEntry(Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), Convert.ToInt32(ddlDistrict.SelectedValue), FuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToInt64(ddlPetroCardNumber.SelectedValue), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToString(txtLocation.Text), Convert.ToInt32(Session["User_Id"].ToString()), DateTime.Now, 1, Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                    // Convert.ToInt32(txtSegmentID.Text), Convert.ToString(txtBaseLocation.Text),
                    //ShowKMPL();
                    FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                }

                else
                {
                    if (Save.Text == "Save" && ddlPetroCardNumber.Enabled == false)
                    {
                        if (ddlBunkName.Visible == true)
                        {

                            bunkname = ddlBunkName.SelectedItem.Text;
                        }
                        else
                        {
                            bunkname = txtBunkName.Text;
                        }
						// Convert.ToInt32(Session["UserdistrictId"].ToString());
						// Convert.ToInt32(ddlVehicleNumber.SelectedValue);
						// // FuelEntry;
						// Convert.ToInt64(txtBillNumber.Text); 
						// Convert.ToInt64(txtOdometer.Text); 
						// Convert.ToInt32(ddlPaymode.SelectedValue);
						// Convert.ToDecimal(txtQuantity.Text);
						// Convert.ToDecimal(txtUnitPrice.Text);
						// Convert.ToString(txtLocation.Text);
						// Convert.ToInt32(Session["User_Id"].ToString());
						// // DateTime.Now;
						// Show(txtAmount.Text);
						// // Convert.ToDecimal(txtAmount.Text);
						// Convert.ToInt32(txtPilotID.Text);
						// Convert.ToString(txtPilotName.Text);
						// Convert.ToInt32(ddlCardSwiped.SelectedValue);
						// Convert.ToString(txtRemarks.Text);
                        InsFuelEntry1(Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), FuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToString(txtLocation.Text), Convert.ToInt32(Session["User_Id"].ToString()), DateTime.Now, 1, Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                        // Convert.ToInt32(txtSegmentID.Text), Convert.ToString(txtBaseLocation.Text),
                     //   ShowKMPL();
                        FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                    }

                    else if (Save.Text == "Update" && ddlPetroCardNumber.Enabled == true)
                    {
                        if (ddlBunkName.Visible == true)
                        {

                            bunkname = ddlBunkName.SelectedItem.Text;
                        }
                        else
                        {
                            bunkname = txtBunkName.Text;
                        }
                        UpdFuelEntry(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), Convert.ToInt32(ddlDistrict.SelectedValue), FuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToInt64(ddlPetroCardNumber.SelectedValue), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToInt32(ddlAgency.SelectedValue), Convert.ToString(txtLocation.Text), Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));
                        //Convert.ToInt32(txtSegmentID.Text), Convert.ToString(txtBaseLocation.Text),
                        FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                    }

                    else
                    {
                        if (ddlBunkName.Visible == true)
                        {

                            bunkname = ddlBunkName.SelectedItem.Text;
                        }
                        else
                        {
                            bunkname = txtBunkName.Text;
                        }
                        UpdFuelEntry1(Convert.ToInt32(txtEdit.Text), Convert.ToInt32(Session["UserdistrictId"].ToString()), Convert.ToInt32(ddlVehicleNumber.SelectedValue), FuelEntry, Convert.ToInt64(txtBillNumber.Text), Convert.ToInt64(txtOdometer.Text), bunkname, Convert.ToInt32(ddlPaymode.SelectedValue), Convert.ToDecimal(txtQuantity.Text), Convert.ToDecimal(txtUnitPrice.Text), Convert.ToString(txtLocation.Text), Convert.ToDecimal(txtAmount.Text), Convert.ToInt32(txtPilotID.Text), Convert.ToString(txtPilotName.Text), Convert.ToInt32(ddlCardSwiped.SelectedValue), Convert.ToString(txtRemarks.Text));

                        // Convert.ToInt32(txtSegmentID.Text), Convert.ToString(txtBaseLocation.Text),
                        FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
                    }
                }

            }
            //   }
            //  catch(Exception ex)
            //  {

            //   }


        }
private DataTable getpreviousODO(int VehicleId)
        {
            DataTable dtVehData = new DataTable();
            string connetionString = null;
            SqlConnection connection;
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            int i = 0;
            connetionString = ConfigurationSettings.AppSettings["Str"].ToString();
            connection = new SqlConnection(connetionString);
            try
            {
                connection.Open();
                adapter.SelectCommand = new SqlCommand("select max(entrydate) maxentry from T_FMS_FuelEntryDetails where vehicleid = '" + VehicleId + "' and status = 1", connection);
                adapter.Fill(ds);
                connection.Close();
                dtVehData = ds.Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dtVehData;


        }
        private void ShowKMPL()
        {

            string[] KMPL = new string[2];
            DataSet ds = new DataSet();
            ds = objFuelEntry.GetKMPL(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["KMPL"].ToString() == "")
                {
                    flag = false;
                    kmplInt = 0;
                }
                else
                {
                    string kmpl = (ds.Tables[0].Rows[0]["KMPL"].ToString());
                    //KMPL = kmpl.Split('.');
                    kmplInt = Convert.ToDouble(kmpl.ToString());
                    //kmplInt = Convert.ToInt16(KMPL[0]);
                    flag = true;
                    //if (kmplInt < 8)
                    //{
                    //    Show(" KMPL Is Less than AvgKMPL");
                    //}
                    //else
                    //{
                    //    Show("KMPL is"+ KMPL);
                    //}
                }
            }

            else
            {
                flag = false;
                kmplInt = 0;
            }
            //ClearFields();
        }

        private void ShowMasterKMPL()
        {
            string[] MasterKMPL = new string[2];
            DataSet ds = new DataSet();
            ds = objFuelEntry.GetMasterKMPL(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["KMPL"].ToString() == "")
                {
                    flag = false;
                    MSkmplInt = 0;
                }
                else
                {
                    string Masterkmpl = (ds.Tables[0].Rows[0]["KMPL"].ToString());
                    //KMPL = kmpl.Split('.');
                    MSkmplInt = Convert.ToDouble(Masterkmpl.ToString());
                    //kmplInt = Convert.ToInt16(KMPL[0]);
                    flag = true;
                    //if (kmplInt < 8)
                    //{
                    //    Show(" KMPL Is Less than AvgKMPL");
                    //}
                    //else
                    //{
                    //    Show("KMPL is"+ KMPL);
                    //}
                }
            }

            else
            {
                flag = false;
                kmplInt = 0;
            }
            //ClearFields();
        }




        private void UpdFuelEntry1(int FuelEntryID, int DistrictID, int VehicleID, DateTime EntryDate, long BillNumber, long Odometer, string BunkName, int Paymode, decimal Quantity, decimal UnitPrice, string Location, decimal Amount, int PilotID, string PilotName, int CardSwipedStatus, string Remarks)
        {

            int res = objFuelEntry.IUpdFuelEntry1(FuelEntryID, DistrictID, VehicleID, EntryDate, BillNumber, Odometer, BunkName, Paymode, Quantity, UnitPrice, Location, Amount, PilotID, PilotName, CardSwipedStatus, Remarks);

            ShowKMPL1();
            ShowMasterKMPL();
            if (res == 1)
            {
                if (kmplInt == 0 && flag == false)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (kmplInt < 8)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt;
                    Show(strFmsScript);
                }
                else
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt;
                    Show(strFmsScript);
                }

            }
            else
            {
                string strFmsScript = "Failure";
                Show(strFmsScript);
            }

            ClearFields();
        }

        private void ShowKMPL1()
        {
            string[] KMPL = new string[2];
            DataSet ds = new DataSet();
            ds = objFuelEntry.GetKMPL(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["KMPL"].ToString() == "")
                {
                    flag = false;
                    kmplInt = 0;
                }
                else
                {
                    string kmpl = (ds.Tables[0].Rows[0]["KMPL"].ToString());
                    //KMPL = kmpl.Split('.');
                    kmplInt = Convert.ToDouble(kmpl.ToString());
                    //kmplInt = Convert.ToInt16(KMPL[0]);
                    flag = true;
                    //if (kmplInt < 8)
                    //{
                    //    Show(" KMPL Is Less than AvgKMPL");
                    //}
                    //else
                    //{
                    //    Show("KMPL is"+ KMPL);
                    //}
                }
            }

            else
            {
                flag = false;
                kmplInt = 0;
            }
            //ClearFields();
        }





        private void InsFuelEntry(int DistrictID, int VehicleID, int BorrowedVehicle, DateTime EntryDate, long BillNumber, long Odometer, string BunkName, int Paymode, decimal Quantity, long PetroCardNumber, decimal UnitPrice, int AgencyID, string Location, int CreatedBy, DateTime CreatedDate, int Status, decimal Amount, int PilotID, string PilotName, int CardSwipedStatus, string Remarks)
        {
            DataSet dsOdo = new DataSet();
            dsOdo = objFuelEntry.ICheckFuelEntryOdo(Convert.ToInt32(ddlVehicleNumber.SelectedValue));

            int maxodo = Convert.ToInt32(dsOdo.Tables[0].Rows[0]["ODO"].ToString());

            if (maxodo < Odometer)
            {
                DataSet dsres = new DataSet();
                dsres = objFuelEntry.IInsFuelEntry(DistrictID, VehicleID, BorrowedVehicle, EntryDate, BillNumber, Odometer, BunkName, Paymode, Quantity, PetroCardNumber, UnitPrice, AgencyID, Location, CreatedBy, CreatedDate, Status, Amount, PilotID, PilotName, CardSwipedStatus, Remarks);
                ShowKMPL();
                ShowMasterKMPL();
                if (dsres.Tables[0].Rows.Count > 0)
                {
                    string resid = dsres.Tables[0].Rows[0][0].ToString();
                    if (kmplInt == 0 && flag == false)
                    {
                        string strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                        Show(strFmsScript);
                    }
                    else if (kmplInt < 8)
                    {
                        string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt + "\\nTransaction Id = " + resid;
                        Show(strFmsScript);
                    }
                    else
                    {
                        string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt + "\\nTransaction Id = " + resid;
                        Show(strFmsScript);
                    }

                }
                else
                {
                    string strFmsScript = "Failure";
                    Show(strFmsScript);
                }
                ClearFields();

            }

            else
            {
                string strFmsScript = "Odometer Reading can't be less than the Previous Odometer Reading";
                Show(strFmsScript);

            }

        }


        private void InsFuelEntry1(int DistrictID, int VehicleID, DateTime EntryDate, long BillNumber, long Odometer, string BunkName, int Paymode, decimal Quantity, decimal UnitPrice, string Location, int CreatedBy, DateTime CreatedDate, int Status, decimal Amount, int PilotID, string PilotName, int CardSwipedStatus, string Remarks)
        {
            DataSet ds = new DataSet();
            ds = objFuelEntry.IInsFuelEntry1(DistrictID, VehicleID, EntryDate, BillNumber, Odometer, BunkName, Paymode, Quantity, UnitPrice, Location, CreatedBy, CreatedDate, Status, Amount, PilotID, PilotName, CardSwipedStatus, Remarks);

            ShowKMPL();
            ShowMasterKMPL();
            if (ds.Tables[0].Rows.Count > 0)
            {
                string resid = ds.Tables[0].Rows[0][0].ToString();
                if (kmplInt == 0 && flag == false)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (kmplInt < 8)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt + "\\nTransaction Id = " + resid;
                    Show(strFmsScript);
                }
                else
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt + "\\nTransaction Id = " + resid;
                    Show(strFmsScript);
                }

            }
            else
            {
                string strFmsScript = "Failure";
                Show(strFmsScript);
            }
            ClearFields();

        }





        private void UpdFuelEntry(int FuelEntryID, int DistrictID, int VehicleID, int BorrowedVehicle, DateTime EntryDate, long BillNumber, long Odometer, string BunkName, int Paymode, decimal Quantity, long PetroCardNumber, decimal UnitPrice, int AgencyID, string Location, decimal Amount, int PilotID, string PilotName, int CardSwipedStatus, string Remarks)
        {
            int res = objFuelEntry.IUpdFuelEntry(FuelEntryID, DistrictID, VehicleID, BorrowedVehicle, EntryDate, BillNumber, Odometer, BunkName, Paymode, Quantity, PetroCardNumber, UnitPrice, AgencyID, Location, Amount, PilotID, PilotName, CardSwipedStatus, Remarks);

            ShowKMPL1();
            ShowMasterKMPL();
            if (res == 1)
            {
                if (kmplInt == 0 && flag == false)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL is NA since no past Fuel Entry Records are found for this vehicle";
                    Show(strFmsScript);
                }
                else if (kmplInt < 8)
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt;
                    Show(strFmsScript);
                }
                else
                {
                    string strFmsScript = "Fuel Entry Inserted and KMPL = " + kmplInt + "\\nBenchMark KMPL =" + MSkmplInt;
                    Show(strFmsScript);
                }

            }
            else
            {
                string strFmsScript = "Failure";
                Show(strFmsScript);
            }
            ClearFields();
        }



        private void FillGridFuelEntry(int VehicleID)
        {
           gvFuelEntry.Visible = true;
            int districtID = -1;

            if (Session["UserdistrictId"] != null)
            {
                districtID = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }

            DataSet ds = new DataSet();

            ds = objFuelEntry.IFillGridFuelEntry(VehicleID);
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
            int districtID = -1;

            if (Session["UserdistrictId"] != null)
            {
                districtID = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }
            DataSet ds = new DataSet();
            ds = objFuelEntry.IFillGridFuelEntry(Convert.ToInt32(ddlVehicleNumber.SelectedValue));
            gvFuelEntry.DataSource = ds;
            gvFuelEntry.DataBind();
        }

        protected void gvFuelEntry_RowEditing(object sender, GridViewEditEventArgs e)
        {



        }

        protected void gvFuelEntry_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void ClearFields()
        {
            txtAmount.Text = "";

            txtBillNumber.Text = "";
            if (ddlBunkName.Visible == true)
            {
                ddlBunkName.Items.Clear();
            }
            else
            {
                txtBunkName.Text = "";
            }
            txtEdit.Text = "";
            txtFuelEntryDate.Text = "";
            txtLocation.Text = "";
            txtOdometer.Text = "";
            txtQuantity.Text = "";
            txtSegmentID.Text = "";
            txtUnitPrice.Text = "";
            txtPilotID.Text = "";
            txtPilotName.Text = "";
            DataSet ds = new DataSet();
            if (ddlAgency.Items.Count != 0)
            {
                ddlAgency.SelectedIndex = -1;
            }
            ddlPaymode.SelectedIndex = 0;

            if (ddlAgency.Items.Count != 0)
            {
                ddlPetroCardNumber.SelectedIndex = -1;
            }

            if (ddlAgency.Items.Count != 0)
            {
                ddlVehicleNumber.SelectedIndex = -1;
            }

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
            if (e.CommandName == "EditFuel")
            {

                Save.Text = "Update";



                int id = Convert.ToInt32(e.CommandArgument.ToString());
                DataSet ds = new DataSet();
                ds = objFuelEntry.IEditFuelEntryDetails(id);
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
                string[] coBGrade = (Convert.ToString(ds.Tables[0].Rows[0]["Quantity"].ToString())).Split('.');
                txtQuantity.Text = coBGrade[0] + '.' + coBGrade[1].Substring(0, 2);
                txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                string[] cGrade = (Convert.ToString(ds.Tables[0].Rows[0]["UnitPrice"].ToString())).Split('.');
                txtUnitPrice.Text = cGrade[0] + '.' + cGrade[1].Substring(0, 2);
                string[] coAGrade = (Convert.ToString(ds.Tables[0].Rows[0]["Amount"].ToString())).Split('.');
                txtAmount.Text = coAGrade[0] + '.' + coAGrade[1].Substring(0, 2);
                txtPilotID.Text = ds.Tables[0].Rows[0]["Pilot"].ToString();
                txtPilotName.Text = ds.Tables[0].Rows[0]["PilotName"].ToString();
                txtRemarks.Text = ds.Tables[0].Rows[0]["RemarksFuel"].ToString();
                if (ds.Tables[0].Rows[0]["PetroCardNumber"].ToString() != string.Empty)
                {
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString()) == 0)
                    {
                        int vid = Convert.ToInt32(ds.Tables[0].Rows[0]["VehicleID"].ToString());
                        ddlPetroCardNumber.ClearSelection();
                        FillCardNumber(vid);
                        ddlPetroCardNumber.Items.FindByValue(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString()).Selected = true;
                        int pid = Convert.ToInt32(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString());
                        ddlAgency.ClearSelection();
                        FillFuelAgency(pid);
                        ddlAgency.Items.FindByValue(ds.Tables[0].Rows[0]["AgencyID"].ToString()).Selected = true;

                    }
                    else
                    {
                        int vid = Convert.ToInt32(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString());
                        ddlDistrict.ClearSelection();
                        ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["BorrowedVehicleID"].ToString()).Selected = true;
                        ddlPetroCardNumber.ClearSelection();
                        FillCardNumber(vid);
                        ddlPetroCardNumber.Items.FindByValue(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString()).Selected = true;
                        int pid = Convert.ToInt32(ds.Tables[0].Rows[0]["PetroCardNumber"].ToString());
                        ddlAgency.ClearSelection();
                        FillFuelAgency(pid);
                        ddlAgency.Items.FindByValue(ds.Tables[0].Rows[0]["AgencyID"].ToString()).Selected = true;
                    }

                }


                else
                {
                    FillFuelAgency(0);
                    int vid = Convert.ToInt32(ds.Tables[0].Rows[0]["VehicleID"].ToString());
                    ds = objFuelEntry.IFillCardNumber(vid);

                    ds = objFuelEntry.IFillAgencyWoDistrictID();

                }
                ddlAgency.Enabled = false;
                ddlPaymode.Enabled = false;
                ddlPetroCardNumber.Enabled = false;
                ddlVehicleNumber.Enabled = false;
                ddlDistrict.Enabled = false;


            }
            else if (e.CommandName == "DeleteFuel")
            {
                int result = 0;

                int id = Convert.ToInt32(e.CommandArgument.ToString());

                result = objFuelEntry.IDeleteFuelEntry(id);
                if (result == 1)
                {
                    string strFmsScript = "Fuel Entry Deactivated";
                    Show(strFmsScript);
                }
                else
                {
                    string strFmsScript = "failure";
                    Show(strFmsScript);
                }

                ClearFields();
                FillGridFuelEntry(Convert.ToInt32(ViewState["VehicleID"]));
            }
            else
            {

            }
        }


        private void FillGridLastFiveTransactions(int VehicleID)
        {

            DataSet ds = new DataSet();
            ds = objFuelEntry.ILastFiveTransactions(VehicleID);
            gvLastTransactions.DataSource = ds;
            gvLastTransactions.DataBind();
            gvLastTransactions.Visible = true;

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
}