<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.StatutoryCompliance.RoadTax, App_Web_m0x5b0wx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script language="javascript" type="text/javascript">
        function validation() {


            var RoadTaxValidityStartDate = document.getElementById('<%= txtRoadTaxValidityStartDate.ClientID %>');
            var RoadTaxValidityPeriod = document.getElementById('<%= ddlRoadTaxValidityPeriod.ClientID %>');
            var VehicleRTACircle = document.getElementById('<%= txtVehicleRTACircle.ClientID %>');
            var RoadTaxReceiptNo = document.getElementById('<%= txtRoadTaxReceiptNo.ClientID %>');
            var RoadTaxFee = document.getElementById('<%= txtRoadTaxFee.ClientID %>');
            var vehicleRegistrationDate = document.getElementById('<%= vehicleRegistrationDate.ClientID %>');

            var now = new Date();

            var id = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
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
            if (!RequiredValidation(RoadTaxValidityStartDate, "RoadTax Validity Start Date Cannot be Blank"))
                return false;

            if (!isValidDate(RoadTaxValidityStartDate.value)) {
                alert("Enter Valid Road Tax Validity Start Date");
                RoadTaxValidityStartDate.focus();
                return false;
            }

            if (Date.parse(RoadTaxValidityStartDate.value) > Date.parse(now)) {
                alert("Road Tax Validity Start Date should not be greater than Current Date");
                RoadTaxValidityStartDate.focus();
                return false;
            }

            if (Date.parse(RoadTaxValidityStartDate.value) < Date.parse(vehicleRegistrationDate.value)) {
                alert("Road Tax Validity Start Date should be greater than Registration Date.(Registration Date-" + vehicleRegistrationDate.value + ")");
                RoadTaxValidityStartDate.focus();
                return false;
            }

            if (RoadTaxValidityPeriod.selectedIndex == 0) {
                alert("Please select Road Tax Validity Period");
                RoadTaxValidityPeriod.focus();
                return false;
            }

            if (VehicleRTACircle)
                if (!RequiredValidation(VehicleRTACircle, "Vehicle RTA Circle Cannot be Blank"))
                    return false;

            if (RoadTaxReceiptNo)
                if (!RequiredValidation(RoadTaxReceiptNo, "RoadTax Receipt No Cannot be Blank"))
                    return false;

            if (RoadTaxFee)
                if (!RequiredValidation(RoadTaxFee, "RoadTax Fee Cannot be Blank"))
                    return false;

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
            else return true; if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32)) {
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


    <asp:UpdatePanel ID="upPanel" runat="server">
        <ContentTemplate>

            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlRoadtax" runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td align="center" style="font-size: small; font-weight: bold" colspan="4"></td>
                                </tr>
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
                                    <td align="center" colspan="4"></td>
                                </tr>
                                <tr>
                                    <td style="width: 300px"></td>
                                    <td align="left" style="width: 350px" nowrap="nowrap">Vehicle Number<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <cc1:ComboBox AutoCompleteMode="Append"  ID="ddlVehicleNumber" runat="server" Width="150px" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged" DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtVehicleNumber" class="text1" runat="server" ReadOnly="True" Visible="False"
                                            Width="145px"></asp:TextBox>
                                    </td>
                                    <td align="center" style="width: 185px"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">Road Tax Validity Start Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtRoadTaxValidityStartDate" class="text1" AutoPostBack="true" runat="server"
                                            Width="145px" OnTextChanged="txtRoadTaxValidityStartDate_TextChanged" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ID="imgBtnRoadTaxValidityStartDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calextRoadTaxValidityStartDate" runat="server" TargetControlID="txtRoadTaxValidityStartDate"
                                            PopupButtonID="imgBtnRoadTaxValidityStartDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">Road Tax Validity Period<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:DropDownList ID="ddlRoadTaxValidityPeriod" class="text1" runat="server" Width="150px" OnSelectedIndexChanged="ddlRoadTaxValidityPeriod_SelectedIndexChanged"
                                            AutoPostBack="True">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="3">3 Month</asp:ListItem>
                                            <asp:ListItem Value="6">6 Month</asp:ListItem>
                                            <asp:ListItem Value="9">9 Month</asp:ListItem>
                                            <asp:ListItem Value="12">1 Year</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">Road Tax Validity End Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtRoadTaxValidityEndDate" class="text1" runat="server" Width="145px" BackColor="DarkGray"
                                            ReadOnly="True"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">
                                        <asp:CheckBox ID="chkbxTaxExempted" class="text1" runat="server" Text="Tax Exempted" AutoPostBack="True"
                                            OnCheckedChanged="chkbxTaxExempted_CheckedChanged" />
                                    </td>
                                    <td align="left" colspan="2"></td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">
                                        <asp:Label ID="lblVehicleRTACircle" runat="server" Text="Vehicle RTA Circle"></asp:Label>
                                        <asp:Label ID="lblVehRTACirStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtVehicleRTACircle" class="text1" runat="server" Width="145px" MaxLength="35"
                                            onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">
                                        <asp:Label ID="lblRoadTaxReceiptNo" runat="server" Text="Road Tax Receipt No."></asp:Label>
                                        <asp:Label ID="lblRoadTaxReceiptNoStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtRoadTaxReceiptNo" class="text1" runat="server" Width="145px" MaxLength="15"
                                            onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left">
                                        <asp:Label ID="lblRoadTaxFee" runat="server" Text="Road Tax Fee"></asp:Label>
                                        <asp:Label ID="lblRoadTaxFeeStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtRoadTaxFee" class="text1" runat="server" Width="145px" onkeypress="return isDecimalNumberKey(event);"
                                            MaxLength="9"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="left">&nbsp;
                                    </td>
                                    <td align="left" colspan="2">&nbsp;
                                    </td>
                                    <td align="center">&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="center">
                                        <asp:Button ID="btSave" runat="server" Text="Save" OnClick="btSave_Click" />
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:Button ID="btReset" runat="server" Text="Reset" OnClick="btReset_Click" />
                                    </td>
                                    <td align="center">
                                        <asp:LinkButton ID="lbtnViewHistory" runat="server" Visible="False">View History</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="left" colspan="2"></td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="left" colspan="2">&nbsp;
                                    </td>
                                    <td align="center">&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="4"></td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:GridView ID="gvRoadTax" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            Width="630px" ForeColor="#333333" GridLines="None" OnRowCommand="gvRoadTax_RowCommand"
                            OnRowDataBound="gvRoadTax_RowDataBound" AllowPaging="True" EmptyDataText="No Records Found"
                            OnPageIndexChanging="gvRoadTax_PageIndexChanging" CssClass="table table-striped table-bordered table-hover" PagerStyle-CssClass="pager"
                                           HeaderStyle-ForeColor="#337ab7" CellSpacing="2">
                            <RowStyle CssClass="rows" />
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleNumber") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="RTValidityStartDate" HeaderText="RTValidity StartDate"
                                    DataFormatString="{0:d}" />
                                <asp:TemplateField HeaderText="RTValidity Period">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTValidityPeriod" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"RTValidityPeriod") %>'></asp:Label>
                                        <asp:Label ID="lblRTValidityPeriodText" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="RTValidityEndDate" HeaderText="RTValidity EndDate" DataFormatString="{0:d}" />
                                <asp:TemplateField HeaderText="Vehicle RTA Circle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleRTACircle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleRTACircle") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RT Receipt No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTReceiptNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"RTReceiptNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Road Tax Fee">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTFee" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"RTFee") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="roadTaxEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"RoadTaxID") %>'
                                            Text="Edit"></asp:LinkButton>
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
                <asp:HiddenField ID="vehicleRegistrationDate" runat="server" />
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

