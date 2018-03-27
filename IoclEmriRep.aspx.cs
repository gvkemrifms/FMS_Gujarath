//using Microsoft.Office.Interop.Excel;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IoclEmriRep : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.AppSettings["Str"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            bindVehicles();
            tblHeader.Visible = false;
        }
    }

    private void bindVehicles()
    {
        DataTable dtvehData = new DataTable();
        dtvehData = executeSelectStmt("select * from m_fms_vehicles  order by vehicleNumber");
        ddlvehicleNo.DataSource = dtvehData;
        ddlvehicleNo.DataTextField = "vehicleNumber";
        ddlvehicleNo.DataValueField = "vehicleid";
        ddlvehicleNo.DataBind();
        ddlvehicleNo.Items.Insert(0,new ListItem( "--All--", "0"));
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=gvtoexcel.xls");
        Response.ContentType = "application/excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        Panel4.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.Flush();
        Response.End();
        
    }
    private DataTable executeSelectStmt(string selectStmt)
    {
        DataTable dtSyncData = new DataTable();
        SqlConnection connection = null;
        try
        {
            connection = new SqlConnection(connectionString);
            connection.Open();
            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            dataAdapter.SelectCommand = new SqlCommand(selectStmt, connection);
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
        string str = @"C:\smslog_1\Log.txt";
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
            // traceService(ex.ToString());
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //  getdates

        DataTable dtData = executeSelectStmt("exec getdates '" + txtfromdate.Text.ToString() + "','" + txttodate.Text.ToString() + "','" +ddlvehicleNo.SelectedValue.ToString() + "'");
        if (dtData.Rows.Count > 0)
        {
            grdRepData.DataSource = dtData;
            grdRepData.DataBind();
            tblHeader.Visible = true;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "rearrange()", true);
        }
        else
        {
            grdRepData.DataSource = null;
            grdRepData.DataBind();
            Show("No Records Found");
            tblHeader.Visible = false;
        }

    }
    public void Show(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", "alert('" + message + "');", true);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /*Tell the compiler that the control is rendered
         * explicitly by overriding the VerifyRenderingInServerForm event.*/
    }
    protected void grdRepData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string ioc = e.Row.Cells[12].Text;
            string emri = e.Row.Cells[21].Text;
            if (ioc != "&nbsp;" && emri != "&nbsp;")
            {
                float iocFloat = float.Parse(ioc);
                float EmriFloat = float.Parse(emri);
                int iocint = (int)iocFloat;
                int emriint = (int)EmriFloat;
                if (iocint != emriint)
                {
                    e.Row.Attributes["style"] = "background-color: #ED2C7733";
                }
            }
            else if (ioc != emri)
            {
                e.Row.Attributes["style"] = "background-color: #ED2C7733";
            }
        }
    }
}