<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="InvoiceTrackingReport.aspx.cs" Inherits="InvoiceTrackingReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        var func=  $(function () {
            $('#<%= btnShowReport.ClientID %>').click(function () {
                var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
                if (ddlVehicle === '--select--') {
                    alert("Please select Vehicle");
                    e.preventDefault();
                }

                var ddlBillNo = $('#<%= ddlbillno.ClientID %> option:selected').text().toLowerCase();
                if (ddlBillNo === '--select--') {
                    alert("Please select Bill");
                    e.preventDefault();
                }
               
            });
        })
    </script>
    <table>
    <tr>
        <td>
       <asp:Label ID="lblInvoiceTrackingReport" style="font-size:20px;color:brown" runat="server" Text="InvoiceTracking&nbsp;Report"></asp:Label> 
        </td>
    </tr>
    </table>
    
          <table style="width:70px;margin-left:125px;">
    <tr>
        
        <td>
           <asp:Label ID="lblvehicle" runat="server" Text="Select&nbsp;Vehicle"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddlvehicle" runat="server" style="width:100px" AutoPostBack="true" OnSelectedIndexChanged="ddlvehicle_SelectedIndexChanged"></asp:DropDownList>
        </td>

         <td>
            <asp:Label ID="lblbillno" runat="server" Text="Select&nbsp;billnumber"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddlbillno" runat="server" style="width:100px"></asp:DropDownList>
        </td>
    <td>
            <asp:Button runat="server" Text="ShowReport" ID="btnShowReport"></asp:Button>
        </td>
       
        <td>   
              <asp:Button runat="server" Text="ExportExcel"></asp:Button> 
         </td>
   
        </table>
     <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" runat="server"></asp:GridView>
        </asp:Panel>
    </div>

    
</asp:Content>

