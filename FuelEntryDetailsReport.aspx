<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelEntryDetailsReport.aspx.cs" Inherits="FuelEntryDetailsReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table>
    <tr>
        <td>
       <asp:Label ID="lblfuelentryreport" style="font-size:20px;color:brown" runat="server" Text="FuelEntry&nbsp;Details&nbsp;Report"></asp:Label> 
        </td>
    </tr>
    </table>
     <table style="width:70px;margin-left:125px;">
    <tr>
        
        <td>
<asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddldistrict" runat="server" style="width:100px"></asp:DropDownList>
        </td>

        
 
         
        
        <td>
            <asp:Button runat="server" Text="ShowReport" OnClick="btnsubmit_Click"></asp:Button>
        </td>
        
      
             <td>   
              <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button> 

             </td>
              
          
    </tr>
    </table>
     <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" EmptyDataText="Records Not Available" runat="server" ShowHeaderWhenEmpty="true"></asp:GridView>
        </asp:Panel>
   
</asp:Content>

