<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="InvoiceTrackingReport.aspx.cs" Inherits="InvoiceTrackingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
            <asp:Button runat="server" Text="ShowReport"></asp:Button>
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

