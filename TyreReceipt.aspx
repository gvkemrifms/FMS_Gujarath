<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="TyreReceipt.aspx.cs" Inherits="TyreReceipt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">
        function CheckLength(text, long) {
            var maxlength = new Number(long); // Change number to your max length.
            if (text.value.length > maxlength) {
                text.value = text.value.substring(0, maxlength);
                alert(" Only " + long + " chars");
            }
        }

        function remark(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode !== 34) && (keycode !== 39);
        }

        function validation() {
            var tyreRecDate = document.getElementById('<%= txtTyreRecDate.ClientID %>');
            var remarks = document.getElementById('<%= txtRemarks.ClientID %>');
            var dcDate = document.getElementById('<%= txtTyreDCDate.ClientID %>');

            if (!requiredValidation(tyreRecDate, "Receipt Date cannot be Blank"))
                return false;

            if (trim(tyreRecDate.value) !== "") {
                if (!isValidDate(tyreRecDate.value)) {
                    alert("Enter the Receipt Date");
                    tyreRecDate.focus();
                    return false;
                }
            }

            var now = new Date();
            if (Date.parse(tyreRecDate.value) > Date.parse(now)) {
                alert("Receipt Date should not be greater than Current Date");
                tyreRecDate.focus();
                return false;
            }
            if (Date.parse(tyreRecDate.value) < Date.parse(dcDate.value)) {
                alert("Receipt Date should be greater than DC date");
                tyreRecDate.focus();
                return false;
            }

            if (!requiredValidation(remarks, "Remarks cannot be Blank"))
                return false;

            function requiredValidation(ctrl, msg) {
                switch (trim(ctrl.value)) {
                case '':
                    alert(msg);
                    ctrl.focus();
                    return false;
                default:
                    return true;
                }
            }

            function trim(value) {
                value = value.replace(/^\s+/, '');
                value = value.replace(/\s+$/, '');
                return value;

            }

            function isValidDate(subject) {
                return !!subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/);
            }

            return true;
        }


    </script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Tyre Receipt</legend>
                <div id="Div2" runat="server" align="center">
                    Vehicle Number<span style="color: Red">*</span>

                    <ajaxToolkit:ComboBox AutoCompleteMode="Append" ID="ddlInventoryTyreReceiptVehicles" runat="server" AutoPostBack="True" DropDownStyle="DropDownList"
                                          OnSelectedIndexChanged="ddlInventoryTyreReceiptVehicles_SelectedIndexChanged">
                    </ajaxToolkit:ComboBox>
                </div>
                <br/>
                <div id="Div5" runat="server">
                    Tyre Details
                </div>
                <br/>
                <div id="Div6" runat="server" align="center">
                    <asp:GridView ID="grvTyreDetailsForReceipt" runat="server" GridLines="None" CssClass="gridviewStyle"
                                  EmptyDataText="Details are not available" CellPadding="3" CellSpacing="2" AutoGenerateColumns="False"
                                  AllowPaging="True" DataKeyNames="FleetInventoryReqID" PageSize="5" OnPageIndexChanging="grvTyreDetailsForReceipt_PageIndexChanging"
                                  OnRowCommand="grvTyreDetailsForReceipt_RowCommand">
                        <Columns>
                            <asp:BoundField HeaderText="Vehicle Number" DataField="VehicleNum"/>
                            <asp:BoundField HeaderText="District" DataField="ds_lname"/>
                            <asp:BoundField HeaderText="TyreNumber" DataField="TyreNumber"/>
                            <asp:BoundField HeaderText="Request Date" DataField="RequestedDate" DataFormatString="{0:MM/dd/yyyy}"/>
                            <asp:BoundField HeaderText="Total Tyres Issued" DataField="IssuedQty"/>

                            <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnViewDetails" Text="Receipt" ToolTip="Click here to Receipt the details"
                                                    runat="server" OnClick="BtnViewDetails_Click" CssClass="button2" RowIndex="<%# Container.DisplayIndex %>"
                                                    CommandName="Show" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "InventoryItemIssueID") %>'/>
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
                </div>
                <asp:Button ID="btnShowPopup" runat="server" Style="display: none"/>
                <ajaxToolkit:ModalPopupExtender ID="gv_ModalPopupExtenderTyreReceipt" BehaviorID="mdlPopup"
                                                runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground"/>
                <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPanel" Style="padding: 10px">
                    <asp:UpdatePanel ID="updPnlReqDetail" runat="server">
                        <ContentTemplate>
                            <fieldset>
                                <legend>Tyre Receipt Details</legend>
                                <table class="style1" align="center">
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            Vehicle Number
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTyreRecVehicleNo" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            District
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTyreRecDistrict" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            DC Number
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTyreDCNumber" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            DC Date
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                        <asp:TextBox ID="txtTyreDCDate" runat="server" ReadOnly="True" Format="MM/dd/yyyy" oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            Courier Name
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTyreRecCourierName" runat="server" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            HO Remarks
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                        <asp:TextBox ID="txtTyreRecHORemarks" runat="server" ReadOnly="True"></asp:TextBox>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            Receipt Date
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTyreRecDate" runat="server" onkeypress="return false" MaxLength="20" oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtTyreRecDate"
                                                                          Format="MM/dd/yyyy" PopupButtonID="ImageButton1">
                                            </ajaxToolkit:CalendarExtender>
                                            <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif" Style="vertical-align: top"/>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtIssueID" runat="server" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <asp:GridView ID="grvTyreReceiptDetailsPopup" runat="server" AutoGenerateColumns="False"
                                                          GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" BackColor="#DEBA84"
                                                          Width="95%">
                                                <Columns>

                                                    <asp:BoundField HeaderText="Tyre Number" DataField="TyreNumber"/>
                                                    <asp:BoundField HeaderText="Make" DataField="Make"/>
                                                    <asp:BoundField HeaderText="Model" DataField="Model"/>
                                                </Columns>
                                                <RowStyle CssClass="rowStyleGrid"/>
                                                <FooterStyle CssClass="footerStylegrid"/>
                                                <PagerStyle CssClass="pagerStylegrid"/>
                                                <SelectedRowStyle CssClass="selectedRowStyle"/>
                                                <HeaderStyle CssClass="headerStyle"/>
                                            </asp:GridView>
                                            <div id="Div7" align="center" style="width: 95%; background-color: white">
                                                Remarks
                                                <asp:TextBox ID="txtRemarks" runat="server" onkeypress="return OnlyAlphaNumeric(event)"
                                                             MaxLength="20" TextMode="MultiLine" onKeyUp="CheckLength(this,50)" onChange="CheckLength(this,)">
                                                </asp:TextBox>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnOk" runat="server" Text="Receipt" Width="50px" OnClick="btnOk_Click"/>
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnNo" runat="server" Text="Cancel" Width="50px" OnClick="btnNo_Click"/>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

