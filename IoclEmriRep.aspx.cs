//using Microsoft.Office.Interop.Excel;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IoclEmriRep : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Name"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            BindVehicles();
            tblHeader.Visible = false;
        }
    }

    private void BindVehicles()
    {
        string sqlQuery = "select * from m_fms_vehicles  order by vehicleNumber";
        AccidentReport.FillDropDownHelperMethod(sqlQuery, "vehicleNumber", "vehicleid", ddlvehicleNo);
        
    }

    protected void btntoExcel_Click(object sender, EventArgs e)
    {
        AccidentReport report=new AccidentReport();
        report.LoadExcelSpreadSheet(Panel4,"gvtoexcel.xls"); 
    }
 

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //  getdates

        DataTable dtData = AccidentReport.ExecuteSelectStmt("exec getdates '" + txtfromdate.Text + "','" + txttodate.Text + "','" +ddlvehicleNo.SelectedValue + "'");
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
        switch (e.Row.RowType)
        {
            case DataControlRowType.DataRow:
                string ioc = e.Row.Cells[12].Text;
                string emri = e.Row.Cells[21].Text;
                if (ioc != "&nbsp;" && emri != "&nbsp;")
                {
                    float iocFloat = float.Parse(ioc);
                    float emriFloat = float.Parse(emri);
                    int iocint = (int)iocFloat;
                    int emriint = (int)emriFloat;
                    if (iocint != emriint)
                    {
                        e.Row.Attributes["style"] = "background-color: #ED2C7733";
                    }
                }
                else if (ioc != emri)
                {
                    e.Row.Attributes["style"] = "background-color: #ED2C7733";
                }

                break;
        }
    }
}