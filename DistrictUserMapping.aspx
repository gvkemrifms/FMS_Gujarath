<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DistrictUserMapping.aspx.cs" Inherits="DistrictUserMapping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">  
    <script type="text/javascript">
        function pageLoad() {
            $('#<%= ddlUserList.ClientID %>').chosen({ disable_search_threshold: 5, search_contains: true });
        }
    </script>
    <script  type="text/javascript">
               
        function validation() {
            var userList = document.getElementById('<%= ddlUserList.ClientID %>');

            switch (userList.selectedIndex) {
            case 0:
                return alert("Please select User Name");
                      
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
                                        <asp:DropDownList ID="ddlUserList" runat="server" Width="150px" OnSelectedIndexChanged="ddlUserList_SelectedIndexChanged" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 5%">
                                    </td>
                                    <td valign="top" nowrap="nowrap">
                                        <asp:Label ID="lblDistrict" runat="server" Text="District Name: "></asp:Label>
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:RadioButtonList ID="chkDistrictList" width="250px" runat="server">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <asp:Button ID="btnMapping" runat="server" Text="Save" CssClass="form-submit-button" OnClick="btnMapping_Click" OnClientClick="if(!validation()) return false;"/>
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="form-reset-button" OnClick="btnCancel_Click"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

