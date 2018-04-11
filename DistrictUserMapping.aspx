<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DistrictUserMapping.aspx.cs" Inherits="DistrictUserMapping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type="text/javascript">
        function validation() {
            var userList = document.getElementById('<%= ddlUserList.ClientID %>');

            switch (userList.selectedIndex) {
            case 0:
                alert("Please select User Name");
                userList.focus();
                return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>District User Mapping</legend>
                <table style="width: 100%">
                    <tr>
                        <td align="top" align="center">
                            <table>
                                <tr>
                                    <td align="center">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <table>
                                <tr>
                                    <td valign="top" nowrap="nowrap">
                                        &nbsp;<asp:Label ID="LblUser" runat="server" Text="UserName: "></asp:Label>
                                    </td>
                                    <td valign="top">
                                        <asp:DropDownList ID="ddlUserList" runat="server" OnSelectedIndexChanged="ddlUserList_SelectedIndexChanged"
                                                          AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 5%">
                                    </td>
                                    <td valign="top" nowrap="nowrap">
                                        <asp:Label ID="lblDistrict" runat="server" Text="District Name: "></asp:Label>
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:RadioButtonList ID="chkDistrictList" runat="server">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <asp:Button ID="btnMapping" runat="server" Text="Save" OnClick="btnMapping_Click"/>
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

