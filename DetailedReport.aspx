<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DetailedReport.aspx.cs" Inherits="DetailedReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        $(function() {
            $('#<%= ddldistrict.ClientID %>').chosen();
        });
        function Validations() {
            var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
            if (ddlDistrict === '--select--') 
                return alert("Please select District");
            var txtFirstDate = $('#<%= txtfrmDate.ClientID %>').val();
            var txtToDate = $('#<%= txttodate.ClientID %>').val();
            if (txtFirstDate === "") 
                return alert('From Date is Mandatory');;
            if (txtToDate === "")
                return alert("End Date is Mandatory");
            var fromDate = (txtFirstDate).replace(/\D/g, '/');
            var toDate = (txtToDate).replace(/\D/g, '/');
            var ordFromDate = new Date(fromDate);
            var ordToDate = new Date(toDate);
            var currentDate = new Date();
            if (ordFromDate > currentDate) 
                return alert("From date should not be greater than today's date");
            
            if (ordToDate < ordFromDate) 
                alert("Please select valid date range");
            return true;
        }
    </script>
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblDetailedReport" style="font-size: 20px; color: brown" runat="server" Text="Detailed&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br/>
    <table align="center">
        <tr>

            <td>
                Select District<asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
        </tr>

        <tr>
            <td>
                From Date<asp:Label ID="lblfromdate" runat="server" Text="FromDate" style="color: red">*</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtfrmDate" runat="server" CssClass="search_3"></asp:TextBox>
            </td>
            <td>

                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" TargetControlID="txtfrmDate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
            </tr>
        <tr>
            <td>
                To date<asp:Label ID="lbltodate" runat="server" Text="To date" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:TextBox ID="txttodate" runat="server"  CssClass="search_3"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy" TargetControlID="txttodate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
        </tr>
           <tr>
            <td>
                <asp:Button runat="server" Text="ShowReport" ID="btnShowReport" OnClick="btnSubmit_Click" CssClass="form-submit-button" OnClientClick="if(! Validations()) return false;"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
            </td>
        </tr>

    </table>
    <br/>
    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddtreport" EmptyDataText="Records Not Available" runat="server" ShowHeaderWhenEmpty="true" BorderWidth="1px" BorderColor="brown"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>



