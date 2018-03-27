<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.StatutoryCompliance.FitnessRenewal, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .button {
            display: inline-block;
            border-radius: 4px;
            border: none;
            color: #FFFFFF;
            text-align: center;
            font-size: 28px;
            http: //localhost:58742/VehicleInsurance.aspx padding: 0px;
            width: 122px;
            transition: all 0.5s;
            cursor: pointer;
            margin: 5px;
        }

            .button span {
                cursor: pointer;
                display: inline-block;
                position: relative;
                transition: 0.5s;
            }

                .button span:after {
                    content: '\00bb';
                    position: absolute;
                    opacity: 0;
                    top: 0;
                    right: -20px;
                    transition: 0.5s;
                }

            .button:hover span {
                padding-right: 25px;
            }

                .button:hover span:after {
                    opacity: 1;
                    right: 0;
                }
    </style>
    <style>
        .text1 {
            border: 2px solid rgb(173, 204, 204);
            height: 31px;
            width: 223px;
            box-shadow: 0px 0px 27px rgb(204, 204, 204) inset;
            transition: 500ms all ease;
            padding: 3px 3px 3px 3px;
        }

            .text1:hover, #text1:focus {
                width: 260px;
                transition: 500ms all ease;
                background: url(msg.png) no-repeat right;
                background-size: 25px 25px;
                background-position: 96% 62%;
                padding: 3px 32px 3px 3px;
            }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        input[type=text] {
            width: 100%;
            padding: 4px 20px;
            margin: 2px 0;
            box-sizing: border-box;
        }
    </style>
    <style>
        .mydatagrid {
            width: 80%;
            border: solid 2px black;
            min-width: 80%;
        }

        .header {
            background-color: #646464;
            font-family: Arial;
            color: White;
            border: none 0px transparent;
            height: 25px;
            text-align: center;
            font-size: 16px;
        }

        .rows {
            background-color: #fff;
            font-family: Arial;
            font-size: 14px;
            color: #000;
            min-height: 25px;
            text-align: left;
            border: none 0px transparent;
        }

            .rows:hover {
                background-color: #ff8000;
                font-family: Arial;
                color: #fff;
                text-align: left;
            }

        .selectedrow {
            background-color: #ff8000;
            font-family: Arial;
            color: #fff;
            font-weight: bold;
            text-align: left;
        }

        .mydatagrid a /** FOR THE PAGING ICONS  **/ {
            background-color: Transparent;
            padding: 5px 5px 5px 5px;
            /*color: #fff;*/
            text-decoration: none;
            font-weight: bold;
        }

            .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/ {
                background-color: #000;
                color: #fff;
            }

        .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/ {
            /*background-color: #c9c9c9;*/
            color: #000;
            padding: 5px 5px 5px 5px;
        }

        .pager {
            background-color: #646464;
            font-family: Arial;
            color: White;
            height: 30px;
            text-align: left;
        }

        .mydatagrid td {
            padding: 5px;
        }

        .mydatagrid th {
            padding: 5px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function validation() {


            var FitnessValidityStartDate = document.getElementById('<%= txtFitnessValidityStartDate.ClientID %>');
            var FitnessValidityPeriod = document.getElementById('<%= ddlFitnessValidityPeriod.ClientID %>');
            //var FitnessValidityEndDate = document.getElementById('<%= txtFitnessValidityEndDate.ClientID %>');
            var VehicleRTACircle = document.getElementById('<%= txtVehicleRTACircle.ClientID %>');
            var FitnessReceiptNo = document.getElementById('<%= txtFitnessReceiptNo.ClientID %>');
            var FitnessFee = document.getElementById('<%= txtFitnessFee.ClientID %>');
            var vehiclePurchaseDate = document.getElementById('<%= vehiclePurchaseDate.ClientID %>');

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

            if (!RequiredValidation(FitnessValidityStartDate, "Fitness Validity Start Date Cannot be Blank"))
                return false;

            if (!isValidDate(FitnessValidityStartDate.value)) {
                alert("Enter Valid Date");
                FitnessValidityStartDate.focus();
                return false;
            }

            if (Date.parse(FitnessValidityStartDate.value) > Date.parse(now)) {
                alert("Fitness Validity Start Date should not be greater than Current Date");
                FitnessValidityStartDate.focus();
                return false;
            }

            if (Date.parse(FitnessValidityStartDate.value) < Date.parse(vehiclePurchaseDate.value)) {
                alert("Fitness Validity Start Date should be greater than Purchase Date.(PurchaseDate-" + vehiclePurchaseDate.value + ")");
                FitnessValidityStartDate.focus();
                return false;
            }

            if (FitnessValidityPeriod.selectedIndex == 0) {
                alert("Please select Fitness Validity Period");
                FitnessValidityPeriod.focus();
                return false;
            }
            if (!RequiredValidation(VehicleRTACircle, "Vehicle RTA Circle Cannot be Blank"))
                return false;

            if (!RequiredValidation(FitnessReceiptNo, "Fitness Receipt No Cannot be Blank"))
                return false;

            if (!RequiredValidation(FitnessFee, "Fitness Fee Cannot be Blank"))
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


    </script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFitnessRenewal" runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td align="center" colspan="5"></td>
                                </tr>
                                <tr>
                                    <td style="width: 200px"></td>
                                    <td align="left" style="width: 226px">Vehicle Number<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" Width="150px"
                                            OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged"
                                            AutoPostBack="True" DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--SELECT--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtVehicleNumber" class="text1" runat="server" MaxLength="6" onkeypress="return isDecimalNumberKey(event);"
                                            ReadOnly="True" Visible="False" Width="145px"></asp:TextBox>
                                    </td>
                                    <td align="center" style="width: 185px"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left" style="width: 286px">Fitness Validity Start Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtFitnessValidityStartDate" class="text1" AutoPostBack="true" runat="server"
                                            Width="145px" OnTextChanged="txtFitnessValidityStartDate_TextChanged1" onkeypress="return false;"
                                            oncut="return false;" onpaste="return false;"> </asp:TextBox>
                                        <cc1:CalendarExtender ID="calextFitnessValidityStartDate" runat="server" TargetControlID="txtFitnessValidityStartDate"
                                            PopupButtonID="imgBtnFitnessValidityStartDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ID="imgBtnFitnessValidityStartDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left" style="width: 226px">Fitness Validity Period<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:DropDownList ID="ddlFitnessValidityPeriod" class="text1" runat="server" Width="150px" OnSelectedIndexChanged="ddlFitnessValidityPeriod_SelectedIndexChanged"
                                            AutoPostBack="True">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="3">3 Month</asp:ListItem>
                                            <asp:ListItem Value="6">6 Month</asp:ListItem>
                                            <asp:ListItem Value="9">9 Month</asp:ListItem>
                                            <asp:ListItem Value="12">1 Year</asp:ListItem>
                                            <asp:ListItem Value="24">2 Year</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left" style="width: 226px" nowrap="nowrap">Fitness Validity End Date<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtFitnessValidityEndDate" class="text1" runat="server" Width="145px" BackColor="DarkGray"
                                            ReadOnly="True"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="left" style="width: 226px">Vehicle RTA Circle<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtVehicleRTACircle" class="text1" runat="server" Width="145px" MaxLength="35"
                                            onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                    </td>
                                    <td align="center">&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left" style="width: 226px">Fitness Receipt No.<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtFitnessReceiptNo" class="text1" runat="server" Width="145px" MaxLength="15"
                                            onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="left" style="width: 226px">Fitness Fee<span style="color: Red">*</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtFitnessFee" runat="server" class="text1" onkeypress="return isDecimalNumberKey(event);"
                                            Width="145px" MaxLength="9"></asp:TextBox>
                                    </td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="left" style="width: 226px">&nbsp;
                                    </td>
                                    <td align="left" colspan="2">&nbsp;
                                    </td>
                                    <td align="center">&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center"></td>
                                    <td align="center" style="width: 226px">
                                        <asp:Button ID="btSave" runat="server" Text="Save" OnClick="btSave_Click" />
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btReset" runat="server" Text="Reset" OnClick="btReset_Click" />
                                    </td>
                                    <td align="center" style="width: 50px">&nbsp;
                                    </td>
                                    <td align="center">
                                        <asp:LinkButton ID="lbtnViewHistory" runat="server" Visible="False">View History</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;
                                    </td>
                                    <td align="center" style="width: 226px"></td>
                                    <td align="left" colspan="2"></td>
                                    <td align="center"></td>
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
                        <asp:GridView ID="gvFitnessRenewal" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" GridLines="None" OnRowCommand="gvFitnessRenewal_RowCommand"
                            Width="630px" OnRowDataBound="gvFitnessRenewal_RowDataBound" AllowPaging="True"
                            EmptyDataText="No Records Found" OnPageIndexChanging="gvFitnessRenewal_PageIndexChanging"
                            CssClass="mydatagrid" PagerStyle-CssClass="pager"
                            HeaderStyle-CssClass="header" CellSpacing="2">
                            <RowStyle CssClass="rows" />
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleNumber") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FRValidity StartDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFRValidityStartDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRValidityStartDate") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FRValidity Period">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFRValidityPeriod" Visible="false" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRValidityPeriod") %>'>
                                        </asp:Label>
                                        <asp:Label ID="lblFRValidityPeriodText" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FRValidity EndDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFRValidityEndDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRValidityEndDate") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle RTACircle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleRTACircle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleRTACircle") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FRReceipt No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFRReceiptNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRReceiptNo") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FRFee">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFRFee" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRFee") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="fitnessRenewalEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FitnessRenewalID") %>'
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
                <asp:HiddenField ID="vehiclePurchaseDate" runat="server" />
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

