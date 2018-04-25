<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="EquipmentDetailsRepornew.aspx.cs" Inherits="EquipmentDetailsRepornew" %>
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
            if (ddlDistrict === '--select--') {
                return alert("Please select District");
            }
            return true;
        }
    </script>
 
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblcardtypereport" style="font-size: 20px; color: brown" runat="server" Text="Equipment&nbsp;Details&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <table align="center">
        <tr>

            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
            </tr>
        </table>
    <br/>
    <div align="center">
            <asp:Button runat="server" Text="ShowReport" ID="btnShowReport" OnClick="btnsubmit_Click" CssClass="form-submit-button" OnClientClick="if(!Validations()) return false;"></asp:Button>

            <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
    </div>
       

    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdtyre" runat="server" BorderWidth="1px" BorderColor="brown" style="margin-top: 20px"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

