<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VehicleInsurance, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="css/bootstrap.min.css" rel="stylesheet" />--%>

    <%--<style>
        .button {
            display: inline-block;
            border-radius: 4px;
            border: none;
            color: #FFFFFF;
            text-align: center;
            font-size: 28px;
            padding: 0px;
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
    </style>--%>

    <script language="javascript" type="text/javascript">

        function validation() {


            var District = document.getElementById('<%= txtDistrict.ClientID %>');
            var InsuranceType = document.getElementById('<%= txtInsuranceType.ClientID %>');
            var InsuranceTypeDdl = document.getElementById('<%= ddlInsuranceType.ClientID %>');
            var InsuranceAgency = document.getElementById('<%= txtInsuranceAgency.ClientID %>');
            var InsuranceAgencyDdl = document.getElementById('<%= ddlInsuranceAgency.ClientID %>');
            var InsurancePolicyNo = document.getElementById('<%= txtInsurancePolicyNo.ClientID %>');
            var CurrentPolicyEndDate = document.getElementById('<%= txtCurrentPolicyEndDate.ClientID %>');
            var ReceiptNumber = document.getElementById('<%= txtReceiptNumber.ClientID %>');
            var FeesPaid = document.getElementById('<%= txtFeesPaid.ClientID %>');
            var FeesPaidDate = document.getElementById('<%= txtFeesPaidDate.ClientID %>');
            var PolicyStartDate = document.getElementById('<%= txtPolicyStartDate.ClientID %>');
            var PolicyValidityPeriod = document.getElementById('<%= ddlPolicyValidityPeriod.ClientID %>');
            var vehiclePurchaseDate = document.getElementById('<%= vehiclePurchaseDate.ClientID %>');
            //var PolicyEndDate = document.getElementById('<%= txtPolicyEndDate.ClientID %>');

            var now = new Date();
            var id = document.getElementById('<%= ddlVehicleNo.ClientID %>');
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

            if (!RequiredValidation(District, "District Cannot be Blank"))
                return false;


            if (document.getElementById('<%= chkBoxChangeInsuranceDetails.ClientID %>').checked) {

                if (InsuranceTypeDdl.selectedIndex == 0) {
                    alert("Please select Insurance Type");
                    InsuranceTypeDdl.focus();
                    return false;
                }

                if (InsuranceAgencyDdl.selectedIndex == 0) {
                    alert("Please select Insurance Agency");
                    InsuranceAgencyDdl.focus();
                    return false;
                }
            }
            else {
                if (!RequiredValidation(InsuranceType, "Insurance Type Cannot be Blank"))
                    return false;
                if (!RequiredValidation(InsuranceAgency, "Insurance Agency Cannot be Blank"))
                    return false;
            }

            if (!RequiredValidation(InsurancePolicyNo, "Insurance Policy Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(CurrentPolicyEndDate, "Current Policy End Date Cannot be Blank"))
                return false;

            if (!isValidDate(CurrentPolicyEndDate.value)) {
                alert("Enter Valid Current Policy End Date");
                CurrentPolicyEndDate.focus();
                return false;
            }

            if (!RequiredValidation(ReceiptNumber, "Receipt Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(FeesPaid, "Fees Paid Cannot be Blank"))
                return false;

            if (!RequiredValidation(FeesPaidDate, "Fees Paid Date Cannot be Blank"))
                return false;

            if (!isValidDate(FeesPaidDate.value)) {
                alert("Enter Valid Fees Paid Date");
                FeesPaidDate.focus();
                return false;
            }

            if (Date.parse(FeesPaidDate.value) > Date.parse(now)) {
                alert("Fees Paid Date should not be greater than Current Date");
                PolicyStartDate.focus();
                return false;
            }

            //            if (Date.parse(FeesPaidDate.value) > Date.parse(vehiclePurchaseDate.value)) {
            //                alert("Fees Paid Date should not be less than Purchase Date.(PurchaseDate-" + vehiclePurchaseDate.value + ")");
            //                PolicyStartDate.focus();
            //                return false;
            //            }

            if (!RequiredValidation(PolicyStartDate, "Policy Start Date Cannot be Blank"))
                return false;

            if (!isValidDate(PolicyStartDate.value)) {
                alert("Enter Valid Policy Start Date");
                PolicyStartDate.focus();
                return false;
            }

            if (Date.parse(PolicyStartDate.value) > Date.parse(now)) {
                alert("Policy Start Date should not be greater than Current Date");
                PolicyStartDate.focus();
                return false;
            }

            if (Date.parse(PolicyStartDate.value) < Date.parse(FeesPaidDate.value)) {
                alert("Policy Start Date should not be less than Fees Paid Date");
                PolicyStartDate.focus();
                return false;
            }

            if (Date.parse(PolicyStartDate.value) <= Date.parse(CurrentPolicyEndDate.value)) {
                alert("Policy Start Date should  be greater than Current Policy End Date");
                PolicyStartDate.focus();
                return false;
            }

            if (PolicyValidityPeriod.selectedIndex == 0) {
                alert("Please select Policy Validity Period");
                PolicyValidityPeriod.focus();
                return false;
            }

            //            if (!RequiredValidation(PolicyEndDate, "Policy End Date Cannot be Blank"))
            //                return false;

            //            if (!isValidDate(PolicyEndDate.value)) {
            //                alert("Enter Valid Policy End Date");
            //                PolicyEndDate.focus();
            //                return false;
            //            }

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

    </script>

    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
   
        <ContentTemplate>
            <div class="dropdown">
                <table style="width: 103%" cellpadding="2" cellspacing="2" align="right">
                    <tr>
                        <td style="width: 261px">&nbsp; &nbsp;
                        </td>
                        <td style="width: 75px" width="300px" align="right">
                            <a href="VehicleInsuranceViewHistory.aspx">View History</a>
                        </td>
                    </tr>
                </table>
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <td class="rowseparator" style="width: 589px"></td>
                    </tr>
                    <tr>
                        <td style="width: 589px">
                            <%-- <fieldset style="padding: 10px; width: 645px;">--%>

                            <asp:Panel ID="pnlVehicleInsurance" runat="server" Width="688px">
                                <table style="width: 86%" cellpadding="2" cellspacing="2">

                                    <tr>
                                        <td style="width: 296px"></td>
                                        <td style="width: 572px"></td>
                                        <td align="left" style="width: 244px">Vehicle No.<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNo" runat="server" Width="150px" OnSelectedIndexChanged="ddlVehicleNo_SelectedIndexChanged"
                                                AutoPostBack="True" DropDownStyle="DropDownList">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </cc1:ComboBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">District<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDistrict" class="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px"></asp:TextBox>
                                        </td>
                                        <td rowspan="2">
                                            <asp:CheckBox ID="chkBoxChangeInsuranceDetails" runat="server" AutoPostBack="True"
                                                OnCheckedChanged="chkBoxChangeInsuranceDetails_CheckedChanged" Text="Change Insurance Details"
                                                Width="100px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Insurance Type<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtInsuranceType" class="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px"></asp:TextBox>
                                            <asp:DropDownList ID="ddlInsuranceType" class="text1" runat="server" OnSelectedIndexChanged="ddlInsuranceType_SelectedIndexChanged"
                                                Visible="False" Width="150px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Insurance Agency<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtInsuranceAgency" class="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px"></asp:TextBox>
                                            <asp:DropDownList ID="ddlInsuranceAgency" class="text1" runat="server" OnSelectedIndexChanged="ddlInsuranceAgency_SelectedIndexChanged"
                                                Visible="False" Width="150px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Insurance Policy No
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtInsurancePolicyNo" class="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px" onkeypress="return alphanumeric_only(event);" onpaste="return false;"
                                                MaxLength="20"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Current Policy End Date<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtCurrentPolicyEndDate" class="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Receipt Number<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtReceiptNumber" CssClass="text1" runat="server" MaxLength="15" Width="145px" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Fees Paid<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtFeesPaid" runat="server" class="text1" MaxLength="10" onkeypress="return isDecimalNumberKey(event);"
                                                Width="145px"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Fees Paid Date<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtFeesPaidDate" class="text1" runat="server" Width="145px" onkeypress="return false"
                                                oncut="return false;" onpaste="return false;">
                                            </asp:TextBox>
                                            <cc1:CalendarExtender ID="calextFeesPaidDate" runat="server" Format="MM/dd/yyyy"
                                                PopupButtonID="imgBtnFeesPaidDate" TargetControlID="txtFeesPaidDate">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnFeesPaidDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Policy Start Date<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPolicyStartDate" class="text1" runat="server" AutoPostBack="true" OnTextChanged="txtPolicyStartDate_TextChanged"
                                                Width="145px" onkeypress="return false" oncut="return false;" onpaste="return false;">
                                            </asp:TextBox>
                                            <cc1:CalendarExtender ID="calextPolicyStartDate" runat="server" Format="MM/dd/yyyy"
                                                PopupButtonID="imgBtnPolicyStartDate" TargetControlID="txtPolicyStartDate">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnPolicyStartDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px" nowrap="nowrap">Policy Validity Period<span style="color: Red">*</span>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList class="text1" ID="ddlPolicyValidityPeriod" runat="server" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlPolicyValidityPeriod_SelectedIndexChanged" Width="150px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="3">3 Month</asp:ListItem>
                                                <asp:ListItem Value="6">6 Month</asp:ListItem>
                                                <asp:ListItem Value="9">9 Month</asp:ListItem>
                                                <asp:ListItem Value="12">1 Year</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="left" style="width: 244px">Policy End Date
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPolicyEndDate" runat="server" BackColor="DarkGray" ReadOnly="True"
                                                Width="145px"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp;
                                        </td>
                                        <td align="left" style="width: 244px">&nbsp;
                                        </td>
                                        <td align="left">&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td align="center" style="width: 244px">
                                            <asp:Button ID="btSave" CssClass="button" runat="server" OnClick="btSave_Click" Text="Save" Style="background-color: #4CAF50;" />
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btReset" CssClass="button" runat="server" OnClick="btReset_Click" Text="Reset" Style="background-color: red;" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>

                            <%-- </fieldset>--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator" style="width: 589px"></td>
                    </tr>
                    <asp:HiddenField ID="vehiclePurchaseDate" runat="server" />
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

