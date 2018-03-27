<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Reports.VehicleCardTypeReport, App_Web_m0x5b0wx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript" language="javascript">
    function validationFuelEntry() {

        var District = document.getElementById('<%= ddlDistrict.ClientID %>')
        if (District.selectedIndex == 0) {
            alert("Please select the District");
            Districts.focus();
            return false;
        }

        var SSN = document.getElementById('<%= ddlSSN.ClientID %>')
        if (SSN.selectedIndex == 0) {
            alert("Please select the Service Station Name");
            SSN.focus();
            return false;
        }
    }
   </script>
    <asp:UpdatePanel ID="updtpanlVehcardtypereport" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select District :
                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                        Service Station Name:
                        <asp:DropDownList ID="ddlSSN" runat="server" AutoPostBack="True" 
                            onselectedindexchanged="ddlSSN_SelectedIndexChanged" >
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="142px"
                            OnClick="btnExportToExcel_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleCardTypeReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

