<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="TyreAndBatteryDistrictWise.aspx.cs" Inherits="TyreAndBatteryDistrictWise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        $(function() {
            $('#<%= ddldistrict.ClientID %>').select2({
                disable_search_threshold: 5,
                search_contains: true,
                minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });

        });
    </script>

    <table>
        <tr>
            <td>
                <asp:Label Style="color: brown; font-size: 20px;" runat="server" Text="Tyre And Battery District wise Details Report"></asp:Label>
            </td>
        </tr>
    </table>
    <table align="center">
        <tr>

            <td>
                Select District<asp:Label ID="lbldistrict" runat="server" Text="" style="color: red"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" Style="width: 150px"></asp:DropDownList>
            </td>
        </tr>
        <tr>

            <td>
                <asp:Button runat="server" CssClass="form-submit-button" Text="ShowReport" OnClick="btnsubmit_Click"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" CssClass="form-reset-button" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button>
            </td>
        </tr>
    </table>
    <br/>
    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GrdtyreBattery" BorderColor="Brown" BorderWidth="1px" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>