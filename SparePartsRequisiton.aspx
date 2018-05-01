﻿<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="SparePartsRequisiton.aspx.cs" Inherits="SparePartsRequisiton" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolKit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<script type="text/javascript">

    function validation() {
        var id = document.getElementById('<%= ddlVehicles.ClientID %>');
        var inputs = id.getElementsByTagName('input');
        var i;
        for (i = 0; i < inputs.length; i++) {
            switch (inputs[i].type) {
            case 'text':
                if (inputs[i].value !== "" && inputs[i].value != null && inputs[i].value === "--Select--") {
                    alert('Select the Vehicle');
                    return false;
                }
                break;
            }
        }
        return true;
    }

    function OnlyNumbers(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        else
            return true;
    }

</script>
<asp:UpdatePanel ID="updPanel1" runat="server">
<ContentTemplate>
<fieldset style="padding: 10px;">
<legend  align="center" style="color:brown">Spare Parts Requisiton</legend>
<table style="width: 100%">
<tr align="center">
    <td>
        <asp:Panel ID="pnlSparePartsRequisition" runat="server">
            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lbVehicles" runat="server" Text="Vehicles"></asp:Label>
                        <span style="color: Red">*</span>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <ajaxToolKit:ComboBox AutoCompleteMode="Append" ID="ddlVehicles" style="margin-bottom:15px" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVehicles_SelectedIndexChanged" DropDownStyle="DropDownList">
                        </ajaxToolKit:ComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:GridView ID="grvNewSparePartsRequisition" runat="server" AutoGenerateColumns="False" style="margin-top:30px"
                                      OnRowDeleting="grvNewSparePartsRequisition_RowDeleting" CellPadding="3" CellSpacing="2"
                                      GridLines="Both" CssClass="gridviewStyle" OnSelectedIndexChanged="grvNewSparePartsRequisition_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField HeaderText="S.No" DataField="SNo"/>
                                <asp:TemplateField HeaderText="Spare Part Name">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlSparePartName" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtQuantity" runat="server" Width="75" Text='<%# Eval("Quantity") %>'
                                                     MaxLength="3" onkeypress="return OnlyNumbers(event);">
                                        </asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" ToolTip='<%# Eval("SNo") %>'
                                                    CssClass="button2" OnClick="BtnDelete_Click"/>
                                    </ItemTemplate>
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
                    <td colspan="3" align="center">
                        <asp:Button ID="btnAddRow" runat="server" Text="Add Row" CssClass="form-submit-button" OnClick="btnAddRow_Click"/>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="form-submit-button" OnClick="btnSubmit_Click"/>
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="form-submit-button" OnClick="btnReset_Click"/>
                        <asp:Button ID="btnSparePartsReqHistory" runat="server" CssClass="form-submit-button" Text="View History" OnClick="btnSparePartsReqHistory_Click" OnClientClick="return validation();"/>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </td>
</tr>
<tr>
    <td>
        <table style="margin-top:50px">

        <tr>
            <td align="left">
                <asp:Label ID="lbPendingforissue" runat="server" Text="Requisitions Pending For Issue" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="grvPendingforApproval" runat="server" AutoGenerateColumns="False"
                              EmptyDataText="Details are not available" DataKeyNames="FleetInventoryReqID"
                              CellPadding="3" CellSpacing="2" GridLines="Both" CssClass="gridviewdsd" OnRowCommand="grvPendingforApproval_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Row_ID" DataField="Row_ID"/>
                        <asp:BoundField HeaderText="Total Spare Parts Quantity" DataField="RequestedQty"/>
                        <asp:BoundField HeaderText="Requested Date" DataField="RequestedDate" DataFormatString="{0:MM/dd/yyyy}"/>
                        <asp:BoundField HeaderText="Requested By" DataField="RequestedBy"/>
                        <asp:BoundField HeaderText="Status" DataField="Status"/>
                        <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnViewDetails" runat="server" Text="View" ToolTip="Click here to Approve/Reject the details"
                                                CssClass="button2" OnClick="btnViewDetails_Click" RowIndex="<%# Container.DisplayIndex %>"
                                                CommandName="Show" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "FleetInventoryReqID") %>'/>
                            </ItemTemplate>
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
                        <table>
                            <tr>
                                <td>
                                    <legend style="margin-top:40px">Requisition History </legend>
                                </td>
                                </tr>
                            <br />
                            <tr>
                                <td>
                                    <asp:GridView ID="grvRequisitionHistory" runat="server" AutoGenerateColumns="True"
                                                  PageSize="5" GridLines="Both" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2"
                                                  Width="95%" OnPageIndexChanging="grvRequisitionHistory_PageIndexChanging" AllowPaging="True" EmptyDataText="No History Found">
                                        <RowStyle CssClass="rowStyleGrid"/>
                                        <FooterStyle CssClass="footerStylegrid"/>
                                        <PagerStyle CssClass="pagerStylegrid"/>
                                        <SelectedRowStyle CssClass="selectedRowStyle"/>
                                        <HeaderStyle CssClass="headerStyle"/>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="hideHistory" runat="server" CssClass="form-submit-button" Text="Hide History" Visible="false" OnClick="hideHistory_Click"/>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
        <td>
        <asp:Button ID="btnShowPopup" runat="server" Style="display: none"/>
        <ajaxToolKit:ModalPopupExtender ID="gv_ModalPopupExtender1" BehaviorID="mdlPopup"
                                        runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground"/>
        <asp:Panel ID="pnlPopup" runat="server" Style="display: none; padding: 10px" CssClass="modalPanel">
            <asp:UpdatePanel ID="updPnlReqDetail" runat="server">
                <ContentTemplate>
               
                            <table  style="margin-left:700px;margin-top:290px ;border:1px">
                                <tr>
                                    <td>
                                        <legend>Request Details</legend>
                                    </td>
                                </tr>
                                <br />

                                <tr>
                                    <td >
                                        <asp:Label ID="lblVehicleNum" runat="server" Text="VehicleNum"/>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtVehicleNumber"  runat="server" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>

      
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblReqID" runat="server" Text="InvReqID"/>
                                        </td>
                                        <td >
                                            <asp:TextBox ID="txtReqID"  runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
 
                                    <tr>
                                        <td colspan="3">
                                            <asp:GridView ID="grvBatteryRequestDetails" runat="server" align="left" AutoGenerateColumns="true"
                                                          CellPadding="3" CellSpacing="2" CssClass="gridviewStyle" GridLines="None" Width="400px">
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
                                        <td >
                                            <asp:Button ID="btnOk" runat="server" CssClass="form-submit-button" OnClick="btnOk_Click" Text="Approve" Width="70px"/>
                                            <ajaxToolKit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure You want to Approve?"
                                                                               TargetControlID="btnOk">
                                            </ajaxToolKit:ConfirmButtonExtender>
                                            <asp:Button ID="btnNo" CssClass="form-submit-button" runat="server" OnClick="btnNo_Click" Text="Reject" Width="70px"/>
                                            <ajaxToolKit:ConfirmButtonExtender ID="ConfirmButtonExtender2" runat="server" ConfirmText="Are you sure You want to Reject?"
                                                                               TargetControlID="btnNo">
                                            </ajaxToolKit:ConfirmButtonExtender>
                                            <asp:Button ID="btnCancel" CssClass="form-submit-button" Width="70px" runat="server" OnClick="btnCancel_Click" Text="Cancel"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                
                            </table>
                        </fieldset>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <tr>
            <td class="rowseparator"></td>
        </tr>
    </td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>