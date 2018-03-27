<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSummaryDistrictwise.aspx.cs" Inherits="VehicleSummaryDistrictwise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table>
        <tr>
            <td>
                <asp:Label ID="lblDistrictreport" Style="font-size: 20px; color: brown" runat="server" Text="vehicle&nbsp;summarys&nbsp;DistrictwiseReport"></asp:Label>
            </td>
        </tr>

    </table>

    <table>

        <tr>
            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select District"></asp:Label>

            </td>
            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" Style="width: 100px"></asp:DropDownList>
            </td>

            <td>
                <asp:Button runat="server" Text="ShowReport" ID="btnsubmit" OnClick="btnsubmit_Click"></asp:Button>
            </td>


            <td>
                <asp:Button runat="server" Text="ExportExcel" ID="btntoExcel" OnClick="btntoExcel_Click"></asp:Button>

            </td>
        </tr>

    </table>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GridInactive" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
     <div>
        <asp:Panel ID="Panel1" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GridActive" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

