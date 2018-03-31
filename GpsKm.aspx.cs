using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GpsKm : Page
{
    string connectionString = ConfigurationManager.AppSettings["Str"].ToString();
    string LogLocation = @"D:\Log_IOCL_update\";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            bindVehicles();
            BindData();
        }
    }

    private void BindData()
    {
        string query ="select id, vehiclenumber,fuelentrydate, kmpl, unitprice, GpsKms, entrydate,expprice,petrocardnum,canpush from t_expfuelDump";
        DataTable dtData = ExecuteSelectStmt(query);
        if (dtData.Rows.Count > 0)
        {
            grdRepData.DataSource = dtData;
            grdRepData.DataBind();
        }
        else
        {
            grdRepData.DataSource = null;
            grdRepData.DataBind();
            Show("No Records Found");
        }
    }
    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }



    private void bindVehicles()
    {
        //DataTable dtvehData = new DataTable();
        //dtvehData = executeSelectStmt("select * from m_fms_vehicles order by vehicleNumber");
        //ddlvehicleNo.DataSource = dtvehData;
        //ddlvehicleNo.DataTextField = "vehicleNumber";
        //ddlvehicleNo.DataValueField = "vehicleid";
        //ddlvehicleNo.DataBind();
        //ddlvehicleNo.Items.Insert(0, new ListItem("--All--", "0"));
    }
    private DataTable ExecuteSelectStmt(string selectStmt)
    {
        DataTable dtSyncData = new DataTable();
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(connectionString);
            connection.Open();
            SqlDataAdapter dataAdapter = new SqlDataAdapter {SelectCommand = new SqlCommand(selectStmt, connection)};
            dataAdapter.Fill(dtSyncData);
            TraceService(selectStmt);
            return dtSyncData;
        }
        catch (Exception ex)
        {
            TraceService(" executeSelectStmt() " + ex.ToString() + selectStmt);
            return null;
        }
        finally
        {
            connection.Close();
        }
    }
    private void TraceService(string content)
    {
        string str = @"C:\fmslog_1\Log.txt";
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
            streamWriter.WriteLine(content.ToString());
            streamWriter.Flush();
            streamWriter.Close();
        }

        catch
        {
            // traceService(ex.ToString());
        }
    }



    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=gvtoexcel.xls");
        Response.ContentType = "application/excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        grdRepData.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

    }

    protected void grdRepData_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "change")
        {
            string vehicleNumber = e.CommandArgument.ToString();
            var dtVehicleDetails = ExecuteSelectStmt("select * from t_expfuelDump where vehiclenumber = '" + vehicleNumber + "'");
            if (dtVehicleDetails != null && dtVehicleDetails.Rows.Count > 0)
            {
                dvSearch.Visible = true;
                txtVehicleNumber.Text = dtVehicleDetails.Rows[0]["vehiclenumber"].ToString();
                txtCardNumber.Text = dtVehicleDetails.Rows[0]["petrocardnum"].ToString();
                txtLimit.Text = dtVehicleDetails.Rows[0]["expprice"].ToString();
                chkpush.Checked = dtVehicleDetails.Rows[0]["canpush"].ToString() == "true";
            }
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        int l = 0;
        if (chkpush.Checked )
        {
            l = 1;
        }
        int i = ExecuteInsertStatement("update t_expfuelDump set petrocardnum = '" + txtCardNumber.Text + "',expprice='" + txtLimit.Text + "', canpush = '" + l + "' where vehiclenumber = '" + txtVehicleNumber.Text + "' ");
        TraceService(txtVehicleNumber.Text + "~~~~~~" + i.ToString() + "~~~~~~" + txtLimit.Text);
        PushDatatoIoc();
        Clear();
    }
   


    private void PushDatatoIoc()
    {
        DataTable dtCredentials = ExecuteSelectStmt("select * from M_IOC_API_updateCurrency where isactive = 1;");
        if (dtCredentials.Rows.Count > 0)
        {
            var request = (HttpWebRequest)WebRequest.Create(dtCredentials.Rows[0]["url"].ToString());
            var postData = "UserName=" + dtCredentials.Rows[0]["username"];
            postData += "&Password=" + dtCredentials.Rows[0]["Password"];
            postData += "&CustomerId=" + dtCredentials.Rows[0]["CustomerId"];
            postData += "&CardNumber=" + txtCardNumber.Text;
            postData += "&CCMSLimitType=" + dtCredentials.Rows[0]["CCMSLimitType"].ToString();
            postData += "&CCMSLimitAmount="+ txtLimit.Text;

            var data = Encoding.ASCII.GetBytes(postData);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            using (var stream = request.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            var response = (HttpWebResponse)request.GetResponse();
            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
            dynamic jObj = JsonConvert.DeserializeObject(responseString);

            try
            {
                if (jObj.StatusCode == "0")
                {
                    string insertstmt = "update t_expfuelDump set ReferenceNo = '" + jObj.ReferenceNo + "', StatusCode = '" + jObj.StatusCode + "', Message ='" + jObj.Message + "' where petrocardnum = '" + txtCardNumber.Text.ToString() + "'";
                    ExecuteInsertStatement(insertstmt);
                }
                else
                {
                    string insertstmt = "update t_expfuelDump set ReferenceNo = '" + jObj.ReferenceNo + "', StatusCode = '" + jObj.StatusCode + "' where petrocardnum = '" + txtCardNumber.Text.ToString() + "'";
                    ExecuteInsertStatement(insertstmt);
                }
            }
            catch (Exception ex)
            {
                TraceService("Exception Raised ~ 1123~2 : " + ex.ToString());
            }

        }
    }
    public class WebClient : System.Net.WebClient
    {
        public int Timeout { get; set; }

        protected override WebRequest GetWebRequest(Uri uri)
        {
            WebRequest lWebRequest = base.GetWebRequest(uri);
            lWebRequest.Timeout = Timeout;
            ((HttpWebRequest)lWebRequest).ReadWriteTimeout = Timeout;
            return lWebRequest;
        }
    }
    private void TraceService_Result(string content)
    {

        string str = LogLocation + DateTime.Today.ToString("yyyy-MM-dd") + @"\TraceService_Result.txt";
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
            streamWriter.WriteLine(content.ToString());
            streamWriter.WriteLine("=======================================================================");
            streamWriter.WriteLine();
            streamWriter.WriteLine();
            streamWriter.WriteLine();
            streamWriter.Flush();
            streamWriter.Close();
        }
        catch (Exception ex)
        {
            TraceService(ex.ToString());
        }
    }


    private void Clear()
    {
        txtVehicleNumber.Text = txtLimit.Text = txtCardNumber.Text = "";
        chkpush.Checked = false;
        BindData();
        dvSearch.Visible = false;
    }

    private int ExecuteInsertStatement(string insertStmt)
    {
        try
        {
            int i = 0;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand comm = new SqlCommand())
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
                    catch (SqlException ex)
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
        catch (Exception ex)
        {
            TraceService(" executeInsertStatement " + ex.ToString());
            return 0;
        }
    }
}