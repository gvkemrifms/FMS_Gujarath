<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="AnalysisHourwiseReport.aspx.cs" Inherits="AnalysisHourwiseReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="Scripts/jquery-1.4.4.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%= btnShowReport.ClientID %>').click(function () {
                var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                    alert("Please select District");
                    e.preventDefault("Please select District");
                }
                var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
                if (ddlVehicle === '--select--') {
                    alert("Please select Vehicle");
                    e.preventDefault();
                }
                var txtFirstDate = $('#<%= txtfrmDate.ClientID %>').val();
                var txtToDate = $('#<%= txttodate.ClientID %>').val();
                if (txtFirstDate === "") {
                    alert('From Date is Mandatory');
                    txtFirstDate.focus();
                    e.preventDefault();
                }
                if (txtToDate === "") {
                    alert("End Date is Mandatory");
                    txtToDate.focus();
                    e.preventDefault();
                }
                var fromDate = (txtFirstDate).replace(/\D/g, '/');
                var toDate = (txtToDate).replace(/\D/g, '/');
                var ordFromDate = new Date(fromDate); var ordToDate = new Date(toDate);
                if (ordToDate < ordFromDate) {
                    alert("Please select valid date range");
                }
            });
        })
    </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblanalysishourwisereport" Style="font-size: 20px; color: brown" runat="server" Text="Analysis Hour Wise&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>

    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" Style="width: 100px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>

            <td>
                <asp:Label ID="lblvehicle" runat="server" Text="Select&nbsp;Vehicle"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlvehicle" runat="server" Style="width: 100px"></asp:DropDownList>
            </td>
        </tr>
    </table>

    <table>
        <tr>
            <td>
                <asp:Label ID="lblfromdate" runat="server" Text="FromDate"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtfrmDate" runat="server"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" TargetControlID="txtfrmDate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
            <td>
                <asp:Label ID="lbltodate" runat="server" Text="To date"></asp:Label>
            </td>

            <td>
                <asp:TextBox ID="txttodate" runat="server"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy" TargetControlID="txttodate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
            <td>
                <asp:Button runat="server" id="btnShowReport" Text="ShowReport" OnClick="btnsubmit_Click"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button>
            </td>


        </tr>

    </table>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" runat="server"></asp:GridView>
        </asp:Panel>
    </div>   
</asp:Content>

