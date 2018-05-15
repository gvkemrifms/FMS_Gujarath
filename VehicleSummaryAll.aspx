<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSummaryAll.aspx.cs" Inherits="VehicleSummaryAll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center">
        <tr>
            <td>
                <asp:Button runat="server" Text="ExportExcel" ID="btntoExcel" OnClick="btntoExcel_Click" CssClass="form-submit-button"></asp:Button>
            </td>
        </tr>
    </table>
    <br/>
    <div align="center" style="margin-top: 30px">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GrdtotalData" EmptyDataText="No rows to generate" ShowHeaderWhenEmpty="True" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>