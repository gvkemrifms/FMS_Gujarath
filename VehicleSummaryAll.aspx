<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSummaryAll.aspx.cs" Inherits="VehicleSummaryAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
           <td>
                <asp:Button runat="server" Text="ExportExcel" ID="btntoExcel" OnClick="btntoExcel_Click"></asp:Button>

            </td>
         
          
        </tr>
    </table>
    <div>
           <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
        <asp:GridView ID="GrdtotalData" runat="server"></asp:GridView>
               </asp:Panel>
        </div>
</asp:Content>

