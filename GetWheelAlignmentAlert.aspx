<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="GetWheelAlignmentAlert.aspx.cs" Inherits="GetWheelAlignmentAlert" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <fieldset style="padding: 10px">
                            <legend>
                                <asp:Label ID="lblheader" runat="server"></asp:Label>
                            </legend>
                            <table>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdWheelAlignment" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                      ForeColor="#333333" GridLines="Both" Width="622px" AllowPaging="True" EmptyDataText="No Records Found"
                                                      CssClass="gridviewStyle" CellSpacing="2" OnPageIndexChanging="grdWheelAlignment_PageIndexChanging">
                                            <RowStyle CssClass="rowStyleGrid"/>
                                            <Columns>
                                                <asp:TemplateField HeaderText="Distict">
                                                    <ItemTemplate>
                                                        <%#Eval("DistrictName") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Vehicle Number">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnk_VehicleNumeber" runat="server" Text='<%#Eval("VehicleNumber") %>'
                                                                        OnCommand="lnk_VehicleNumeber_Click" CommandArgument='<%#Eval("vehicleID") %> '>
                                                        </asp:LinkButton>
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
                                        <asp:Button runat="server" Text="Send Mail" OnClick="btnSendMail_Click" CssClass="form-submit-button"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>