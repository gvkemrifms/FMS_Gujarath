<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelDetailsVerification.aspx.cs" Inherits="FuelDetailsVerification" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="js/Validation.js"></script>
    <table>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="padding: 10px">
                    <legend>Fuel Detail Verification</legend>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td align="right">

                                        <asp:Label ID="Label1" runat="server" Text="Select Vehicle"></asp:Label>
                                        <span style="color: Red">*</span>

                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlVehicleNumber" runat="server" AutoPostBack="True"
                                                          onselectedindexchanged="ddlVehicleNumber_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="rowseparator">
                                    <td align="right">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="gvVerification" runat="server" AutoGenerateEditButton="False" AutoGenerateColumns="false"
                                                      GridLines="None" CssClass="gridviewStyle" Width="434px" CellPadding="3" CellSpacing="2"
                                                      OnRowEditing="gvVerification_RowEditing"
                                                      EmptyDataText="No Records to Approve/Reject" AllowPaging="True"
                                                      onpageindexchanging="gvVerification_PageIndexChanging1" Caption="Fuel Entry Details" CaptionAlign="Top">
                                            <RowStyle CssClass="rowStyleGrid"/>
                                            <Columns>
                                                <asp:TemplateField HeaderText="Check">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="checkSelect" runat="server"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField DataField="vehno" HeaderText="Vehicle"/>
                                                <asp:BoundField DataField="EntryDate" HeaderText="Date"/>
                                                <asp:BoundField DataField="Qty" HeaderText="Quaantity"/>
                                                <asp:BoundField DataField="Price" HeaderText="UnitPrice"/>
                                                <asp:BoundField DataField="Amount" HeaderText="Amount"/>
                                                <asp:BoundField DataField="KMPL" HeaderText="KMPL"/>
                                                <asp:TemplateField HeaderText="Remarks">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="30" onkeypress="return remark(event);"></asp:TextBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FuelEntryID") %>' Visible="false"></asp:Label>

                                                    </ItemTemplate>

                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid"/>
                                            <PagerStyle CssClass="pagerStylegrid"/>
                                            <SelectedRowStyle CssClass="selectedRowStyle"/>
                                            <HeaderStyle CssClass="headerStyle"/>
                                        </asp:GridView>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <br/>
                                        <asp:GridView ID="gvReconcilation" runat="server" AutoGenerateEditButton="False" AutoGenerateColumns="false"
                                                      GridLines="None" CssClass="gridviewStyle" Width="434px" CellPadding="3" CellSpacing="2"
                                                      OnRowEditing="gvReconcilation_RowEditing"
                                                      EmptyDataText="No Records to Approve/Reject" AllowPaging="True"
                                                      onpageindexchanging="gvReconcilation_PageIndexChanging1" Caption="Reconciliation Details" CaptionAlign="Top">
                                            <RowStyle CssClass="rowStyleGrid"/>
                                            <Columns>
                                                <asp:TemplateField HeaderText="Check">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="checkSelect" runat="server"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle"/>
                                                <asp:BoundField DataField="AccountID" HeaderText="Account"/>
                                                <asp:BoundField DataField="Dealer" HeaderText="Dealer"/>
                                                <asp:BoundField DataField="Location" HeaderText="Location"/>
                                                <asp:BoundField DataField="TransactionDate" HeaderText="Date"/>
                                                <asp:BoundField DataField="Amount" HeaderText="Amount"/>
                                                <asp:BoundField DataField="Quantity" HeaderText="Quantity"/>
                                                <asp:TemplateField Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Rblid" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TransactionID") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid"/>
                                            <PagerStyle CssClass="pagerStylegrid"/>
                                            <SelectedRowStyle CssClass="selectedRowStyle"/>
                                            <HeaderStyle CssClass="headerStyle"/>
                                        </asp:GridView>
                                        <br/>
                                        <br/>
                                        <table align="left" style="width: 66%">
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="Approve" runat="server" Text="Approve" OnClick="Approve_Click"/>
                                                    <asp:Button ID="btnHdnApprove" runat="server" onclick="btnHdnApprove_Click" style="display: none;"/>

                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="Reject" runat="server" Text="Reject" OnClick="Reject_Click"/>
                                                    <asp:Button ID="btnHdnReject" runat="server" onclick="btnHdnReject_Click" style="display: none;"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
    </table>
</asp:Content>

