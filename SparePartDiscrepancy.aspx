<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="SparePartDiscrepancy.aspx.cs" Inherits="SparePartDiscrepancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>

            <script type="text/javascript">

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
                    var txtReceivedQuantity = document.getElementById(window.Remarks);
                    if (!RequiredValidation(txtReceivedQuantity, "Remarks cannot be blank"))
                        return false;
                    return true;
                }

                function RequiredValidation(ctrl, msg) {
                    switch (trim(ctrl.value)) {
                    case '':
                        alert(msg);
                        ctrl.focus();
                        return false;
                    default:
                        return true;
                    }
                }

                function OnlyAlphabets(myfield, e, dec) {
                    var key;
                    if (window.event || e)
                        key = window.event.keyCode;
                    else return true;
                    var keychar = String.fromCharCode(key);
                    return (" !@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) <= -1;
                }


                function trim(value) {
                    value = value.replace(/^\s+/, '');
                    value = value.replace(/\s+$/, '');
                    return value;

                }


            </script>

            <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
                <img src="images/b1.jpg" alt="banner" width="653" height="150"/>
            </div>
            <fieldset style="padding: 10px;">
                <legend>Spare Part Discrepancy</legend>
                <asp:Panel ID="pnlSparePartDiscrepancy" runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlGrid" runat="server">
                                    <table>
                                        <tr>
                                            <td align="center" colspan="4">
                                                <asp:GridView ID="gvSparePartDiscrepancy" runat="server" AutoGenerateColumns="False"
                                                              GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" EmptyDataText="No Records Found">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chk" runat="server"/>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField HeaderText="Dist" DataField="District"/>

                                                        <asp:BoundField HeaderText="RecQty" DataField="ReceivedQty"/>
                                                        <asp:BoundField HeaderText="IssQty" DataField="IssuedQty"/>

                                                        <asp:BoundField HeaderText="VehNo" DataField="Vehicle"/>
                                                        <asp:BoundField HeaderText="RecDate" DataField="ReceiptDate"/>

                                                        <asp:TemplateField HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="25" TextMode="MultiLine" onkeypress="return remark(event);" onKeyUp="CheckLength(this,50)"
                                                                             onChange="CheckLength(this,50)">
                                                                </asp:TextBox>
                                                                <asp:Label ID="lbdistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DistrictID") %>'
                                                                           Visible="false">
                                                                </asp:Label>
                                                                <asp:Label ID="lbDetID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SparePartReceiptDetID") %>'
                                                                           Visible="false">
                                                                </asp:Label>
                                                                <asp:Label ID="lbVehicle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleID") %>'
                                                                           Visible="false">
                                                                </asp:Label>
                                                                <asp:Label ID="lbCreatedBy" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CreatedBy") %>'
                                                                           Visible="false">
                                                                </asp:Label>
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
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlButtons" runat="server">
                                    <table>
                                        <tr>
                                            <td class="columnseparator">
                                            </td>
                                            <td align="right">
                                                <asp:Button ID="btSave" runat="server" Text="Submit" OnClick="btSave_Click"/>
                                            </td>
                                            <td align="left">
                                                <asp:Button ID="btCancel" runat="server" Text="Cancel" OnClick="btCancel_Click"/>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

