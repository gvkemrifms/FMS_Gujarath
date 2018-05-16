<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="MaintenanceAlert.aspx.cs" Inherits="MaintenanceAlert" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <style>
                .setposition {
                    overflow: hidden;
                    position: relative;
                }
            </style>
            <legend align="center" class="setposition" style="color: brown">Maintenance Service Alert </legend>
            <br/>
            <table align="center">
                <tr>
                    <td>
                        Select Vehicle <span style="color: red";>*</span>
                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicle" runat="server" AutoPostBack="true"
                                      Width="155px" style="margin: 25px" DropDownStyle="DropDownList"
                                      onselectedindexchanged="ddlVehicle_SelectedIndexChanged">
                        </cc1:ComboBox>
                    </td>
                </tr>
                <br/>
                <tr>
                    <td>
                        <asp:GridView ID="grdMaintAlert" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                      ForeColor="#333333" GridLines="Both" BorderWidth="1px" BorderColor="brown" Width="622px" AllowPaging="True" EmptyDataText="No Records Found"
                                      CssClass="setposition" CellSpacing="2" OnPageIndexChanging="grdMaintAlert_PageIndexChanging">
                            <RowStyle CssClass="rowStyleGrid"/>
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle Number" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%#Eval("VehicleNumber") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Latest Odometer" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%#Eval("Latest_odo") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Maintenance Odo">
                                    <ItemTemplate>
                                        <%#Eval("LastMaintenanceOdo") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Maintenance Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%#Eval("LastMaintenanceDate") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Service Alert">
                                    <ItemTemplate>
                                        <%#Eval("servicealert") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="footerStylegrid"/>
                            <PagerStyle CssClass="pagerStylegrid"/>
                            <SelectedRowStyle CssClass="selectedRowStyle"/>
                            <HeaderStyle CssClass="headerStyle"/>
                        </asp:GridView>
                    </td>
                </tr>

                <tr>
                    <td align="center" valign="middle">
                        <asp:Button runat="server" Text="Send Mail" CssClass="form-submit-button" OnClick="btnSendMail_Click1" OnClientClick="if (!validationFuelEntry()) return false;"/>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                function validationFuelEntry() {
                    var districts = document.getElementById("<%= ddlVehicle.ClientID %>").control._textBoxControl.value;
                    switch (districts) {
                    case '--Select--':
                        return alert("Please Select the VehicleNumber");
                    }
                    return true;
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>