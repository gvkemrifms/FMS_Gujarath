﻿<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="InvoiceTrackingReport.aspx.cs" Inherits="InvoiceTrackingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $('#<%= ddlvehicle.ClientID %>').select2({
                disable_search_threshold: 5,
                search_contains: true,
                minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
        }

        function Validations() {
            var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
            if (ddlVehicle === '--select--') {
                return alert("Please select Vehicle");
            }

            var ddlBillNo = $('#<%= ddlbillno.ClientID %> option:selected').text().toLowerCase();
            if (ddlBillNo === '--select--') {
                return alert("Please select Bill");
            }
            return true;
        }
    </script>
    <table align="center">
    <tr>
        <td>
       <asp:Label ID="lblInvoiceTrackingReport" style="font-size:20px;color:brown" runat="server" Text="InvoiceTracking&nbsp;Report"></asp:Label> 
        </td>
    </tr>
    </table>
    <br/>
          <table align="center">
    <tr>
        
        <td>
            Select Vehicle <asp:Label ID="lblvehicle" runat="server" Text="" style="color: red">*</asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddlvehicle" runat="server" style="width:150px" AutoPostBack="true" OnSelectedIndexChanged="ddlvehicle_SelectedIndexChanged"></asp:DropDownList>
        </td>
</tr>
              <tr>
                  <td>
                      Select Bill Number <asp:Label ID="lblbillno" runat="server" Text="Select&nbsp;billnumber"  style="color: red">*</asp:Label>              
                  </td>
        
                  <td>
                      <asp:DropDownList ID="ddlbillno" runat="server" CssClass="search_3" style="width:150px"></asp:DropDownList>
                  </td>
              </tr>
              <tr>
                  <td>
                      <asp:Button runat="server" Text="ShowReport" CssClass="form-submit-button" ID="btnShowReport" OnClientClick="if(!Validations()) return false;"></asp:Button>
                  </td>
       
                  <td>   
                      <asp:Button runat="server" CssClass="form-reset-button" Text="ExportExcel"></asp:Button> 
                  </td>
              </tr>
        
    
   
        </table>
    <br />
     <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" runat="server" BorderWidth="1px" BorderColor="brown"></asp:GridView>
        </asp:Panel>
    </div>

    
</asp:Content>

