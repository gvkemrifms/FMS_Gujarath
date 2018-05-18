<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleTypes.aspx.cs" Inherits="VehicleTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validation() {
            switch (document.getElementById("<%= txtVehicleType.ClientID %>").value) {
            case '':
                alert("Please EnterVehicle Type");
                document.getElementById("<%= txtVehicleType.ClientID %>").focus();
                return false;
            }
            switch (document.getElementById("<%= txtVehicleDescription.ClientID %>").value) {
            case '':
                alert("Please Enter Vehicle Description");
                document.getElementById("<%= txtVehicleDescription.ClientID %>").focus();
                return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Vehicle Types</legend>
                            <asp:Panel ID="pnlvehicletypes" runat="server">
                                <table align="center" style="width: 500px;" title="Vehicle Types">
                                    <tr>
                                        <td align="left">
                                            Vehicle Type <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleType" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; Vehicle Type Description <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleDescription" runat="server" TextMode="MultiLine" Rows="3"
                                                         onKeyUp="CheckLength(this,300)" onChange="CheckLength(this,300)" onkeypress="return alphanumeric_withspace_only(event);">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnvehicleTypeSave" runat="server" Text="Save" OnClientClick="return validation();"
                                                        OnClick="vehicleTypeSave_Click"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="vehicleTypeReset" runat="server" Text="Reset" OnClick="vehicleTypeReset_Click"/>
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
                        <fieldset style="padding: 10px;">
                            <asp:GridView ID="grvVehicleTypes" runat="server" align="center" AllowPaging="True" BorderColor="Brown" BorderWidth="1px"
                                          PageSize="5" AutoGenerateColumns="False" CellPadding="3" CellSpacing="2" OnPageIndexChanging="grvVehicleTypes_PageIndexChanging"
                                          GridLines="Both" CssClass="gridviewStyle" OnRowEditing="grvVehicleTypes_RowEditing"
                                          Width="600px">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="Vehicle Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVehicleTypeId" runat="server" Text='<%#Eval("VehicleType_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle Type">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVehicleType" runat="server" Text='<%#Eval("Vehicle_Type") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="VehicleType Description">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_type" runat="server" Text='<%#Eval("Vehicle_TypeDesc") %>' TextMode="MultiLine"
                                                         Width="400px" ReadOnly="true" Rows="5">
                                            </asp:TextBox>
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
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
            <br/>
            <asp:HiddenField ID="hidVehicleType" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>