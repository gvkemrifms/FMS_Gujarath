<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleInsuranceClaims.aspx.cs" Inherits="VehicleInsuranceClaims" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/VehicleInsuranceClaims.css" rel="stylesheet"/>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel runat="server">

                            <table>
                                <tr>
                                    <td class="rowspan"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvInsuranceClaim" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                      ForeColor="#333333" GridLines="None" OnRowCommand="gvInsuranceClaim_RowCommand"
                                                      CssClass="mydatagrid" PagerStyle-CssClass="pager"
                                                      HeaderStyle-CssClass="header" RowStyle-CssClass="rows" EmptyDataText="No Records Found" CellSpacing="2">
                                            <RowStyle CssClass="rowStyleGrid"/>
                                            <Columns>
                                                <asp:TemplateField HeaderText="Vehicle Number" Visible="True">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkBtnVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'
                                                                        CommandArgument='<%#DataBinder.Eval(Container.DataItem, "VehicleID") %>' CommandName="EditInsurance">
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Accident Title">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAccidentTitle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AccidentTitle") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Accident Date/Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAccidentDateTime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AccidentDateTime", "{0:dd-MM-yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Claim Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblClaimDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ClaimDate", "{0:dd-MM-yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Claim Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblClaimAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ClaimAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsuranceClaimsStatus") %>'></asp:Label>
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
                                    <td class="rowspan"></td>
                                </tr>
                            </table>

                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>