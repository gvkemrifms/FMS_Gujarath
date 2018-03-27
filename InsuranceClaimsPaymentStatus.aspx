<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.StatutoryCompliance.InsuranceClaims.InsuranceClaimsPaymentStatus, App_Web_m0x5b0wx" %>

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
    </style>

    <script language="javascript" type="text/javascript">
        function validation() {

            var SpotSurveyor = document.getElementById('<%= txtSpotSurveyor.ClientID %>');
            var FinalSurveyor = document.getElementById('<%= txtFinalSurveyor.ClientID %>');
            var ReinspectionSurveyor = document.getElementById('<%= txtReinspectionSurveyor.ClientID %>');
            var ClaimFormSubmissionDate = document.getElementById('<%= txtClaimFormSubmissionDate.ClientID %>');
            var TotalCostOfRepairs = document.getElementById('<%= txtTotalCostOfRepairs.ClientID %>');
            var SurveyorAssessmentValue = document.getElementById('<%= txtSurveyorAssessmentValue.ClientID %>');
            var BillSubmissionDate = document.getElementById('<%= txtBillSubmissionDate.ClientID %>');
            var PaymentStatus = document.getElementById('<%= ddlPaymentStatus.ClientID %>');
            var Remarks = document.getElementById('<%= txtRemarks.ClientID %>');
            var PaymentReceivedDate = document.getElementById('<%= txtPaymentReceivedDate.ClientID %>');
            var ChequeNo = document.getElementById('<%= txtChequeNo.ClientID %>');
            var AmountReceivedFromInsurance = document.getElementById('<%= txtAmountReceivedFromInsurance.ClientID %>');
            var CostToCompany = document.getElementById('<%= txtCostToCompany.ClientID %>');


            if (!RequiredValidation(SpotSurveyor, "Spot Surveyor Cannot be Blank"))
                return false;

            if (!RequiredValidation(FinalSurveyor, "Final Surveyor Cannot be Blank"))
                return false;

            if (!RequiredValidation(ReinspectionSurveyor, "Reinspection Surveyor Cannot be Blank"))
                return false;

            if (!RequiredValidation(ClaimFormSubmissionDate, "Claim Form Submission Date Cannot be Blank"))
                return false;

            if (!isValidDate(ClaimFormSubmissionDate.value)) {
                alert("Enter Valid Date");
                ClaimFormSubmissionDate.focus();
                return false;
            }

            if (!RequiredValidation(TotalCostOfRepairs, "Total Cost Of Repairs Cannot be Blank"))
                return false;

            if (!RequiredValidation(SurveyorAssessmentValue, "Surveyor Assessment Value Cannot be Blank"))
                return false;

            if (!RequiredValidation(BillSubmissionDate, "Bill Submission Date Cannot be Blank"))
                return false;

            if (!isValidDate(BillSubmissionDate.value)) {
                alert("Enter Valid Date");
                BillSubmissionDate.focus();
                return false;
            }

            if (PaymentStatus.selectedIndex == 0) {
                alert("Please select Payment Status");
                PaymentStatus.focus();
                return false;
            }

            if (!RequiredValidation(Remarks, "Remarks Cannot be Blank"))
                return false;

            if (!RequiredValidation(PaymentReceivedDate, "Payment Received Date Cannot be Blank"))
                return false;

            if (!isValidDate(PaymentReceivedDate.value)) {
                alert("Enter Valid Date");
                PaymentReceivedDate.focus();
                return false;
            }

            if (!RequiredValidation(ChequeNo, "Cheque No Cannot be Blank"))
                return false;

            if (!RequiredValidation(AmountReceivedFromInsurance, "Amount Received From Insurance Cannot be Blank"))
                return false;

            if (!RequiredValidation(CostToCompany, "Cost To Company Cannot be Blank"))
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

        function alphanumeric_withspace_only(e) {
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

        function remark(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode != 34) && (keycode != 39)) {
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

                        <table style="width: 100%">
                            <tr>
                                <td align="center" colspan="4">
                                    <b>Accident Details</b>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="3">
                                    <b>Insurance Details</b>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 120px" nowrap="nowrap">Vehicle Number
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" style="width: 20px" colspan="2">
                                    <asp:TextBox ID="txtVehicleNumber" CssClass="text1" runat="server" Width="145px" BackColor="DarkGray"
                                        ReadOnly="True"></asp:TextBox>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="left">Policy Number
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center">
                                    <asp:TextBox ID="txtPolicyNumber" CssClass="text1" runat="server" Width="145px" BackColor="DarkGray"
                                        ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 181px">Accident Date/Time
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2" style="width: 38px">
                                    <asp:TextBox ID="txtAccidentDateTime" CssClass="text1" runat="server" BackColor="DarkGray" Height="20px"
                                        ReadOnly="True" Width="145px"></asp:TextBox>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="left">Agency
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center">
                                    <asp:TextBox ID="txtAgency" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True" Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 181px">Accident Title
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2" style="width: 38px">
                                    <asp:TextBox ID="txtAccidentTitle" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px"></asp:TextBox>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="left">Insurance Start Date
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center">
                                    <asp:TextBox ID="txtInsuranceStartDate" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 181px">Spot Surveyor
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2" style="width: 38px">
                                    <asp:TextBox ID="txtSpotSurveyor" CssClass="text1" runat="server" Width="145px" onkeypress="return alpha_only(event);"
                                        MaxLength="35"></asp:TextBox>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="left">Insurance End Date
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center">
                                    <asp:TextBox ID="txtInsuranceEndDate" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 181px">Final Surveyor
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2" style="width: 38px">
                                    <asp:TextBox ID="txtFinalSurveyor" CssClass="text1" runat="server" Width="145px" onkeypress="return alpha_only(event);"
                                        MaxLength="35"></asp:TextBox>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="left">Date Insurance
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center">
                                    <asp:TextBox ID="txtDateInsurance" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 181px">Reinspection Surveyor
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2" style="width: 38px">
                                    <asp:TextBox ID="txtReinspectionSurveyor" CssClass="text1" runat="server" Width="145px" onkeypress="return alpha_only(event);"
                                        MaxLength="35"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3"></td>
                                <td align="center" colspan="2"></td>
                                <td align="center" colspan="2"></td>
                            </tr>
                            <tr>
                                <td align="center" rowspan="12" style="width: 116px">&nbsp;
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap">Claim Form Submission Date<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtClaimFormSubmissionDate" CssClass="text1" runat="server" Width="145px" onkeypress="return false"
                                        oncut="return false;" onpaste="return false;"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <cc1:CalendarExtender ID="calExtClaimFormSubmissionDate" runat="server" Enabled="True"
                                        Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarClaimFormSubmissionDate" TargetControlID="txtClaimFormSubmissionDate">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="imgBtnCalendarClaimFormSubmissionDate" runat="server" alt=""
                                        src="images/Calendar.gif" Style="vertical-align: top" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Total Cost Of Repairs<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtTotalCostOfRepairs" CssClass="text1" runat="server" onkeypress="return isDecimalNumberKey(event);"
                                        Width="145px" MaxLength="7"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Surveyor Assessment Value<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtSurveyorAssessmentValue" CssClass="text1" runat="server" onkeypress="return isDecimalNumberKey(event);"
                                        Width="145px" MaxLength="7"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Bill Submission Date<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtBillSubmissionDate" CssClass="text1" runat="server" Width="145px" onkeypress="return false"
                                        oncut="return false;" onpaste="return false;"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <cc1:CalendarExtender ID="calExtBillSubmissionDate" runat="server" Enabled="True"
                                        Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarBillSubmissionDate" TargetControlID="txtBillSubmissionDate">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="imgBtnCalendarBillSubmissionDate" runat="server" alt="" src="images/Calendar.gif"
                                        Style="vertical-align: top" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Payment Status<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:DropDownList ID="ddlPaymentStatus" class="text1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPaymentStatus_SelectedIndexChanged"
                                        Width="150px">
                                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        <asp:ListItem Value="0">Received</asp:ListItem>
                                        <asp:ListItem Value="1">Rejected</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Remarks<span style="color: Red">*</span>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="text1" TextMode="MultiLine" Width="145px" onkeypress="return remark(event);"
                                        MaxLength="200"></asp:TextBox>
                                </td>
                                <td align="center">
                                    <asp:CheckBox ID="chbxCloseClaim" runat="server" Text="  Close This Claim" Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblPaymentReceivedDate" runat="server" Text="Payment Received Date"></asp:Label>
                                    <asp:Label ID="lblpaymntrecdt" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtPaymentReceivedDate" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px" onkeypress="return false"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:ImageButton ID="imgBtnCalendarPaymentReceivedDate" runat="server" alt="" src="images/Calendar.gif"
                                        Style="vertical-align: top" />
                                    <cc1:CalendarExtender ID="calExtPaymentReceivedDate" runat="server" Enabled="True"
                                        Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarPaymentReceivedDate" TargetControlID="txtPaymentReceivedDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblChequeNo" runat="server" Text="Cheque No"></asp:Label>
                                    <asp:Label ID="lblChkNo" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtChequeNo" CssClass="text1" runat="server" BackColor="DarkGray" ReadOnly="True"
                                        Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3" nowrap="nowrap">
                                    <asp:Label ID="lblAmountReceivedFromInsurance" runat="server" Text="Amount Received From Insurance"></asp:Label>
                                    <asp:Label ID="lblamtrec" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtAmountReceivedFromInsurance" CssClass="text1" runat="server" AutoPostBack="True"
                                        BackColor="DarkGray" onkeypress="return isDecimalNumberKey(event);" OnTextChanged="txtAmountReceivedFromInsurance_TextChanged"
                                        ReadOnly="True" Width="145px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">Cost To Company
                                </td>
                                <td class="columnseparator"></td>
                                <td align="center" colspan="2">
                                    <asp:TextBox ID="txtCostToCompany" runat="server" CssClass="text1" BackColor="DarkGray" onkeypress="return isDecimalNumberKey(event);"
                                        ReadOnly="True" Width="145px"></asp:TextBox>
                                </td>
                                <td align="center">
                                    <asp:LinkButton ID="lbtnCostComparison" runat="server">Cost Comparison</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="3">
                                    <asp:Button ID="btSave" CssClass="button" Style="background-color: #4CAF50;" runat="server" OnClick="btSave_Click" Text="Save" />
                                </td>
                                <td align="right" colspan="3">
                                    <asp:Button ID="btReset" CssClass="button" Style="background-color: red;" runat="server" OnClick="btReset_Click" Text="Reset" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="3">&nbsp;
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>
            <tr>
                <td class="rowseparator"></td>
            </tr>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

