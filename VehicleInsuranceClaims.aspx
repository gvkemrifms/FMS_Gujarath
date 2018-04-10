<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleInsuranceClaims.aspx.cs" Inherits="VehicleInsuranceClaims" %>

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
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlVehicleInsuranceClaims" runat="server">

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
                                            <RowStyle CssClass="rowStyleGrid" />
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
