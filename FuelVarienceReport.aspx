﻿<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelVarienceReport.aspx.cs" Inherits="FuelVarienceReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $('#<%= ddldistrict.ClientID %>').select2({
                disable_search_threshold: 5,
                search_contains: true,
                minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
            $('#<%= ddlvehicle.ClientID %>').select2({
                disable_search_threshold: 5,
                search_contains: true,
                minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
        }
        function Validations() {
            var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
            if (ddlDistrict === '--select--') {
                return alert("Please select District");
            }
            var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
            if (ddlVehicle === '--select--') {
                return alert("Please select Vehicle");
            }
            var ddlBunk = $('#<%= ddlbunk.ClientID %> option:selected').text().toLowerCase();
            if (ddlBunk === '--select--') {
                return alert("Please select the Station");
            }
            var txtFirstDate = $('#<%= txtfrmDate.ClientID %>').val();
            var txtToDate = $('#<%= txttodate.ClientID %>').val();
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
                return alert("Please select valid date range");
            }
            return true;
        }
    </script>
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblvariencereport" style="font-size: 20px; color: brown" runat="server" Text="Fuel Varience&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br/>
    <table align="center">
        <tr>

            <td>
                Select District <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="padding-right:20px;color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>
</tr>
        <tr>
            <td>
                Select Vehicle<asp:Label ID="lblvehicle" runat="server" Text="" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlvehicle" runat="server" style="width: 150px" AutoPostBack="true" OnSelectedIndexChanged="ddlvehicle_SelectedIndexChanged"></asp:DropDownList>
            </td>
        </tr>
            
        <tr>
            <td>
                Select Bunk<asp:Label ID="lblbunk" runat="server" Text="" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlbunk" runat="server" style="width: 150px;" CssClass="search_3"></asp:DropDownList>
            </td>
        </tr>
    </table>

    <table align="center">
        <tr>
            <td>
                From Date <asp:Label ID="lblfromdate" runat="server" Text="From Date" style="color: red">*</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtfrmDate" runat="server" Width="150px" CssClass="search_3"></asp:TextBox>
            </td>
            <td>
                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" TargetControlID="txtfrmDate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
            </tr>
        <tr>
            <td>
                To Date <asp:Label ID="lbltodate" runat="server" Text="To Date" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:TextBox ID="txttodate" runat="server" Width="150px" CssClass="search_3"></asp:TextBox>
            </td>
            <td>

                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy" TargetControlID="txttodate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


            </td>
        </tr>
          <tr>
              <td>
                  <asp:Button runat="server" Text="ShowReport" CssClass="form-submit-button" ID="btnShowReport"  OnClick="btnsubmit_Click" OnClientClick="if(!Validations()) return false;"></asp:Button>
              </td>

              <td>
                  <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
              </td>
          </tr>

    </table>
    <br />
    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" EmptyDataText="Records Not Available" runat="server" ShowHeaderWhenEmpty="true" BorderWidth="1px" BorderColor="brown"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

