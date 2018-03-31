using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AccidentReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlvehicle.Enabled = false;
            BindDistrictdropdown();
            // withoutdist();
        }
    }
    private void BindDistrictdropdown()
    {

        string sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);


    }
    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex > 0)
        {
            ddlvehicle.Enabled = true;


            try
            {
                FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict,null,null,null,"@districtID");
            }
            catch (Exception)
            {
                //Commented
            }
        }
        else
        {
            ddlvehicle.Enabled = false;
        }
    }

    public static void FillDropDownHelperMethodWithSp(string commandText, string textFieldValue = "", string valueField = "", DropDownList dropDownValue = null, DropDownList dropDownValue2 = null,TextBox txtBox=null,TextBox txtBox1=null, string parameterValue1 = null, string parameterValue2 = null, string parameterValue3 = null, string parameterValue4 = null, string parameterValue5 = null, GridView gridView = null)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["Str"]);
        DataSet ds = new DataSet();
        conn.Open();
        SqlCommand cmd = new SqlCommand
        {
            Connection = conn,
            CommandType = CommandType.StoredProcedure,
            CommandText = commandText
        };
        if (dropDownValue != null && gridView==null && dropDownValue2==null)
        {
            cmd.Parameters.AddWithValue(parameterValue1, dropDownValue.SelectedItem.Value);
            var da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            dropDownValue.DataSource = ds.Tables[0];
            dropDownValue.DataTextField = textFieldValue;
            dropDownValue.DataValueField = valueField;
            dropDownValue.DataBind();
            dropDownValue.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        else if (dropDownValue != null && dropDownValue2 != null)
        {
            cmd.Parameters.AddWithValue(parameterValue1, dropDownValue.SelectedItem.Value);
            var da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            dropDownValue2.DataSource = ds.Tables[0];
            dropDownValue2.DataTextField = textFieldValue;
            dropDownValue2.DataValueField = valueField;
            dropDownValue2.DataBind();
            dropDownValue2.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        else if (gridView != null)
        {
            if (dropDownValue != null) cmd.Parameters.AddWithValue(parameterValue1, dropDownValue.SelectedItem.Value);
            if (parameterValue1!=null||parameterValue2 != null  || parameterValue3 != null ||
                parameterValue4 != null || parameterValue5 != null)
            {
                if (dropDownValue2 != null)
                    cmd.Parameters.AddWithValue(parameterValue2, dropDownValue2.SelectedItem.Value);
                if (txtBox != null) cmd.Parameters.AddWithValue(parameterValue3, txtBox.Text);
                if (txtBox1 != null) cmd.Parameters.AddWithValue(parameterValue4, txtBox1.Text);
            }
          
            var da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                gridView.DataSource = dt;
                gridView.DataBind();
            }
            else
            {
                gridView.DataSource = null;
                gridView.DataBind();
            }
        }

        conn.Close();
    }

    public static void FillDropDownHelperMethod(string query, string textFieldValue, string valueField, DropDownList dropdownId)
    {
        using (var con = new SqlConnection(ConfigurationManager.AppSettings["Str"]))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dropdownId.DataSource = ds.Tables[0];
            dropdownId.DataTextField = textFieldValue;
            dropdownId.DataValueField = valueField;
            dropdownId.DataBind();
            dropdownId.Items.Insert(0, new ListItem("--Select--", "0"));
            con.Close();
        }
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            LoadExcelSpreadSheet(Panel2);
        }
        catch (Exception)
        {
            // Response.Write(ex.Message.ToString());
        }

    }

    public void LoadExcelSpreadSheet(Panel panel)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=VehicleSummaryDistrictwise.xls");
        Response.ContentType = "application/excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        panel.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Loaddata();
    }
    public void Loaddata()
    {
        try
        {
            FillDropDownHelperMethodWithSp("P_FMSReports_FuelReport", null, null, ddldistrict,ddlvehicle,txtfrmDate,txttodate, "@districtID", "@VehicleID", "@From", "@To",null, Grddetails);
            
        }
        catch (Exception)
        {
            // ignored
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }

}
