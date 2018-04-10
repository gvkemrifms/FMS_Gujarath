<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/temp.master" CodeFile="VehicleInsuranceViewHistory.aspx.cs" Inherits="VehicleInsuranceViewHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .mydatagrid {
            border: solid 2px black;
            min-width: 80%;
            width: 80%;
        }

        .header {
            background-color: #646464;
            border: none 0px transparent;
            color: White;
            font-family: Arial;
            font-size: 16px;
            height: 25px;
            text-align: center;
        }

        .rows {
            background-color: #fff;
            border: none 0px transparent;
            color: #000;
            font-family: Arial;
            font-size: 14px;
            min-height: 25px;
            text-align: left;
        }

            .rows:hover {
                background-color: #ff8000;
                color: #fff;
                font-family: Arial;
                text-align: left;
            }

        .selectedrow {
            background-color: #ff8000;
            color: #fff;
            font-family: Arial;
            font-weight: bold;
            text-align: left;
        }

        .mydatagrid a /** FOR THE PAGING ICONS  **/ {
            background-color: Transparent;
            color: #fff;
            font-weight: bold;
            padding: 5px 5px 5px 5px;
            text-decoration: none;
        }

            .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/ {
                background-color: #000;
                color: #fff;
            }

        .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/ {
            /*background-color: #c9c9c9;*/
            color: #000;
            padding: 5px 5px 5px 5px;
        }

        .pager {
            background-color: #646464;
            color: White;
            font-family: Arial;
            height: 30px;
            text-align: left;
        }

        .mydatagrid td {
            padding: 5px;
        }

        .mydatagrid th {
            padding: 5px;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                        <asp:Panel ID="pnlVehicleInsuranceViewHistory" runat="server">
                            <table>
                                <tr>
                                    <td class="rowspan"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvViewHistory" runat="server" Width="630px" AutoGenerateColumns="False"
                                            AllowPaging="True" CellPadding="4" ForeColor="#333333" EmptyDataText="No Records Found"
                                            GridLines="None" OnPageIndexChanging="gvViewHistory_PageIndexChanging" CssClass="mydatagrid" PagerStyle-CssClass="pager"
                                            HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                                            CellSpacing="2">
                                            <RowStyle CssClass="rowStyleGrid" />
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
                                            <FooterStyle CssClass="footerStylegrid" />
                                            <PagerStyle CssClass="pagerStylegrid" />
                                            <SelectedRowStyle CssClass="selectedRowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowspan"></td>
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
