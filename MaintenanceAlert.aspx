<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="MaintenanceAlert.aspx.cs" Inherits="MaintenanceAlert" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="updtpnlMaintAlert" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Maintenance Service Alert </legend>
                            <table>
                                <tr>
                                    <td>
                                        Select Vehicle :
                                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicle" runat="server" AutoPostBack="true"
                                                      Width="155px" DropDownStyle="DropDownList"
                                                      onselectedindexchanged="ddlVehicle_SelectedIndexChanged">
                                        </cc1:ComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdMaintAlert" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                      ForeColor="#333333" GridLines="None" Width="622px" AllowPaging="True" EmptyDataText="No Records Found"
                                                      CssClass="gridviewStyle" CellSpacing="2" OnPageIndexChanging="grdMaintAlert_PageIndexChanging">
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
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" valign="middle">
                                        <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click1"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>