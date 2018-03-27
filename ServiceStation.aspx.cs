using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GvkFMSAPP.PL
{
    public partial class ServiceStation : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        GvkFMSAPP.BLL.BaseVehicleDetails fmsobj1 = null;
        GvkFMSAPP.BLL.BaseVehicleDetails fmsobj = new GvkFMSAPP.BLL.BaseVehicleDetails();
        GvkFMSAPP.BLL.VAS_BLL.VASGeneral obj = new GvkFMSAPP.BLL.VAS_BLL.VASGeneral();
        GvkFMSAPP.BLL.FMSGeneral fmsg = new GvkFMSAPP.BLL.FMSGeneral();

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

                bindgrid();
                FillVehicles();
                bindData();
                btnUpdate.Visible = false;
                txtServiceSrationName.Attributes.Add("onkeypress", "javascript:return OnlyAlphabets(this,event)");
            }
        }

        private void FillVehicles()
        {
            int districtID = -1;

            if (Session["UserdistrictId"] != null)
            {
                districtID = Convert.ToInt32(Session["UserdistrictId"].ToString());
            }
            ds = null;
            ds = fmsg.GetVehicleNumber();
            //ds = objFuelEntry.IFillVehicles(districtID);
            ddlVehicleNumber.DataSource = ds.Tables[0];
            ddlVehicleNumber.DataValueField = "VehicleID";
            ddlVehicleNumber.DataTextField = "VehicleNumber";
            ddlVehicleNumber.DataBind();
            ddlVehicleNumber.Items.Insert(0, new ListItem("--Select--", "0"));
            ViewState["dsVehicles"] = ds;

        }
        public void bindData()
        {
            //DataSet dsDistricts = new DataSet();
            ds = null;
            ds = fmsobj.GetDistricts_new();
            ddlDistricts.DataSource = ds.Tables[0];
            ddlDistricts.DataTextField = "district_name";
            ddlDistricts.DataValueField = "district_id";
            ddlDistricts.DataBind();
            ddlDistricts.Items.Insert(0, new ListItem("--Select--", "0"));
            ViewState["dsDistricts"] = ds;
        }
        private void SetInitialRowSP()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;

            //Define the Columns
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("ColSpVendorName", typeof(string)));


            dr = dt.NewRow();

            dt.Rows.Add(dr);

            //Store the DataTable in ViewState
            ViewState["CurrentTable"] = dt;
            //Bind the DataTable to the Grid
            gvServiceStationDetails.DataSource = dt;
            gvServiceStationDetails.DataBind();


        }

        public void bindgrid()
        {
            DataSet ds = fmsobj.GetGridServiceNames();
            gvServiceStationDetails.DataSource = ds.Tables[0];
            gvServiceStationDetails.DataBind();
            ViewState["dsGrid"] = ds;
            //Session["griddataset"] = ds.Tables[0];
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            fmsobj.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);
            fmsobj.ServiceName = txtServiceSrationName.Text;
            fmsobj.DistrictId = Convert.ToInt16(ddlDistricts.SelectedValue);


            // DataSet ds1 = fmsobj.CheckServiceName();

            int Output = fmsobj.InsertServiceName();
            if (Output > 0)
            {
                Show("Inserted Succesfully");
                ClearAll();
                bindgrid();
            }
            else
            {
                Show("Not Inserted");
            }


            //if (Convert.ToInt16(ds1.Tables[0].Rows[0][0].ToString()) != 0)
            //{
            //    Show("Records Inserted Successfully");
            //    ClearAll();
            //}
            //else
            //{
            //    Show("Error");
            //}

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

            if (e.CommandName == "MainEdit")
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
                DataSet ds = (DataSet)ViewState["dsGrid"];
                DataView dv = new DataView(ds.Tables[0]);
                dv.RowFilter = "ServiceStation_Name='" + txtServiceSrationName.Text + "' and ds_lname='" + ddlDistricts.SelectedItem.Text + "' and VehicleNumber='" + ddlVehicleNumber.SelectedItem.Text + "'";
                DataTable dt = dv.ToTable();
                Session["Id"] = Convert.ToString(dt.Rows[0]["Id"]);
            }

            else if (e.CommandName == "MainDelete")
            {

                DataSet ds = (DataSet)ViewState["dsGrid"];
                DataView dv = new DataView(ds.Tables[0]);
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
                dv.RowFilter = "ServiceStation_Name='" + txtServiceSrationName.Text + "' and ds_lname='" + ddlDistricts.SelectedItem.Text + "' and VehicleNumber='" + ddlVehicleNumber.SelectedItem.Text + "'";
                DataTable dt = dv.ToTable();
                Session["Id"] = Convert.ToString(dt.Rows[0]["Id"]);
                fmsobj.GridId = Convert.ToInt16(Session["Id"]);
                int delres = fmsobj.DeleteServiceName();
                if (delres != 0)
                    Show("Record Deleted Successfully!!");
                else
                    Show("Error!!");
                ClearAll();
                bindgrid();

            }

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id;
            if (Session["Id"] != null)
            {
                id = Convert.ToInt16(Session["Id"]);
            }
            else
            {
                id = 0;
            }
            fmsobj.ServiceName = txtServiceSrationName.Text;
            fmsobj.DistrictId = Convert.ToInt16(ddlDistricts.SelectedValue);
            fmsobj.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);

            fmsobj.GridId = id;
            DataSet ds1 = fmsobj.CheckServiceName();
            bool isExists = false;
            if (ds1 != null)
            {
                if (ds1.Tables.Count > 0)
                {
                    if (ds1.Tables[0].Rows.Count > 0)
                    {

                        if ((Convert.ToString(ds1.Tables[0].Rows[0]["Vehicle_ID"]) == ddlVehicleNumber.SelectedValue))
                        // if (ds1.Tables[0].Select("ServiceStation_Name='" + txtServiceSrationName.Text +  "District_Id=" + ddlDistricts.SelectedValue + "'").Length > 0)
                        {
                            Show("Service Station already exists for Selected Vehicle");
                            isExists = true;
                            // ClearAll();
                        }
                    }
                }
            }
            if (!isExists)
            {
                int Output = fmsobj.UpdServiceName();
                if (Output > 0)
                {
                    Show("Updated Succesfully");
                    ClearAll();
                    bindgrid();
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                }
                else
                {
                    Show("Not Inserted");
                }
            }
        }

        protected void ddlVehicleNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillDistrict();
            FillBunks();
        }

        private void FillDistrict()
        {
            fmsg.vehicle = (ddlVehicleNumber.SelectedItem.ToString());
            DataSet dsDistrict = fmsg.GetDistrictLoc();
            bindData();
            if (dsDistrict.Tables[0].Rows.Count > 0)
            {
                ddlDistricts.Items.FindByText(dsDistrict.Tables[0].Rows[0]["District"].ToString()).Selected = true;
            }
            else
            {
                ddlDistricts.Enabled = true;
            }



        }

        private void FillBunks()
        {
            fmsg.VehicleId = Convert.ToInt16(ddlVehicleNumber.SelectedValue);
            DataSet dsServiceNames = fmsg.GetBunkNames();
            if (dsServiceNames.Tables[0].Rows.Count > 0)
            {
                txtServiceSrationName.Text = dsServiceNames.Tables[0].Rows[0]["ServiceStnName"].ToString();
            }
            else
            {
                txtServiceSrationName.Text = "";
            }
        }

        protected void gvServiceStationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvServiceStationDetails.PageIndex = e.NewPageIndex;
            bindgrid();

        }
    }
}