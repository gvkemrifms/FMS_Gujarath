<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="Ageing_Reportnew.aspx.cs" Inherits="AgeingReportnew" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type ="text/javascript">
        $(function() {
            $('#<%= ddldistrict.ClientID %>').chosen();
        });
        function Validations() 
            {
                var ddlDistrict = $('#<%=ddldistrict.ClientID%> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                   return alert("Please select District");
                }
            return true;
        };
      
    </script>  
    <table>
        <tr>
            <td>
                <asp:Label ID="lblcardtypereport" style="font-size: 20px; color: brown" runat="server" Text="Ageing&nbsp;DetailsReport"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
    </table>
    <table style="width: 70px; margin-left: 125px;">
        <tr>

            <td >            
                Select  District<span style="color: Red; width: 150px; ">*</span>             
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
            </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btnSubmit" CssClass="form-submit-button" Text="ShowReport" OnClick="btnsubmit_Click" OnClientClick="if(!Validations()) return false;"></asp:Button>
                </td>
                <td>
                    <asp:Button runat="server" Text="ExportExcel" CssClass="form-reset-button" OnClick="btntoExcel_Click"></asp:Button>

                </td>

            </tr>
    </table>

    <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;margin-top:30px">
            <asp:GridView ID="Grdtyre" runat="server" BorderStyle="Inset" BorderColor="cyan" BorderWidth="2px"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

