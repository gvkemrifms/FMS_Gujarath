<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/temp.master" CodeFile="VehicleInsuranceViewHistory.aspx.cs" Inherits="VehicleInsuranceViewHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/VehicleInsuranceViewHistory.css" rel="stylesheet"/>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <table style="width: 100%">
                <tr>
                    <td align="center" style="font-size: small; font-weight: bold"></td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Panel runat="server">
                            <table>
                                <tr>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvViewHistory" runat="server" Width="630px" AutoGenerateColumns="False"
                                                      AllowPaging="True" CellPadding="4" ForeColor="#333333" EmptyDataText="No Records Found"
                                                      GridLines="Both" OnPageIndexChanging="gvViewHistory_PageIndexChanging" CssClass="mydatagrid" PagerStyle-CssClass="pager"
                                                      HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                                                      CellSpacing="2">
                                            <RowStyle CssClass="rowStyleGrid"/>
                                            <Columns>
                                                <asp:TemplateField HeaderText="Vehicle Number">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Start Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicyStartDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PolicyStartDate") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy End Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicyEndDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PolicyEndDate") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Agency">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsuranceAgency" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsAgency") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Policy No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsurancePolicyNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsurancePolicyNo") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Fees Paid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsuranceFeesPaid" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsuranceFeesPaid") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Receipt No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsuranceReceiptNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsuranceReceiptNo") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Fees Paid Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsuranceFeesPaidDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsuranceFeesPaidDate") %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Insurance Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInsuranceType" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InsuranceTypeName") %>'>
                                                        </asp:Label>
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
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="VehicleInsurance.aspx">VehicleInsurance</a>
                                    </td>
                                </tr>
                            </table>

                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>