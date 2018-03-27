<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.FabricatedVehicleDetails, App_Web_m0x5b0wx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script language="javascript" type="text/javascript">
        function validation() {


            var FabricatorName = document.getElementById('<%= ddlFabricatorName.ClientID %>');
            var InvoiceNo = document.getElementById('<%= txtInvoiceNo.ClientID %>');
            var InvoiceDate = document.getElementById('<%= txtInvoiceDate.ClientID %>');
            var FabricationCost = document.getElementById('<%= txtFabricationCost.ClientID %>');
            var VehicleHandoverDate = document.getElementById('<%= txtVehicleHandoverDate.ClientID %>');
            var FabricationCompDate = document.getElementById('<%= txtFabricationCompDate.ClientID %>');
            var InspecetedBy = document.getElementById('<%= txtInspecetedBy.ClientID %>');
            var InspectionDate = document.getElementById('<%= txtInspectionDate.ClientID %>');
            var vehiclePurchaseDate = document.getElementById('<%= vehiclePurchaseDate.ClientID %>');

            var now = new Date();

            var id = document.getElementById('<%= ddlTRNo.ClientID %>');
            var inputs = id.getElementsByTagName('input');
            var i;
            for (i = 0; i < inputs.length; i++) {
                if (inputs[i].type == 'text') {
                    if (inputs[i].value != "" && inputs[i].value != null)
                        if (inputs[i].value == "--Select--") {
                            alert('Select the Vehicle');
                            return false;
                        }

                    break;
                }
            }

            if (FabricatorName.selectedIndex == 0) {
                alert("Please select Fabricator Name");
                FabricatorName.focus();
                return false;
            }
            if (!RequiredValidation(InvoiceNo, "Invoice Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(InvoiceDate, "Invoice Date Cannot be Blank"))
                return false;

            if (!isValidDate(InvoiceDate.value)) {
                alert("Enter Valid Invoice Date");
                InvoiceDate.focus();
                return false;
            }

            if (Date.parse(InvoiceDate.value) > Date.parse(now)) {
                alert("Invoice Date should not be greater than Current Date");
                InvoiceDate.focus();
                return false;
            }

            if (Date.parse(InvoiceDate.value) < Date.parse(vehiclePurchaseDate.value)) {
                alert("Invoice Date should be greater than Purchase Date.(PurchaseDate-" + vehiclePurchaseDate.value + ")");
                InvoiceDate.focus();
                return false;
            }


            if (!RequiredValidation(FabricationCost, "Fabrication Cost Cannot be Blank"))
                return false;

            //            if(!isNum(FabricationCost,"Enter valid cost"))
            //                return false;

            if (!RequiredValidation(VehicleHandoverDate, "Vehicle Handover To Fabricator Date Cannot be Blank"))
                return false;

            if (!isValidDate(VehicleHandoverDate.value)) {
                alert("Enter Valid Vehicle Handover Date");
                VehicleHandoverDate.focus();
                return false;
            }

            if (Date.parse(VehicleHandoverDate.value) < Date.parse(vehiclePurchaseDate.value)) {
                alert("Vehicle Handover Date should be greater than Purchase Date.(PurchaseDate-" + vehiclePurchaseDate.value + ")");
                InvoiceDate.focus();
                return false;
            }

            if (Date.parse(VehicleHandoverDate.value) > Date.parse(now)) {
                alert("Vehicle Handover Date should not be greater than Current Date");
                VehicleHandoverDate.focus();
                return false;
            }

            //             if (Date.parse(InvoiceDate.value) < Date.parse(VehicleHandoverDate.value)) {
            //                alert("Invoice Date should be greater than Vehicle Handover Date");
            //                VehicleHandoverDate.focus();
            //                return false;
            //            }

            if (!RequiredValidation(FabricationCompDate, "Fabrication Completion Date Cannot be Blank"))
                return false;

            if (!isValidDate(FabricationCompDate.value)) {
                alert("Enter Valid Fabrication Completion Date");
                FabricationCompDate.focus();
                return false;
            }

            if (Date.parse(FabricationCompDate.value) > Date.parse(now)) {
                alert("Fabrication Completion Date should not be greater than Current Date");
                FabricationCompDate.focus();
                return false;
            }

            if (Date.parse(FabricationCompDate.value) <= Date.parse(VehicleHandoverDate.value)) {
                alert("Fabrication Completion Date should be greater than Vehicle Handover Date");
                FabricationCompDate.focus();
                return false;
            }
            //            if (Date.parse(InvoiceDate.value) < Date.parse(FabricationCompDate.value)) {
            //                alert("Invoice Date should be greater than Fabrication Completion Date");
            //                FabricationCompDate.focus();
            //                return false;
            //            }

            if (!RequiredValidation(InspecetedBy, "Inspeceted By Cannot be Blank"))
                return false;

            if (!RequiredValidation(InspectionDate, "Inspection Date Cannot be Blank"))
                return false;

            if (!isValidDate(InspectionDate.value)) {
                alert("Enter Valid Inspection Date");
                InspectionDate.focus();
                return false;
            }
            if (Date.parse(InspectionDate.value) > Date.parse(now)) {
                alert("Inspection Date should not be greater than Current Date");
                InspectionDate.focus();
                return false;
            }

            if (Date.parse(InspectionDate.value) < Date.parse(FabricationCompDate.value)) {
                alert("Inspection Date should be greater than Fabrication Completion Date");
                InspectionDate.focus();
                return false;
            }
            //                alert("Record Inserted Successfully");
        }

        function RequiredValidation(ctrl, msg) {
            if (trim(ctrl.value) == '') {
                alert(msg);
                ctrl.focus();
                return false;
            }
            else
                return true;
        }


        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }


        function isDecimalNumberKey(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            //debugger;
            if (charCode == 190 || charCode == 46) {
                var txtBox = document.getElementById(event.srcElement.id);
                if (txtBox.value.indexOf('.') == -1)
                    return true;
                else
                    return false;
            }
            else if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }

        //        function isNum(elem, msg) {
        //            var numericExpression = /^[0-9].[0-9]/;
        //            if (elem.value.match(numericExpression)) {
        //                return true;
        //            }
        //            else {
        //                alert(msg);
        //                elem.focus();
        //                return false;
        //            }

        //        }

        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
        }

        function alphanumeric_only(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

        function alpha_only(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

        function alpha_only_withspace(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

    </script>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFabricatedVehicleDetails" runat="server">
                            <table class="table table-striped table-bordered table-hover">
                                <tr>
                                    <td align="center" style="font-size: small; font-weight: bold" colspan="4"></td>
                                </tr>
                             
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">T/R No.<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlTRNo" runat="server" Width="150px"
                                            OnSelectedIndexChanged="ddlTRNo_SelectedIndexChanged" AutoPostBack="True"
                                            Height="16px" DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtTrNo" runat="server" Visible="False"  CssClass="text1" Width="145px" ReadOnly="True"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Fabricator Name<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:DropDownList ID="ddlFabricatorName" CssClass="text1" runat="server" Width="150px">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Invoice No<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtInvoiceNo" runat="server" Width="145px" MaxLength="15" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Invoice Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtInvoiceDate" runat="server" Width="145px" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;"></asp:TextBox><asp:ImageButton ID="imgBtnCalendarInvoiceDate"
                                                runat="server" Style="vertical-align: top" alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtInvoiceDate" runat="server" TargetControlID="txtInvoiceDate"
                                            PopupButtonID="imgBtnCalendarInvoiceDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Fabrication Cost<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtFabricationCost" runat="server" Width="145px" onkeypress="return isDecimalNumberKey(event);"
                                            MaxLength="9"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Vehicle Handover to Fabricator Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtVehicleHandoverDate" runat="server" Width="145px" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;"></asp:TextBox><asp:ImageButton ID="imgbtHandover"
                                                runat="server" Style="vertical-align: top" alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExHandover" runat="server" TargetControlID="txtVehicleHandoverDate"
                                            PopupButtonID="imgbtHandover" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Fabrication Completion Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtFabricationCompDate" runat="server" Width="145px" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;"></asp:TextBox><asp:ImageButton ID="imgbtFabricationDate"
                                                runat="server" Style="vertical-align: top" alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtFabricationDate" runat="server" TargetControlID="txtFabricationCompDate"
                                            PopupButtonID="imgbtFabricationDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Inspected By<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtInspecetedBy" runat="server" Width="145px" MaxLength="15" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px">Inspection Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtInspectionDate" runat="server" Width="145px" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;"></asp:TextBox><asp:ImageButton ID="imgbtInspectionDate"
                                                runat="server" Style="vertical-align: top" alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtInspectionDate" runat="server" TargetControlID="txtInspectionDate"
                                            PopupButtonID="imgbtInspectionDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="left" style="width: 458px"></td>
                                    <td align="left" style="width: 400px"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 458px"></td>
                                    <td align="left" style="width: 400px"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px"></td>
                                    <td align="center" style="width: 458px">
                                        <asp:Button ID="btSave" Text="Save" runat="server" OnClick="btSave_Click" />
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:Button ID="btReset" Text="Reset" runat="server" OnClick="btReset_Click" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 314px">&nbsp;
                                    </td>
                                    <td align="center" style="width: 458px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 400px">&nbsp;
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                </tr>
                               
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr align="center">
                                <td>
                                    <asp:GridView ID="gvFabricatedVehicleDetails" runat="server" EmptyDataText="No Records Found"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="True"
                                        AllowSorting="True" OnSorting="gridView_Sorting" OnPageIndexChanging="gridView_PageIndexChanging"
                                        AutoGenerateColumns="False" OnRowCommand="gvFabricatedVehicleDetails_RowCommand"
                                        class="table table-striped table-bordered table-hover" PagerStyle-CssClass="pager"
                                        HeaderStyle-ForeColor="#337ab7" CellSpacing="2">
                                        <RowStyle CssClass="rows" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="T/R No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTRNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fabricator Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFabricatorName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FleetFabricator_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Hand Over Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVehicleHandoverDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleHandoverToFabricatorDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fabrication Complition Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFabricationCompDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FabricationCompletionDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fabrication Cost">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFabricationCost" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FabricationCost") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="fabVehEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FabricatedVehicleDetID") %>'
                                                        Text="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="fabVehDelete" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FabricatedVehicleDetID") %>'
                                                        Text="Delete"></asp:LinkButton>
                                                    <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnkDelete"
                                                        ConfirmText="Are you sure you want to Delete?">
                                                    </cc1:ConfirmButtonExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="footerStylegrid" />
                                        <PagerStyle CssClass="pagerStylegrid" />
                                        <SelectedRowStyle CssClass="selectedRowStyle" />
                                        <HeaderStyle CssClass="headerStyle" />
                                        <%--<FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />--%>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <asp:HiddenField ID="vehiclePurchaseDate" runat="server" />
                        </table>
                    </td>
                </tr>
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

