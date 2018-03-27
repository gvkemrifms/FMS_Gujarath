<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Reports.EquipmentDetailsReport, App_Web_fbb3hqmh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:UpdatePanel ID="updtpnlEquipmentDetailsReport" runat="server">
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
                        <iframe id="iframe_EquipmentDetailsReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

