<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="CardTypeReport.aspx.cs" Inherits="CardTypeReport" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <script type="text/javascript">
       $(function () {
           $('#<%= ddldistrict.ClientID %>').select2({
               disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 2,
               placeholder: "Select an option"
           });
           $('#<%= ddlstation.ClientID %>').select2({
               disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 2,
               placeholder: "Select an option"
           });

       });
       function Validations() {
           var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
           var ddlStation = $('#<%= ddlstation.ClientID %> option:selected').text().toLowerCase();
           if (ddlDistrict === '--select--')
               return alert("Please select District");          
           if (ddlStation === '--select--') 
               return alert("Please select Station");
           return true;
       }

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
                Select District<asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>
</tr>
        <tr>
            <td>
                Select Station <asp:Label ID="lblstation" runat="server" Text="Select&nbsp;Service&nbsp;Station" style="color: red;margin-top: 20px">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlstation" runat="server" style="width: 200px;margin-top: 20px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button runat="server" Text="ShowReport" id="btnShowReport" CssClass="form-submit-button" OnClick="btnsubmit_Click" OnClientClick="if(!Validations()) return false;"></asp:Button>
            </td>

            <td>
                <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"  CssClass="form-reset-button"></asp:Button>
            </td>
        </tr>
    </table>
    <br/>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="GrdcardData" runat="server" BorderWidth="1px" BorderColor="brown"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>