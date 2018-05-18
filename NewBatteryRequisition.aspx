<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="NewBatteryRequisition.aspx.cs" Inherits="NewBatteryRequisition" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<script type="text/javascript">
    function validationInventoryBatteryVehicleType() {
        var value = document.getElementById("<%= ddlInventoryVehicles.ClientID %>").control._textBoxControl.value;
        if (value === "")
            return alert("Please select Vehicle");
        return true;
    }


</script>
<fieldset style="padding: 10px">
<legend align="center" style="color: brown">Battery Requisition</legend>
<table align="center">
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr align="center">
        <td>
            <asp:Panel ID="pnlNewBatteryRequisition" runat="server">
                <table>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label runat="server" Text="Vehicles"></asp:Label>
                            <span style="color: Red">*</span>
                            <ajaxToolkit:ComboBox AutoCompleteMode="Append" ID="ddlInventoryVehicles" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlInventoryVehicles_SelectedIndexChanged" DropDownStyle="DropDownList">
                            </ajaxToolkit:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="grvInventoryNewBatteryRequisition" runat="server" CellPadding="3"
                                          EmptyDataText="Details are not available" CellSpacing="2" GridLines="None" CssClass="gridviewStyle"
                                          AutoGenerateColumns="False">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk" runat="server" Enabled='<%# !Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled") == DBNull.Value ? 0 : 1) %>'/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Battery Position" DataField="BatteryPosition"/>
                                    <asp:BoundField HeaderText="Battery Number" DataField="BatteryNumber"/>
                                    <asp:BoundField HeaderText="Make" DataField="BatteryMake"/>
                                    <asp:BoundField HeaderText="Battery Model Capacity" DataField="BatteryModelCapacity"/>
                                    <asp:BoundField HeaderText="Issued Date " DataField="IssueDate" DataFormatString="{0:MM/dd/yyyy}"/>
                                    <asp:BoundField HeaderText="TotalKmRun" DataField="IssueOdoReading"/>
                                    <asp:TemplateField HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Enabled='<%# !Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled") == DBNull.Value ? 0 : 1) %>'
                                                         Text='<%# DataBinder.Eval(Container.DataItem, "Enabled") %>' MaxLength="30"
                                                         onkeypress="return remark(event);" onKeyUp="CheckLength(this,50)" onChange="CheckLength(this,50)">
                                            </asp:TextBox>
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
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Button ID="btnNewBatteryReqSave" runat="server" CssClass="form-submit-button" Text="Save" OnClick="btnNewBatteryReqSave_Click" OnClientClick="if (!validationInventoryBatteryVehicleType()) return false;"/>
                            &nbsp;&nbsp;
                            <asp:Button runat="server" CssClass="form-submit-button" Text="Reset" OnClick="btnNewBatteryReqReset_Click"/>
                            &nbsp;&nbsp;
                            <asp:Button runat="server" CssClass="form-submit-button" Text="View History" OnClick="btnNewBatteryReqViewHistory_Click" OnClientClick="if (!validationInventoryBatteryVehicleType()) return false;"/>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <br/>
                <tr>
                    <td>
                        <asp:GridView ID="grvBatteryPendingForApproval" runat="server" CellPadding="3" CellSpacing="2"
                                      GridLines="None" CssClass="gridviewStyle" AutoGenerateColumns="False" AllowPaging="True"
                                      DataKeyNames="FleetInventoryReqID" OnPageIndexChanging="grvBatteryPendingForApproval_PageIndexChanging"
                                      PageSize="5" OnRowCommand="grvBatteryPendingForApproval_RowCommand">
                            <Columns>
                                <asp:BoundField HeaderText="Vehicle Number" DataField="VehicleNum"/>
                                <asp:BoundField HeaderText="No. of Batteries" DataField="RequestedQty"/>
                                <asp:BoundField HeaderText="Request Date" DataField="RequestedDate" DataFormatString="{0:MM/dd/yyyy}"/>
                                <asp:BoundField HeaderText="Request By" DataField="RequestedBy" Visible="false"/>
                                <asp:BoundField HeaderText="Status" DataField="Status"/>
                                <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDetails" runat="server" Text="View" ToolTip="Click here to Approve/Reject the details"
                                                        OnClick="BtnViewDetails_Click" CssClass="button2" RowIndex="<%# Container.DisplayIndex %>"
                                                        CommandName="Show" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "FleetInventoryReqID") %>'/>
                                    </ItemTemplate>
                                    <ControlStyle Width="50px"/>
                                    <HeaderStyle Width="60px"/>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="rowStyleGrid"/>
                            <FooterStyle CssClass="footerStylegrid"/>
                            <PagerStyle CssClass="pagerStylegrid"/>
                            <SelectedRowStyle CssClass="selectedRowStyle"/>
                            <HeaderStyle CssClass="headerStyle"/>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="RequisitionHistory" runat="server">
                            <fieldset style="padding: 10px; width: auto">
                                <legend>Requisition History </legend>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grvRequisitionHistory" runat="server" AutoGenerateColumns="True"
                                                          GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" Width="95%"
                                                          OnPageIndexChanging="grvRequisitionHistory_PageIndexChanging" AllowPaging="True"
                                                          PageSize="5" EmptyDataText="No History Found">
                                                <RowStyle CssClass="rowStyleGrid"/>
                                                <FooterStyle CssClass="footerStylegrid"/>
                                                <PagerStyle CssClass="pagerStylegrid"/>
                                                <SelectedRowStyle CssClass="selectedRowStyle"/>
                                                <HeaderStyle CssClass="headerStyle"/>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Button ID="hideHistory" runat="server" Text="Hide History" Visible="false" OnClick="hideHistory_Click"/>
                            </fieldset>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none"/>
                        <ajaxToolkit:ModalPopupExtender ID="gv_ModalPopupExtender1" BehaviorID="mdlPopup"
                                                        runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground"/>
                        <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPanel" Width="500px" Style="display: none; padding: 10px;">
                            <fieldset style="padding: 10px; width: auto">
                                <legend>Battery Request Details</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" Text="Vehicle Number"></asp:Label>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleNumberPopUp" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" Text="Request ID"></asp:Label>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtRequestIdPopup" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <asp:GridView ID="grvBatteryRequestDetails" runat="server" AutoGenerateColumns="True"
                                                  GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" Width="95%">
                                        <RowStyle CssClass="rowStyleGrid"/>
                                        <FooterStyle CssClass="footerStylegrid"/>
                                        <PagerStyle CssClass="pagerStylegrid"/>
                                        <SelectedRowStyle CssClass="selectedRowStyle"/>
                                        <HeaderStyle CssClass="headerStyle"/>
                                    </asp:GridView>
                                </div>
                                <div id="Div7" align="center" style="background-color: white; width: 95%;">
                                    <br/>
                                    <asp:Button ID="btnOk" runat="server" Text="Approve" OnClick="btnOk_Click" Width="50px"/>
                                    <ajaxToolkit:ConfirmButtonExtender runat="server" TargetControlID="btnOk" ConfirmText="Are you sure you want to APPROVE">
                                    </ajaxToolkit:ConfirmButtonExtender>
                                    <asp:Button ID="btnNo" runat="server" Text="Reject" OnClick="btnNo_Click" Width="50px"/>
                                    <ajaxToolkit:ConfirmButtonExtender runat="server" TargetControlID="btnNo" ConfirmText="Are you sure you want to REJECT">
                                    </ajaxToolkit:ConfirmButtonExtender>
                                    <asp:Button runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                                Width="50px"/>
                                </div>
                            </fieldset>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</fieldset>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>