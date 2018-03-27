<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSummaryRegionwise.aspx.cs" Inherits="VehicleSummaryRegionwise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
    <tr>
        <td>
       <asp:Label ID="lblregionalreport" style="font-size:20px;color:brown" runat="server" Text="vehicle&nbsp;summarys&nbsp;RegionwiseReport"></asp:Label> 
        </td>
    </tr>
    </table
   <table>
       
       <tr>
           <td>
           <asp:Label ID="lblregion" runat="server" Text="Select Region"></asp:Label>

               </td>
           <td>
               <asp:DropDownList ID="ddlregion" runat="server" style="width:100px" ></asp:DropDownList>
           </td>
       </tr>
       <td>
            <asp:Button runat="server" Text="ShowReport"></asp:Button>
        </td>
        
      
             <td>   
              <asp:Button runat="server" Text="ExportExcel"></asp:Button> 

             </td>
   </table>
</asp:Content>

