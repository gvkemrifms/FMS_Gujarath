<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="MaintenanceWorksServiceGroup.aspx.cs" Inherits="MaintenanceWorksServiceGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script  type="text/javascript">
        function validationMaintenanceWorksServiceGroup() {
            switch (document.getElementById("<%= txtServiceGroupName.ClientID %>").value) {
            case "":
                
                document.getElementById("<%= txtServiceGroupName.ClientID %>").focus();
                return alert("Please Enter Service Group Name");
            }
            switch (document.getElementById("<%= ddlManufacturerName.ClientID %>").selectedIndex) {
            case 0:

                document.getElementById("<%= ddlManufacturerName.ClientID %>").focus();
                return alert("Please Select Manufacturer Name");
            }
            return true;
        }

        function OnlyAlphabets(myfield, e, dec) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode === 32);
        }

    </script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px;">
                            <legend>Maintenance Works-Service Group</legend>
                            <asp:Panel ID="pnlmaintenanceworksServiceGrp" runat="server">
                                <table style="height: 119px; width: 99%;" align="center">
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px" align="left">
                                            Service Group Name <span style="color: Red">*</span> &nbsp;
                                        </td>
                                        <td style="width: 400px">
                                            <asp:TextBox ID="txtServiceGroupName" runat="server" Height="18px" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 140px" align="left">
                                            Manufacturer Name <span style="color: Red">*</span> &nbsp;
                                        </td>
                                        <td style="width: 400px">
                                            <asp:DropDownList ID="ddlManufacturerName" runat="server" Height="20px" Width="127px">
                                            </asp:DropDownList>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 58px; width: 140px;"></td>
                                        <td style="height: 58px; width: 400px;">
                                            <asp:Button ID="btnSaveMaintenanceWorksServiceGroup" runat="server" Text="Save"
                                                        OnClick="btnSaveMaintenanceWorksServiceGroup_Click" OnClientClick="if(!validationMaintenanceWorksServiceGroup()) return false;"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnResetMaintenanceWorksServiceGroup" runat="server" Text="Reset"
                                                        OnClick="btnResetMaintenanceWorksServiceGroup_Click"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnCancelMaintenanceWorksServiceGroup" runat="server" Text="Cancel"
                                                        PostBackUrl="~/FleetMaster/MaintenanceWorksMaster.aspx"/>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <asp:GridView ID="grvMaintenanceWorksServiceGroupDetails" runat="server" AllowPaging="True"
                                          PageSize="5" AutoGenerateColumns="False" CellPadding="3" CellSpacing="2" GridLines="None"
                                          CssClass="gridviewStyle" OnPageIndexChanging="grvMaintenanceWorksServiceGroupDetails_PageIndexChanging"
                                          OnRowEditing="grvMaintenanceWorksServiceGroupDetails_RowEditing">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="Service Group Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblServiceId" runat="server" Text='<%#Eval("ServiceGroup_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Service Group Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblServiceGroupName" runat="server" Text='<%#Eval("ServiceGroup_Name") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manufacturer ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblServiceName" runat="server" Text='<%#Eval("Manufacturer_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manufacturer Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblManufacturerName" runat="server" Text='<%#Eval("FleetManufacturer_Name") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Created_Date", "{0:d}") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Edit"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid"/>
                                <PagerStyle CssClass="pagerStylegrid"/>
                                <SelectedRowStyle CssClass="selectedRowStyle"/>
                                <HeaderStyle CssClass="headerStyle"/>
                            </asp:GridView>
                        </fieldset>
                        <asp:HiddenField ID="hidSerGrpId" runat="server"/>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>