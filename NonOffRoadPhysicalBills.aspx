<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="NonOffRoadPhysicalBills.aspx.cs" Inherits="NonOffRoadPhysicalBills" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
    <script type="text/javascript">
        function validation() {

            var fldDistrict = document.getElementById('<%= ddlDistricts.ClientID %>');
            var fldDocketNo = document.getElementById('<%= txtDocketNo.ClientID %>');
            var fldVehicleno = document.getElementById('<%= ddlVehicleno.ClientID %>');
            var fldBillNo = document.getElementById('<%= ddlBillNo.ClientID %>');
            var fldReceiptDate = document.getElementById('<%= txtReceiptDate.ClientID %>');
            var fldCourierName = document.getElementById('<%= txtCourierName.ClientID %>');

            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!

            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            var now = dd + '/' + mm + '/' + yyyy;


            if (fldDistrict)
                if (fldDistrict.selectedIndex === 0) {
                    alert("Please Select District");
                    fldDistrict.focus();
                    return false;
                }
            if (fldVehicleno)
                if (fldVehicleno.selectedIndex === 0) {
                    alert("Please select Vehicle");
                    fldVehicleno.focus();
                    return false;
                }
            if (fldBillNo)
                if (fldBillNo.selectedIndex === 0) {
                    alert("Please select Bill");
                    fldBillNo.focus();
                    return false;
                }
            if (!requiredValidation(fldReceiptDate, "Receipt Date cannot be left blank"))
                return false;

            if (!requiredValidation(fldCourierName, "Courier Name cannot be left blank"))
                return false;

            if (!requiredValidation(fldDocketNo, "Docket Number cannot be left blank"))
                return false;
            if (Date.parse(fldReceiptDate.value) > Date.parse(now)) {
                alert("Receipts Date should not be greater than Current Date");
                fldReceiptDate.focus();
                return false;
            }
            return true;
        }

    </script>

    <asp:UpdatePanel ID="updtpnlVehMaintDet" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>
                                Non Off Road Physical Bills<br/>
                            </legend>
                            <table>
                                <tr>
                                    <td style="width: 85px" class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        District
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlDistricts" Height="16px" Width="120px" runat="server" OnSelectedIndexChanged="ddlDistricts_SelectedIndexChanged"
                                                          AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        Vehicle No
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehicleno" Height="16px" Width="120px" runat="server" OnSelectedIndexChanged="ddlVehicleno_SelectedIndexChanged1"
                                                          AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        Bill No
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlBillNo" Width="122px"
                                                          AutoPostBack="True" OnSelectedIndexChanged="ddlBillNo_SelectedIndexChanged"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 85px" class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Bill Amount
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtBillAmount" runat="server"/>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        BreakDown ID
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:Label
                                            ID="lblBrkdwn" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 85px" class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Receipt Date
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtReceiptDate" Width="114px"/>
                                        <cc1:CalendarExtender ID="calExtMaintenanceDate" runat="server" TargetControlID="txtReceiptDate"
                                                              PopupButtonID="imgBtnCalendarMaintenanceDate" Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        Courier Name
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtCourierName" onkeypress="return alpha_only_withspace(event);"/>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        Docket No
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDocketNo" onkeypress="return numeric_only(event);"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" OnClientClick="return validation()"/>
                                        <asp:Button runat="server" ID="btnUpdate" Visible="false" Text="Update" OnClick="btnUpdate_Click"
                                                    OnClientClick="return validation()"/>
                                        <asp:Button runat="server" ID="btnReset" Text="Reset" OnClick="btnReset_Click"/>
                                        <asp:HiddenField ID="HiddenField1" runat="server"/>

                                    </td>
                                </tr>
                            </table>
                            <div>
                                <div style="float: left; width: 200px;">
                                </div>
                                <div style="float: left">
                                    <asp:GridView ID="gvVehiclePhysicalBillDetails" runat="server" EmptyDataText="No Records Found"
                                                  AllowSorting="True" AutoGenerateColumns="False" CssClass="gridviewStyle" CellSpacing="2"
                                                  CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="True"
                                                  EnableSortingAndPagingCallbacks="True" OnPageIndexChanging="gvVehiclePhysicalBillDetails_PageIndexChanging"
                                                  OnRowCommand="gvVehiclePhysicalBillDetails_RowCommand">
                                        <RowStyle CssClass="rowStyleGrid"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="District">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "District") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="VehicleNo">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Vechicleno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BreakDown ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBrkDwnID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bill No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "BillNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bill Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ReceiptDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReceiptDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ReceiptDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Courier Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCourier_Name" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Courier_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Docket No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocketNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DocketNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Rejection Reason">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRejReason" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Reject") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="VehMainEdit" CommandArgument=" <%# Container.DataItemIndex %>"
                                                                    Text="Edit">
                                                    </asp:LinkButton>

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="footerStylegrid"/>
                                        <PagerStyle CssClass="pagerStylegrid"/>
                                        <SelectedRowStyle CssClass="selectedRowStyle"/>
                                        <HeaderStyle CssClass="headerStyle"/>
                                    </asp:GridView>
                                </div>
                            </div>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>