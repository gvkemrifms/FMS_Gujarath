<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Reports.EnquiryScreenReport, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="updtpnlEnquiryScreenReport" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Vehicle :
                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicle" runat="server" AutoPostBack="true"
                                Width="155px" OnSelectedIndexChanged="ddlVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                            </cc1:ComboBox>
                        
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
                        <iframe id="iframe_EnquiryScreenReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

