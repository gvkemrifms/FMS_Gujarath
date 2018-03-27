<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Admin.DistrictUserMapping, App_Web_fbb3hqmh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script language="javascript" type="text/javascript">
function validation()
{
var UserList=document.getElementById('<%= ddlUserList.ClientID %>');
           
             if (UserList.selectedIndex == 0) 
             {
                alert("Please select User Name");
                UserList.focus();
                return false;
             }
        
}
    </script>

    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>District User Mapping</legend>
                <table style="width: 100%">
                    <tr>
                        <td valign="top" align="center">
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
                                        <%-- <asp:CheckBoxList ID="chkDistrictList" runat="server">
                                        </asp:CheckBoxList>--%><asp:RadioButtonList ID="chkDistrictList" runat="server">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <asp:Button ID="btnMapping" runat="server" Text="Save" OnClick="btnMapping_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

