<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="InvoiceSubmissionToFinanceReport.aspx.cs" Inherits="InvoiceSubmissionToFinanceReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table>
    <tr>
        <td>
       <asp:Label ID="lblInvoiceSubmissionToFinanceReport" style="font-size:20px;color:brown" runat="server" Text="InvoiceSubmissionToFinance&nbsp;Report"></asp:Label> 
        </td>
    </tr>
    </table>
    
          <table style="width:70px;margin-left:125px;">
    <tr>
        
        <td>
           <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddldistrict" runat="server" style="width:100px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
        </td>

         <td>
            <asp:Label ID="lblvendor" runat="server" Text="Select&nbsp;Vendor"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddlvendor" runat="server" style="width:100px"></asp:DropDownList>
        </td>
   
   
        </table>
    
    <table>
        <td>
            <asp:Label ID="lblfromdate" runat="server" Text="FromDate"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtfrmDate" runat="server"></asp:TextBox>
        </td>
 <td>
     
<%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
<cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" TargetControlID="txtfrmDate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


 </td>
        <td>
            <asp:Label ID="lbltodate" runat="server" Text="To date"></asp:Label>
        </td>

 <td>
            <asp:TextBox ID="txttodate" runat="server"></asp:TextBox>
        </td>
 <td>
     
<%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
<cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy" TargetControlID="txttodate" Enabled="true" CssClass="cal_Theme1"></cc1:CalendarExtender>


 </td>
        <td>
            <asp:Button runat="server" Text="ShowReport" OnClick="btnsubmit_Click"></asp:Button>
        </td>
       
        <td>   
              <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button> 
         </td>
              
          
    </tr>
    
          </table>
    <div>
     <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" EmptyDataText="Records Not Available" runat="server" ShowHeaderWhenEmpty="true"></asp:GridView>
        </asp:Panel>
   </div>
</asp:Content>



