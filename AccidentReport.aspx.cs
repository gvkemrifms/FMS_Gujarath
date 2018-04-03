using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

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
        var sqlQuery = "select district_id,district_name from m_district  where state_id= 24 and is_active = 1";
        FillDropDownHelperMethod(sqlQuery, "district_name", "district_id", ddldistrict);
    }

    protected void ddldistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldistrict.SelectedIndex <= 0)
        {
            ddlvehicle.Enabled = false;
        }
        else
        {
            ddlvehicle.Enabled = true;
            try
            {
                FillDropDownHelperMethodWithSp("P_GetVehicleNumber", "VehicleNumber", "VehicleID", ddldistrict, ddlvehicle, null, null, "@districtID");
            }
            catch (Exception)
            {
                //Commented
            }
        }
    }

    public static DataTable ExecuteSelectStmt(string query)
    {
        var cs = ConfigurationManager.AppSettings["Str"];
        var dtSyncData = new DataTable();
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(cs);
            connection.Open();
            var dataAdapter = new SqlDataAdapter {SelectCommand = new SqlCommand(query, connection)};
            dataAdapter.Fill(dtSyncData);
            TraceService(query);
            return dtSyncData;
        }
        catch (Exception ex)
        {
            TraceService("executeSelectStmt() " + ex + query);
            return null;
        }
        finally
        {
            connection.Close();
        }
    }

    public static void TraceService(string content)
    {
        var str = @"C:\smslog_1\Log.txt";
        var path1 = str.Substring(0, str.LastIndexOf("\\", StringComparison.Ordinal));
        var path2 = str.Substring(0, str.LastIndexOf(".txt", StringComparison.Ordinal)) + "-" + DateTime.Today.ToString("yyyy-MM-dd") + ".txt";
        try
        {
            if (!Directory.Exists(path1)) Directory.CreateDirectory(path1);
            if (path2.Length >= Convert.ToInt32(4000000)) path2 = str.Substring(0, str.LastIndexOf(".txt", StringComparison.Ordinal)) + "-" + "2" + ".txt";

            var streamWriter = File.AppendText(path2);
            streamWriter.WriteLine("====================" + DateTime.Now.ToLongDateString() + "  " + DateTime.Now.ToLongTimeString());
            streamWriter.WriteLine(content);
            streamWriter.Flush();
            streamWriter.Close();
        }
        catch
        {
            // traceService(ex.ToString());
        }
    }

    public static int ExecuteInsertStatement(string insertStmt)
    {
        using (var conn = new MySqlConnection(ConfigurationManager.AppSettings["Str"]))
        {
            using (var comm = new MySqlCommand())
            {
                var i = 0;
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
                    TraceService(" executeInsertStatement " + ex + insertStmt);
                    return i;
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }

    public static void FillDropDownHelperMethodWithSp(string commandText, string textFieldValue = "", string valueField = "", DropDownList dropDownValue = null, DropDownList dropDownValue2 = null, TextBox txtBox = null, TextBox txtBox1 = null, string parameterValue1 = null, string parameterValue2 = null, string parameterValue3 = null, string parameterValue4 = null, string parameterValue5 = null, GridView gridView = null, DropDownList dropDownValue3 = null, DropDownList dropDownValue4 = null)
    {
        var conn = new SqlConnection(ConfigurationManager.AppSettings["Str"]);
        var ds = new DataSet();
        conn.Open();
        var cmd = new SqlCommand {Connection = conn, CommandType = CommandType.StoredProcedure, CommandText = commandText};
        if (dropDownValue != null && gridView == null && dropDownValue2 == null)
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
        else if (dropDownValue != null && dropDownValue2 != null && gridView == null)
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
            if (dropDownValue2 != null) cmd.Parameters.AddWithValue(parameterValue2, dropDownValue2.SelectedItem.Value);
            if (dropDownValue3 != null) cmd.Parameters.AddWithValue(parameterValue3, dropDownValue3.SelectedItem.Value);
            if (dropDownValue4 != null) cmd.Parameters.AddWithValue(parameterValue4, dropDownValue4.SelectedItem.Value);
            if (txtBox != null) cmd.Parameters.AddWithValue(parameterValue3, txtBox.Text + " 00:00:00");
            if (txtBox1 != null) cmd.Parameters.AddWithValue(parameterValue4, txtBox1.Text + " 23:59:59");
            var da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            var dt = ds.Tables[0];
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
        else
        {
            var da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            var dt = ds.Tables[0];
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
            var cmd = new SqlCommand(query, con);
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);
            dropdownId.DataSource = ds.Tables[0];
            dropdownId.DataTextField = textFieldValue;
            dropdownId.DataValueField = valueField;
            dropdownId.DataBind();
            dropdownId.Items.Insert(0, new ListItem("--Select--", "0"));
            con.Close();
        }
    }

    public static void FillDropDownHelperMethodWithDataSet(DataSet dataSet, string textFieldValue, string valueField, DropDownList dropdownId = null, AjaxControlToolkit.ComboBox combo = null)
    {
        if (dropdownId == null)
        {
            if (combo != null)
            {
                combo.Items.Clear();
                combo.DataSource = dataSet.Tables[0];
                combo.DataTextField = textFieldValue;
                combo.DataValueField = valueField;
                combo.DataBind();
                combo.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        else
        {
            dropdownId.Items.Clear();
            dropdownId.DataSource = dataSet.Tables[0];
            dropdownId.DataTextField = textFieldValue;
            dropdownId.DataValueField = valueField;
            dropdownId.DataBind();
            dropdownId.Items.Insert(0, new ListItem("--Select--", "0"));
        }
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        try
        {
            LoadExcelSpreadSheet(Panel2, "VehicleSummaryDistrictwise.xls");
        }
        catch (Exception)
        {
            // Response.Write(ex.Message.ToString());
        }
    }

    public void LoadExcelSpreadSheet(Panel panel = null, string fileName = null, GridView gridView = null)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
        Response.ContentType = "application/excel";
        var sw = new StringWriter();
        var htw = new HtmlTextWriter(sw);
        if (gridView != null)
            gridView.RenderControl(htw);
        else
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
            FillDropDownHelperMethodWithSp("P_FMSReports_FuelReport", null, null, ddldistrict, ddlvehicle, txtfrmDate, txttodate, "@districtID", "@VehicleID", "@From", "@To", null, Grddetails);
        }
        catch (Exception)
        {
            // ignored
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}