<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DetailedWithVehicleModelReport.aspx.cs" Inherits="DetailedWithVehicleModelReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
       var func= $(function() {
            $('#<%= btnShowReport.ClientID %>').click(function() {
                var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                    alert("Please select District");
                    e.preventDefault();
                }
            });
        });
    </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblDetailedWithVehicleModelReport" style="font-size: 20px; color: brown" runat="server" Text="DetailedWithVehicleModel&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 100px"></asp:DropDownList>
            </td>
            <td>
                <asp:Button runat="server" Text="ShowReport" id="btnShowReport" OnClick="btnsubmit_Click" ClientIDMode="static" EnableViewState="True" OnClientClick="return func"></asp:Button>
            </td>
            <td>
                <asp:Button runat="server" Text="ExportExcel" onclick="btntoExcel_Click"></asp:Button>
            </td>
        </tr>
    </table>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdvehmodel" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>


