<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Reports.VehicleDetailsReports, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:UpdatePanel ID="updtpnlVehicleDetailsReports" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select District :
                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                        Select Vehicle :
                        <asp:DropDownList ID="ddlVehNumber" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVehNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="height: 21px">
                    </td>
                </tr>
                <tr>
                    <td>
                        From :
                        <asp:TextBox runat="server" ID="txtFrom" Width="114px" />
                        <cc1:calendarextender id="CalFromDate" runat="server" targetcontrolid="txtFrom" popupbuttonid="imgBtnCalendarMaintenanceDate"
                            format="MM/dd/yyyy">
                        </cc1:calendarextender>
                    </td>
                    <td>
                    </td>
                    <td>
                        To :
                        <asp:TextBox runat="server" ID="txtEnd" Width="114px" />
                        <cc1:calendarextender id="CalToDate" runat="server" targetcontrolid="txtEnd" popupbuttonid="imgBtnCalendarMaintenanceDate"
                            format="MM/dd/yyyy">
                        </cc1:calendarextender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnShowReport" runat="server" OnClick="btnShowReport_Click" Text="Show Report"
                            OnClientClick="return validationFuelEntry();" />
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="142px"
                            OnClick="btnExportToExcel_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleDetailsReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

