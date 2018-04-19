<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="BillProcessingManagementReport.aspx.cs" Inherits="BillProcessingManagementReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function() {
            $('#<%=btnShowReport.ClientID%>').click(function() {
                var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                    alert("Please select District");
                    e.preventDefault();
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblBillProcessingManagementReport" style="font-size: 20px; color: brown" runat="server" Text="BillProcessingManagement&nbsp;Report"></asp:Label>
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
                <asp:Button runat="server" Text="ShowReport" ID="btnShowReport" OnClick="btnsubmit_Click"></asp:Button>
            </td>
            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button>

            </td>


        </tr>
    </table>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdtyre" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

