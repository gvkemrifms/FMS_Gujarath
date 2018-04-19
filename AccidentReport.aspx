<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="AccidentReport.aspx.cs" Inherits="AccidentReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="Scripts/jquery-1.4.4.js"></script>
    <script src="Scripts/jquery.validate.js"></script>
 <script type="text/javascript">
   var func=  $(function () {
         $('#<%= btnShowReport.ClientID %>').click(function () {
             var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
             if (ddlDistrict === '--select--') {
                 alert("Please select District");
                 e.preventDefault();
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
             var currentDate = new Date();
             if (ordFromDate > currentDate) {
                 alert("From date should not be greater than today's date");
                 e.preventDefault();
             }
             if (ordToDate < ordFromDate) {
                 alert("Please select valid date range");
             }
         });
     })
 </script>
    <br/>
    <label id="displayValidationError" runat="server" style="color: red; display: block" clientidmode="Static">*</label>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblaccidentreport" Style="font-size: 20px; color: brown" runat="server" Text="Accident&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br/>

    <table style="width: 100px; margin-left: 175px;">
        <tr>
            <td >
                Select District
            </td>
            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" Style="width: 100px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>
            <td align="left">
                Select Vehicle
            </td>
          
            <td>
                <asp:DropDownList ID="ddlvehicle" runat="server" Style="width: 100px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td >
                FromDate <span style="color: Red">*</span>
            </td>

            <td>
                <asp:TextBox ID="txtfrmDate" runat="server"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" TargetControlID="txtfrmDate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>
            </td>
            <td>
                To date <span style="color: Red">*</span>
            </td>
            <td>
                <asp:TextBox ID="txttodate" runat="server"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy" TargetControlID="txttodate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>
            </td>
        </tr>

        <tr>
            <td>
                <asp:Button runat="server" id="btnShowReport" Text="ShowReport" OnClick="btnsubmit_Click" ClientIDMode="static" EnableViewState="True"  OnClientClick="return func"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button>
            </td>
            <td>
                <asp:HiddenField ID="HiddenFileldVariable" runat="server"/>
            </td>
        </tr>

    </table>
    <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
        <asp:GridView ID="Grddetails" runat="server"></asp:GridView>
    </asp:Panel>
</asp:Content>




