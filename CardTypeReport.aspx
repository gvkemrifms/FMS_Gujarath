<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="CardTypeReport.aspx.cs" Inherits="CardTypeReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
   <script type="text/javascript">
       $(function() {
           $('#<%=btnShowReport.ClientID%>').click(function() {
               var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
               var ddlStation = $('#<%= ddlstation.ClientID %> option:selected').text().toLowerCase();
               if (ddlDistrict === '--select--') {
                   alert("Please select District");
                   e.preventDefault();
               }
              
               if (ddlStation === '--select--') {
                   alert("Please select Vehicle");
                   e.preventDefault();
               }
           });
       });
   </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblcardtypereport" style="font-size: 20px; color: brown" runat="server" Text="Card&nbsp;Type&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td>
                <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 100px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>

            <td>
                <asp:Label ID="lblstation" runat="server" Text="Select&nbsp;Service&nbsp;Station"></asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlstation" runat="server" style="width: 100px"></asp:DropDownList>
            </td>

            <td>
                <asp:Button runat="server" Text="ShowReport" id="btnShowReport" OnClick="btnsubmit_Click"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button>
            </td>


        </tr>
    </table>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GrdcardData" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>