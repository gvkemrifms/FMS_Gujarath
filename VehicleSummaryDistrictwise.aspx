<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSummaryDistrictwise.aspx.cs" Inherits="VehicleSummaryDistrictwise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $('#<%= ddldistrict.ClientID %>').select2({
                disable_search_threshold: 5,
                search_contains: true,
                minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
        }
    </script>
    <table align="center">
        <tr>
            <td>
                <asp:Label Style="color: brown; font-size: 20px;" runat="server" Text="Vehicle Summary Districtwise Report"></asp:Label>
            </td>
        </tr>

    </table>
    <br/>
    <table align="center">

        <tr style="margin-top: 70px">
            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select District"></asp:Label>

            </td>
            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" Style="width: 150px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button runat="server" Text="ShowReport" ID="btnsubmit" CssClass="form-submit-button" OnClick="btnsubmit_Click"></asp:Button>
            </td>


            <td>
                <asp:Button runat="server" Text="ExportExcel" ID="btntoExcel" CssClass="form-reset-button" OnClick="btntoExcel_Click"></asp:Button>

            </td>
        </tr>

    </table>
    <br/>

    <div align="center" style="margin-top: 20px">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <h4 align="left" style="color: brown">Inactive Vehicles</h4>
            <asp:GridView ID="GridInactive" EmptyDataText="No rows to display" ShowHeaderWhenEmpty="True" BorderWidth="1px" BorderColor="brown" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
    <br/>

    <div align="center">
        <asp:Panel ID="Panel1" runat="server" Style="margin-left: 2px;">
            <h4 align="left" style="color: brown">Active Vehicles</h4>
            <asp:GridView ID="GridActive" EmptyDataText="No rows to display" ShowHeaderWhenEmpty="True" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>