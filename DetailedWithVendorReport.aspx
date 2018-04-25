<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DetailedWithVendorReport.aspx.cs" Inherits="DetailedWithVendorReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        $(function() {
            $('#<%= ddldistrict.ClientID %>').chosen();
        });
        function Validations() {
            var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
            if (ddlDistrict === '--select--')
                return alert("Please select District");
            return true;
        }
    </script>
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblDetailedWithVendorReport" style="font-size: 20px; color: brown" runat="server" Text="DetailedWithVendor&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br/>
    <table align="center" >
        <tr>
            <td>
                Select District<asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
            </tr>
        <tr>
            <td>
                <asp:Button runat="server" Text="ShowReport" id="btnShowReport" OnClick="btnsubmit_Click" CssClass="form-submit-button" OnClientClick="if(!Validations()) return false;"></asp:Button>
            </td>
            <td>
            <asp:Button runat="server" Text="ExportExcel" onclick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
            </td>
        </tr>
    </table>
    <br/>
    <br/>
    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdvendor" runat="server" BorderColor="brown" BorderWidth="1px"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>



