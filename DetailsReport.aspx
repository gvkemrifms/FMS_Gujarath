<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DetailsReport.aspx.cs" Inherits="DetailsReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
      var func=  $(function () {
            $('#<%= btnShowReport.ClientID %>').click(function (event) {
                event.preventDefault();
                var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                    alert("Please select District");
                    return false;
                }
                var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
                if (ddlVehicle === '--select--') {
                    alert("Please select Vehicle");
                    return false;
                }
                var txtFirstDate = $('#<%= txtfrmDate.ClientID %>').val();
                var txtToDate = $('#<%= txttodate.ClientID %>').val();
                if (txtFirstDate === "") {
                    alert('From Date is Mandatory');
                    txtFirstDate.focus();
                    return false;
                }
                if (txtToDate === "") {
                    alert("End Date is Mandatory");
                    txtToDate.focus();
                    return false;
                }
                var fromDate = (txtFirstDate).replace(/\D/g, '/');
                var toDate = (txtToDate).replace(/\D/g, '/');
                var ordFromDate = new Date(fromDate); var ordToDate = new Date(toDate);
                var currentDate = new Date();
                if (ordFromDate > currentDate) {
                    alert("From date should not be greater than today's date");
                    return false;
                }
                if (ordToDate < ordFromDate) {
                    alert("Please select valid date range");
                    return false;
                }
                return true;
            });
            
        })
    </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lbldetailsreport" style="font-size: 20px; color: brown" runat="server" Text="Details&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>

    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 100px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>

            <td>
                <asp:Label ID="lblvehicle" runat="server" Text="Select&nbsp;Vehicle"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlvehicle" runat="server" style="width: 100px"></asp:DropDownList>
            </td>

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
                <asp:Button runat="server" Text="ShowReport" id="btnShowReport" ClientIDMode="static" OnClick="btnsubmit_Click"  OnClientClick="return func" ></asp:Button>
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



