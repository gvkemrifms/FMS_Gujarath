<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleAgeingReport.aspx.cs" Inherits="VehicleAgeingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="updtpnlVehicleAgeingReport" runat="server">
        <ContentTemplate>
            <legend align="center" style="color:brown"> Vehicle Ageing Report</legend>
            <table align="center">            
                <tr>
                    <td>
                        Select District<span style="color:red">*</span>
                        </td>
                    <td>
                          <asp:DropDownList ID="ddlDistrict" CssClass="search_3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                        </td>                      
                   <tr>
 <td>
                        <asp:Button ID="btnExportToExcel" CssClass="form-submit-button" runat="server" Text="Export To Excel" Width="142px"
                                    OnClick="btnExportToExcel_Click"/>
                    </td>
                   </tr>

            </table>
            <br />
            <table align="center" style="margin-top:20px">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleAgeingReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

