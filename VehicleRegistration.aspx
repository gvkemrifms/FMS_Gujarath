<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.VehicleRegistration, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script src="../JavaValidations/RequiredFieldValidations.js" type="text/javascript">
    </script>

    <script language="javascript" type="text/javascript">



        function validation() {


            var EngineNo = document.getElementById('<%= txtEngineNo.ClientID %>');
            var ChassisNo = document.getElementById('<%= txtChassisNo.ClientID %>');
            var SittingCapacity = document.getElementById('<%= txtSittingCapacity.ClientID %>');
            var PRNo = document.getElementById('<%= txtPRNo.ClientID %>');
            var RegistrationDate = document.getElementById('<%= txtRegistrationDate.ClientID %>');
            var RTACircle = document.getElementById('<%= txtRTACircle.ClientID %>');
            var District = document.getElementById('<%= ddlDistrict.ClientID %>');
            var RegisExpenses = document.getElementById('<%= txtRegisExpenses.ClientID %>');
            var vehiclePDIDate = document.getElementById('<%= vehiclePDIDate.ClientID %>');

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




            //            if (!RequiredValidation(EngineNo, "Engine No Cannot be Blank"))
            //                return false;

            //            if (!RequiredValidation(ChassisNo, "Chassis No Cannot be Blank"))
            //                return false;

            if (!RequiredValidation(SittingCapacity, "Sitting Capacity Cannot be Blank"))
                return false;

            if (!RequiredValidation(PRNo, "P/R No Cannot be Blank"))
                return false;



            if (PRNo.value != "") {
                if (!isValidVehicleNumber(PRNo.value)) {
                    PRNo.value = "";
                    PRNo.focus();
                    return false;
                }
            }

            if (!RequiredValidation(RegistrationDate, "Registration Date Cannot be Blank"))
                return false;

            if (!isValidDate(RegistrationDate.value)) {
                alert("Enter Valid Date");
                RegistrationDate.focus();
                return false;
            }

            if (Date.parse(RegistrationDate.value) < Date.parse(vehiclePDIDate.value)) {
                alert("Registration Date should be greater than Pre-Delivery Inspection Date.(Pre-Delivery Inspection Date-" + vehiclePDIDate.value + ")");
                RegistrationDate.focus();
                return false;
            }

            if (Date.parse(RegistrationDate.value) > Date.parse(now)) {
                alert("Registration Date should not be greater than Current Date");
                RegistrationDate.focus();
                return false;
            }


            if (!RequiredValidation(RTACircle, "RTA Circle Cannot be Blank"))
                return false;

            if (District.selectedIndex == 0) {
                alert("Please Select District");
                District.focus();
                return false;
            }


            if (!RequiredValidation(RegisExpenses, "Registration Expenses Cannot be Blank"))
                return false;
        }



        function isValidVehicleNumber(VehicleNo) {
            if (VehicleNo.match(/^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{1,4}$/)) {
                return true;
            }
            else {
                alert("Enter a valid Vehicle P/R Number eg - 'AP27HY9834' or 'AP27H8'");
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

        function isDecimalNumberOnly(event) {
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

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
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
                        <asp:Panel ID="pnlVehicleRegistration" runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">T/R No.<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <cc1:ComboBox ID="ddlTRNo" runat="server" AutoCompleteMode="Append"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlTRNo_SelectedIndexChanged"
                                            Width="145px" DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtTrNo" runat="server" ReadOnly="True" Visible="False"
                                            Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">Engine No
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtEngineNo" runat="server" BackColor="DarkGray"
                                            ReadOnly="True" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">Chassis No
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtChassisNo" runat="server" BackColor="DarkGray"
                                            ReadOnly="True" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">Seating Capacity<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtSittingCapacity" runat="server" MaxLength="2"
                                            onkeypress="return isDecimalNumberOnly(event);" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">P/R No<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtPRNo" runat="server" MaxLength="10"
                                            onkeypress="return alphanumeric_only(event);" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">Registration Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtRegistrationDate" runat="server" oncut="return false;"
                                            onkeypress="return false" Width="145px">
                                        </asp:TextBox>
                                        <asp:ImageButton ID="imbtnRegistrationDate" runat="server" alt=""
                                            src="images/Calendar.gif" Style="vertical-align: top" />
                                        <cc1:CalendarExtender ID="calExtRegistrationDate" runat="server"
                                            Format="MM/dd/yyyy" PopupButtonID="imbtnRegistrationDate"
                                            TargetControlID="txtRegistrationDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">RTA Circle<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtRTACircle" runat="server" MaxLength="20"
                                            onkeypress="return alpha_only_withspace(event);" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">District<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:DropDownList ID="ddlDistrict" runat="server" Width="145px">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px"></td>
                                    <td align="left" style="width: 300px">Registration Expenses<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:TextBox ID="txtRegisExpenses" runat="server" MaxLength="9"
                                            onkeypress="return isDecimalNumberKey(event);" Width="145px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 300px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 400px">&nbsp;
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 287px">&nbsp;
                                    </td>
                                    <td align="center" style="width: 300px">
                                        <asp:Button ID="btSave" Text="Save" runat="server" OnClick="btSave_Click" />
                                    </td>
                                    <td align="left" style="width: 400px">
                                        <asp:Button ID="btReset" runat="server" OnClick="btReset_Click" Text="Reset" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 287px">&nbsp;
                                    </td>
                                    <td align="center" style="width: 300px">&nbsp;
                                    </td>
                                    <td align="left" style="width: 400px">&nbsp;
                                    </td>
                                    <td>&nbsp;
                                    </td>
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
                                    <asp:GridView ID="gvVehicleRegistration" runat="server" EmptyDataText="No Records Found"
                                        AutoGenerateColumns="False" CellPadding="4" Width="630px" ForeColor="#333333"
                                        GridLines="None" OnRowCommand="gvVehicleRegistration_RowCommand" AllowPaging="True"
                                        OnPageIndexChanging="gvVehicleRegistration_PageIndexChanging"
                                        class="table table-striped table-bordered table-hover" HeaderStyle-ForeColor="#337ab7" PagerStyle-CssClass="pager"
                                        CellSpacing="2">
                                        <RowStyle CssClass="rows" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="T/R No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTRNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="P/R No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPRNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"PRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Registration Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRegDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"RegDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="RTA Circle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRTACircle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleRTACircle") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="District">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"district_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="VehRegEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"VehicleRegID") %>'
                                                        Text="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkDelete" runat="server" Visible="false" CommandName="VehRegDelete"
                                                            CommandArgument='<%#DataBinder.Eval(Container.DataItem,"VehicleRegID") %>' Text="Delete"></asp:LinkButton>
                                                        <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnkDelete"
                                                            ConfirmText="Are you sure you want to Delete?">
                                                        </cc1:ConfirmButtonExtender>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
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
                <asp:HiddenField ID="vehiclePDIDate" runat="server" />
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

