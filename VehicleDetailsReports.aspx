<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleDetailsReports.aspx.cs" Inherits="VehicleDetailsReports" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="updtpnlVehicleDetailsReports" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td>Select District :
                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td>Select Vehicle :
                        <asp:DropDownList ID="ddlVehNumber" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVehNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="height: 21px"></td>
                </tr>
                <tr>
                    <td>From :
                        <asp:TextBox runat="server" ID="txtFrom" Width="114px" />
                        <cc1:CalendarExtender ID="CalFromDate" runat="server" TargetControlID="txtFrom" PopupButtonID="imgBtnCalendarMaintenanceDate"
                            Format="MM/dd/yyyy">
                        </cc1:CalendarExtender>
                    </td>
                    <td></td>
                    <td>To :
                        <asp:TextBox runat="server" ID="txtEnd" Width="114px" />
                        <cc1:CalendarExtender ID="CalToDate" runat="server" TargetControlID="txtEnd" PopupButtonID="imgBtnCalendarMaintenanceDate"
                            Format="MM/dd/yyyy">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnShowReport" runat="server" OnClick="btnShowReport_Click" Text="Show Report"
                            OnClientClick="return validationFuelEntry();" />
                    </td>
                    <td></td>
                    <td>
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="142px"
                            OnClick="btnExportToExcel_Click" />
                    </td>
                </tr>
                <tr>
                    <td></td>
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
