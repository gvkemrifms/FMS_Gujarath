<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="CostingAnalysisReport.aspx.cs" Inherits="CostingAnalysisReport" %>
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
            $('#<%= ddlvehicle.ClientID %>').select2({
                disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 2, 
                placeholder: "Select an option"
            });
        });
        function Validations() {
            var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
            if (ddlDistrict === '--select--') 
                return alert("Please select District");

            var ddlVehicle = $('#<%= ddlvehicle.ClientID %> option:selected').text().toLowerCase();
            if (ddlVehicle === '--select--') 
                return alert("Please select Vehicle");
            return true;
        }
    </script>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblcostinganalysisreport" style="font-size: 20px; color: brown" runat="server" Text="CostingAnalysis&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>

    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td>
              Select District  <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px" AutoPostBack="true" OnSelectedIndexChanged="ddldistrict_SelectedIndexChanged"></asp:DropDownList>
            </td>
</tr>
        <tr>
            <td>
               Select Vehicle <asp:Label ID="lblvehicle" runat="server" Text="Select&nbsp;Vehicle" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddlvehicle" runat="server" style="width: 150px"></asp:DropDownList>
            </td>      
        </tr>
           <tr>
               <td>
                   <asp:Button runat="server" Text="ShowReport" id="btnShowReport" OnClick="btnsubmit_Click" CssClass="form-submit-button" OnClientClick="if(!Validations()) return false;"></asp:Button>
               </td>

               <td>
                   <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
               </td>
           </tr>
    </table>
    <br/>
    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdcosdetails" runat="server" BorderWidth="1px" BorderColor="brown"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

