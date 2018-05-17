<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleDetailsReports.aspx.cs" Inherits="VehicleDetailsReports" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                function pageLoad() {
                    $('#<%= ddlDistrict.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                    $('#<%= ddlVehNumber.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                };

                function Validations() {
                    var ddlDistrict = $('#<%= ddlDistrict.ClientID %> option:selected').text().toLowerCase();
                    if (ddlDistrict === '--select--') {
                        return alert("Please select District");
                    }
                    var ddlVehicle = $('#<%= ddlVehNumber.ClientID %> option:selected').text().toLowerCase();
                    if (ddlVehicle === '--select--') {
                        return alert("Please select Vehicle");
                    }
                    var txtFirstDate = $('#<%= txtFrom.ClientID %>').val();
                    var txtToDate = $('#<%= txtEnd.ClientID %>').val();
                    if (txtFirstDate === "") {
                        return alert('From Date is Mandatory');
                    }
                    if (txtToDate === "") {
                        return alert("End Date is Mandatory");
                    }
                    var fromDate = (txtFirstDate).replace(/\D/g, '/');
                    var toDate = (txtToDate).replace(/\D/g, '/');
                    var ordFromDate = new Date(fromDate);
                    var ordToDate = new Date(toDate);
                    var currentDate = new Date();
                    if (ordFromDate > currentDate) {
                        return alert("From date should not be greater than today's date");
                    }
                    if (ordToDate < ordFromDate) {
                        alert("Please select valid date range");
                    }
                    return true;
                }
            </script>
            <legend align="center" style="color: brown">Vehicle Details Report</legend>
            <br/>
            <table align="center">

                <tr>
                    <td>
                        Select District <span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDistrict" runat="server" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Vehicle <span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlVehNumber" runat="server" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="ddlVehNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        From <span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFrom" CssClass="search_3" Width="150px"/>
                        <cc1:CalendarExtender runat="server" TargetControlID="txtFrom" PopupButtonID="imgBtnCalendarMaintenanceDate"
                                              Format="MM/dd/yyyy">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        To <span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:TextBox runat="server" CssClass="search_3" ID="txtEnd" Width="150px"/>
                        <cc1:CalendarExtender runat="server" TargetControlID="txtEnd" PopupButtonID="imgBtnCalendarMaintenanceDate"
                                              Format="MM/dd/yyyy">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button CssClass="form-submit-button" runat="server" OnClick="btnShowReport_Click" Text="Show Report"
                                    OnClientClick=" if (!Validations()) return false;"/>
                    </td>

                    <td>
                        <asp:Button runat="server" CssClass="form-reset-button" Text="Export To Excel" Width="142px"
                                    OnClick="btnExportToExcel_Click"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
            <table align="center" style="margin-top: 20px">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleDetailsReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>