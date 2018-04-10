<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleCardTypeReport.aspx.cs" Inherits="VehicleCardTypeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validationFuelEntry() {

            var district = document.getElementById('<%= ddlDistrict.ClientID %>');
            switch (district.selectedIndex) {
                case 0:
                    alert("Please select the District");
                    window.Districts.focus();
                    return false;
            }

            var ssn = document.getElementById('<%= ddlSSN.ClientID %>');
            switch (ssn.selectedIndex) {
                case 0:
                    alert("Please select the Service Station Name");
                    ssn.focus();
                    return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel ID="updtpanlVehcardtypereport" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td>Select District :
                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td>Service Station Name:
                        <asp:DropDownList ID="ddlSSN" runat="server" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlSSN_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td>
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="142px"
                            OnClick="btnExportToExcel_Click" />
                    </td>
                </tr>
                <tr>
                    <td></td>
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

