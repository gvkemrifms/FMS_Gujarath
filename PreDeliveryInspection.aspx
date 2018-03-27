<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.PreDeliveryInspection, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../JavaValidations/RequiredFieldValidations.js" type="text/javascript">

    </script>
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>

    <script language="javascript" type="text/javascript">
        function validation() {


            var VehicleReceived = document.getElementById('<%= ddlVehicleReceived.ClientID %>');
            var ReceivedDate = document.getElementById('<%= txtReceivedDate.ClientID %>');
            var Odometer = document.getElementById('<%= txtOdometer.ClientID %>');
            var PDIBy = document.getElementById('<%= txtPDIBy.ClientID %>');
            var PDIDate = document.getElementById('<%= txtPDIDate.ClientID %>');
            var vehicleFabInspDate = document.getElementById('<%= vehicleFabInspDate.ClientID %>');

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

             if (VehicleReceived.selectedIndex == 0) {
                 alert("Please select Vehicle Received From");
                 VehicleReceivedFrom.focus();
                 return false;
             }
             if (!RequiredValidation(ReceivedDate, "Received Date Cannot be Blank"))
                 return false;

             if (!isValidDate(ReceivedDate.value)) {
                 alert("Enter Valid Date");
                 ReceivedDate.focus();
                 return false;
             }

             if (Date.parse(ReceivedDate.value) > Date.parse(now)) {
                 alert("Received Date should not be greater than Current Date");
                 ReceivedDate.focus();
                 return false;
             }

             if (Date.parse(ReceivedDate.value) < Date.parse(vehicleFabInspDate.value)) {
                 alert("Received Date should be greater than Fabrication Inspection Date.(Fabrication Inspection Date-" + vehicleFabInspDate.value + ")");
                 ReceivedDate.focus();
                 return false;
             }

             if (!RequiredValidation(Odometer, "Odometer Cannot be Blank"))
                 return false;

             if (!RequiredValidation(PDIBy, "PDIBy Cannot be Blank"))
                 return false;

             if (!RequiredValidation(PDIDate, "PDIDate Cannot be Blank"))
                 return false;

             if (!isValidDate(PDIDate.value)) {
                 alert("Enter Valid Date");
                 PDIDate.focus();
                 return false;
             }

             if (Date.parse(PDIDate.value) > Date.parse(now)) {
                 alert("PDI Date should not be greater than Current Date");
                 PDIDate.focus();
                 return false;
             }

             if (Date.parse(ReceivedDate.value) > Date.parse(PDIDate.value)) {
                 alert(" PDI Date should be greater than Received Date");
                 ReceivedDate.focus();
                 return false;
             }

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
             if (charCode == 190) {
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

            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlPreDeliveryInspection" runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td align="center" style="font-size: small; font-weight: bold" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4" style="height: 23px"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">T/R No.<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlTRNo" runat="server" Width="150px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlTRNo_SelectedIndexChanged" DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtTRNo" runat="server" Visible="False" Width="145px" ReadOnly="True"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">Vehicle Received From<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:DropDownList ID="ddlVehicleReceived" runat="server" Width="150px">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">Received Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtReceivedDate" runat="server" Width="145px" onkeypress="return false" oncut="return false;" onpaste="return false;">
                                        </asp:TextBox><asp:ImageButton ID="imgBtnCalendarReceivedDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtReceivedDate" runat="server" TargetControlID="txtReceivedDate"
                                            PopupButtonID="imgBtnCalendarReceivedDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">Odometer<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtOdometer" runat="server" Width="145px" onkeypress="return isDecimalNumberKey(event);"
                                            MaxLength="6"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">PDI By<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtPDIBy" runat="server" Width="145px" MaxLength="35" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="left" style="width: 300px">PDI Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtPDIDate" runat="server" Width="145px" onkeypress="return false" oncut="return false;" onpaste="return false;">
                                        </asp:TextBox><asp:ImageButton ID="imbtnPDIDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtPDIDate" runat="server" TargetControlID="txtPDIDate"
                                            PopupButtonID="imbtnPDIDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 300px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 400px">&nbsp;
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 262px">&nbsp;
                                    </td>
                                    <td align="center" style="width: 300px">
                                        <asp:Button ID="btSave" Text="Save" runat="server" OnClick="btSave_Click" />
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:Button ID="btReset" Text="Reset" runat="server" OnClick="btReset_Click" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 262px"></td>
                                    <td align="center" style="width: 300px"></td>
                                    <td align="left" style="width: 400px"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="4"></td>
                                </tr>
                                <tr>
                                    <td colspan="4"></td>
                                </tr>
                                <tr>
                                    <td colspan="4"></td>
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
                                    <asp:GridView ID="gvPreDeliveryInspection" runat="server" EmptyDataText="No Records Found"
                                        AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
                                        Width="630px" OnRowCommand="gvPreDeliveryInspection_RowCommand" AllowPaging="True"
                                        OnPageIndexChanging="gvPreDeliveryInspection_PageIndexChanging"
                                        class="table table-striped table-bordered table-hover" HeaderStyle-ForeColor="#337ab7" PagerStyle-CssClass="pager"
                                        CellSpacing="2">
                                        <RowStyle CssClass="rows" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="T/R No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTRNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vehicle Received From">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVehicleReceived" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FleetFabricator_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Received Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReceivedDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ReceivedDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PDI By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPDIBy" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"PDIBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PDI Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPDIDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"PDIDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="pdiEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"PreDeliveryInspectionID") %>'
                                                        Text="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="pdiDelete" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"PreDeliveryInspectionID") %>'
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
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <asp:HiddenField ID="vehicleFabInspDate" runat="server" />
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

