<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.TemporaryVehicleDetails, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/newStyles.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">



        var now = new Date();
        var inspectedDate;
        var purchaseDate;
        var manufacturingDate;



        function validation(obj, Id) {
            var EngineNo = document.getElementById('<%= txtEngineNo.ClientID %>');
            var ChassisNo = document.getElementById('<%=txtChassisNo.ClientID %>');
            var VehicleNo = document.getElementById('<%=txtVehicleNo.ClientID %>');
            var InspectedBy = document.getElementById('<%=txtInspectedBy.ClientID %>');
            var InspectedDate = document.getElementById('<%=txtInspectedDate.ClientID %>');
            var VehicleStatus = document.getElementById('<%=ddlVehicleStatus.ClientID %>');


            if (!RequiredValidation(EngineNo, "Engine Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(ChassisNo, "Chassis Number cannot be Blank"))
                return false;

            if (!RequiredValidation(VehicleNo, "Vehicle Number cannot be Blank"))
                return false;

            if (!isValidVehicleNumber(VehicleNo.value)) {
                VehicleNo.value = "";
                VehicleNo.focus();
                return false;
            }

            if (!RequiredValidation(InspectedBy, "Inspected By cannot be Blank"))
                return false;

            if (!RequiredValidation(InspectedDate, "Inspected Date cannot be Blank"))
                return false;

            if (trim(InspectedDate.value) != "") {
                if (!isValidDate(InspectedDate.value)) {
                    alert("Enter Valid Date");
                    InspectedDate.focus();
                    return false;
                }
            }
            inspectedDate = InspectedDate.value;

            if (Date.parse(InspectedDate.value) > Date.parse(now)) {
                alert("Inspected Date should not be greater than Current Date");
                InspectedDate.focus();
                return false;
            }


            if (VehicleStatus.selectedIndex == 0) {
                alert("Please select Vehicle Status");
                VehicleStatus.focus();
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
        var stepNo = 0;

        function previousValidation() {
            if (stepNo > 0) {
                stepNo--;
            }
        }

        function stepvalidation() {
            ////-----------------Start of Validation of General Information----------------////


            if (stepNo == 0) {
                var VehicleModel = document.getElementById('<%=ddlVehicleModel.ClientID %>');
                var Kmpl = document.getElementById('<%=txtKmpl.ClientID %>')
                var VehicleType = document.getElementById('<%=ddlVehicleType.ClientID %>');
                var VehicleEmissionType = document.getElementById('<%=txtVehicleEmissionType.ClientID %>');
                var PurchaseDate = document.getElementById('<%=txtPurchaseDate.ClientID %>');
                var OwnerName = document.getElementById('<%=txtOwnerName.ClientID %>');
                var ManufacturerName = document.getElementById('<%=ddlManufacturerName.ClientID %>');
                var VehicleCost = document.getElementById('<%=txtVehicleCost.ClientID%>');
                var ManufacturingDate = document.getElementById('<%=txtManufacturingDate.ClientID %>');
                var EngineCapacity = document.getElementById('<%=txtEngineCapacity.ClientID %>');
                var FuelType = document.getElementById('<%=ddlFuelType.ClientID%>');

                if (VehicleModel.selectedIndex == 0) {
                    alert("Please select the Vehicle Model");
                    VehicleModel.focus();
                    return false;
                }


                if (!RequiredValidation(Kmpl, "Kmpl cannot be Blank"))
                    return false;

                if (VehicleType.selectedIndex == 0) {
                    alert("Please select the Vehicle Type");
                    VehicleType.focus();
                    return false;
                }

                if (!RequiredValidation(VehicleEmissionType, "VehicleEmission Type cannot be Blank"))
                    return false;

                if (!RequiredValidation(PurchaseDate, "Purchase Date cannot be Blank"))
                    return false;

                if (trim(PurchaseDate.value) != "") {
                    if (!isValidDate(PurchaseDate.value)) {
                        alert("Enter the valid Purchase Date");
                        PurchaseDate.focus();
                        return false;
                    }
                }

                purchaseDate = PurchaseDate.value;

                if (Date.parse(PurchaseDate.value) > Date.parse(now)) {
                    alert("Purchase Date should not be greater than Current Date");
                    PurchaseDate.focus();
                    return false;
                }

                if (Date.parse(PurchaseDate.value) > Date.parse(inspectedDate)) {
                    alert("Purchase Date should not be greater than Inspected Date.(Inspected Date-" + inspectedDate + ")");
                    PurchaseDate.focus();
                    return false;
                }




                if (!RequiredValidation(OwnerName, "OwnerName cannot be Blank"))
                    return false;

                if (ManufacturerName.selectedIndex == 0) {
                    alert("Please select the Manufacturer Name");
                    ManufacturerName.focus();
                    return false;
                }

                if (!RequiredValidation(VehicleCost, "Vehicle Cost cannot be Blank"))
                    return false;

                if (!RequiredValidation(ManufacturingDate, "Manufacturing Date cannot be Blank"))
                    return false; 8

                if (trim(ManufacturingDate.value) != "") {
                    if (!isValidDate(ManufacturingDate.value)) {
                        alert("Enter the valid Manufacturing Date");
                        ManufacturingDate.focus();
                        return false;
                    }
                }

                if (Date.parse(ManufacturingDate.value) > Date.parse(now)) {
                    alert("Manufacturing Date should not be greater than Current Date");
                    ManufacturingDate.focus();
                    return false;
                }

                if (Date.parse(ManufacturingDate.value) > Date.parse(purchaseDate)) {
                    alert("Manufacturing Date should not be greater than Purchase Date.(Purchase Date-" + purchaseDate + ")");
                    ManufacturingDate.focus();
                    return false;
                }

                if (!RequiredValidation(EngineCapacity, "Engine Capacity cannot be Blank"))
                    return false;


                if (FuelType.selectedIndex == 0) {
                    alert("Please select the Fuel Type");
                    FuelType.focus();
                    return false;
                }

                stepNo++;
            }

                //Insurance Information
            else if (stepNo == 1) {
                var District = document.getElementById('<%=ddlDistrict.ClientID %>');
                var InPolicyNo = document.getElementById('<%=txtInPolicyNo.ClientID %>')
                var InsType = document.getElementById('<%=ddlInsType.ClientID %>');
                var InsFee = document.getElementById('<%=txtInsFee.ClientID %>');
                var CurrentPolicyEndDate = document.getElementById('<%=txtCurrentPolicyEndDate.ClientID %>');
                var InsuranceReceiptNo = document.getElementById('<%=txtInsuranceReceiptNo.ClientID %>');
                var InsuranceFeesPaidDate = document.getElementById('<%=txtInsuranceFeesPaidDate.ClientID %>');
                var Agency = document.getElementById('<%=ddlAgency.ClientID%>');
                var ValEDate = document.getElementById('<%=txtValEDate.ClientID %>');
                var ValiSDate = document.getElementById('<%=txtValiSDate.ClientID %>');
                var PolicyValidityPeriod = document.getElementById('<%=ddlPolicyValidityPeriod.ClientID %>');

                if (District.selectedIndex == 0) {
                    alert("Please select the District");
                    District.focus();
                    return false;
                }

                if (!RequiredValidation(InPolicyNo, "Insurance Policy No cannot be Blank"))
                    return false;

                if (InsType.selectedIndex == 0) {
                    alert("Please select the Insurance Type");
                    InsType.focus();
                    return false;
                }

                if (!RequiredValidation(InsFee, "Insurance Fee cannot be Blank"))
                    return false;

                if (!RequiredValidation(CurrentPolicyEndDate, "Current Policy End Date cannot be Blank"))
                    return false;

                if (trim(CurrentPolicyEndDate.value) != "") {
                    if (!isValidDate(CurrentPolicyEndDate.value)) {
                        alert("Enter the valid Current Policy End Date");
                        CurrentPolicyEndDate.focus();
                        return false;
                    }
                }

                if (Date.parse(CurrentPolicyEndDate.value) < Date.parse(purchaseDate)) {
                    alert("Current Policy End Date should be greater than Purchase Date.(Purchase Date-" + purchaseDate + ")");
                    CurrentPolicyEndDate.focus();
                    return false;
                }



                if (!RequiredValidation(InsuranceReceiptNo, "Insurance Receipt No cannot be Blank"))
                    return false;

                if (!RequiredValidation(InsuranceFeesPaidDate, "Insurance Fees Paid Date cannot be Blank"))
                    return false;

                if (trim(InsuranceFeesPaidDate.value) != "") {
                    if (!isValidDate(InsuranceFeesPaidDate.value)) {
                        alert("Enter The valid Insurance Fees Paid Date");
                        InsuranceFeesPaidDate.focus();
                        return false;
                    }
                }

                if (Date.parse(InsuranceFeesPaidDate.value) > Date.parse(now)) {
                    alert("Insurance Fees Paid Date should not be greater than Current Date");
                    InsuranceFeesPaidDate.focus();
                    return false;
                }

                if (Date.parse(InsuranceFeesPaidDate.value) < Date.parse(purchaseDate)) {
                    alert("Insurance Fees Paid Date should be greater than Purchase Date.(Purchase Date-" + purchaseDate + ")");
                    InsuranceFeesPaidDate.focus();
                    return false;
                }



                if (Agency.selectedIndex == 0) {
                    alert("Please select the Agency");
                    Agency.focus();
                    return false;
                }

                if (!RequiredValidation(ValiSDate, "Validity Start Date cannot be Blank"))
                    return false;

                if (trim(ValiSDate.value) != "") {
                    if (!isValidDate(ValiSDate.value)) {
                        alert("Enter The Valid Start Date");
                        ValiSDate.focus();
                        return false;
                    }
                }

                //                if(Date.parse(ValiSDate.value) > Date.parse(now))
                //                {
                //                    alert("Validity Start Date should not be greater than Current Date");
                //                    ValiSDate.focus();
                //                    return false;
                //                }

                insvaliditystartDate = ValiSDate.value;



                if (Date.parse(ValiSDate.value) < Date.parse(InsuranceFeesPaidDate.value)) {
                    alert("Validity Start Date should not be less than Insurance Fees Paid Date");
                    ValiSDate.focus();
                    return false;
                }

                if (Date.parse(ValiSDate.value) <= Date.parse(CurrentPolicyEndDate.value)) {
                    alert("Validity Start Date should not be less than Current Policy End Date");
                    ValiSDate.focus();
                    return false;
                }

                if (PolicyValidityPeriod.selectedIndex == 0) {
                    alert("Please Select The Policy Validity Period");
                    PolicyValidityPeriod.focus();
                    return false;
                }

                stepNo++;
            }
            else if (stepNo == 2) {
                var FL = document.getElementById('<%=txtFL.ClientID %>');
                var FR = document.getElementById('<%=txtFR.ClientID %>');
                var RL = document.getElementById('<%=txtRL.ClientID %>');
                var RR = document.getElementById('<%=txtRR.ClientID %>');
                var SpareWheel = document.getElementById('<%=txtSpareWheel.ClientID %>');
                var TyreMakeFL = document.getElementById('<%=ddlTyreMakeFL.ClientID %>');
                var TyreModelSizeFL = document.getElementById('<%=ddlModelSizeFL.ClientID %>');
                var TyreMakeFR = document.getElementById('<%=ddlTyreMakeFR.ClientID %>');
                var TyreModelSizeFR = document.getElementById('<%=ddlModelSizeFR.ClientID %>');
                var TyreMakeRL = document.getElementById('<%=ddlTyreMakeRL.ClientID %>');
                var TyreModelSizeRL = document.getElementById('<%=ddlModelSizeRL.ClientID %>');
                var TyreMakeRR = document.getElementById('<%=ddlTyreMakeRR.ClientID %>');
                var TyreModelSizeRR = document.getElementById('<%=ddlModelSizeRR.ClientID %>');
                var TyreMakeSpareWheel = document.getElementById('<%=ddlTyreMakeSpareWheel.ClientID %>');
                var TyreModelSizeSpareWheel = document.getElementById('<%=ddlModelSizeSpareWheel.ClientID %>');
                var OdometerReading = document.getElementById('<%=txtOdometerReading.ClientID %>');
                var Tyre = [FL.value, FR.value, RL.value, RR.value, SpareWheel.value];

                if (!RequiredValidation(FL, "Front Left cannot be Blank"))
                    return false;

                if (!RequiredValidation(FR, "Front Right cannot be Blank"))
                    return false;


                if (!RequiredValidation(RL, "Rear Left cannot be Blank"))
                    return false;

                if (!RequiredValidation(RR, "Rear Right cannot be Blank"))
                    return false;


                if (!RequiredValidation(SpareWheel, "Spare Wheel cannot be Blank"))
                    return false;


                for (var i = 0; i < (Tyre.length - 1) ; i++) {
                    for (var j = i + 1; j < Tyre.length; j++) {
                        if (Tyre[i] == Tyre[j]) {
                            alert("Tyre numbers should be unique");
                            if (j == 1)
                                FR.focus();
                            else if (j == 2)
                                RL.focus();
                            else if (j == 3)
                                RR.focus();
                            else
                                SpareWheel.focus();

                            return false;
                        }
                    }
                }


                if (TyreMakeFL.selectedIndex == 0) {
                    alert("Please Select The Tyre Make FL");
                    TyreMakeFL.focus();
                    return false;
                }

                if (TyreModelSizeFL.selectedIndex == 0) {
                    alert("Please Select The Tyre Model Size FL");
                    TyreModelSizeFL.focus();
                    return false;
                }
                if (TyreMakeFR.selectedIndex == 0) {
                    alert("Please Select The Tyre Make FR");
                    TyreMakeFR.focus();
                    return false;
                }

                if (TyreModelSizeFR.selectedIndex == 0) {
                    alert("Please Select The Tyre Model Size FL");
                    TyreModelSizeFR.focus();
                    return false;
                }
                if (TyreMakeRL.selectedIndex == 0) {
                    alert("Please Select The Tyre Make RL");
                    TyreMakeRL.focus();
                    return false;
                }

                if (TyreModelSizeRL.selectedIndex == 0) {
                    alert("Please Select The Tyre Model Size RL");
                    TyreModelSizeRL.focus();
                    return false;
                }
                if (TyreMakeRR.selectedIndex == 0) {
                    alert("Please Select The Tyre Make RR");
                    TyreMakeRR.focus();
                    return false;
                }

                if (TyreModelSizeRR.selectedIndex == 0) {
                    alert("Please Select The Tyre Model Size RR");
                    TyreModelSizeRR.focus();
                    return false;
                }
                if (TyreMakeSpareWheel.selectedIndex == 0) {
                    alert("Please Select The Tyre Make SpareWheel");
                    TyreMakeSpareWheel.focus();
                    return false;
                }

                if (TyreModelSizeSpareWheel.selectedIndex == 0) {
                    alert("Please Select The Tyre Model Size SpareWheel");
                    TyreModelSizeSpareWheel.focus();
                    return false;
                }

                if (!RequiredValidation(OdometerReading, "Odometer Reading cannot be Blank"))
                    return false;

                stepNo++;
            }
}

function finalStepValidation() {
    var Battery1 = document.getElementById('<%=txtBattery1.ClientID %>');
            var Battery2 = document.getElementById('<%=txtBattery2.ClientID %>');
            var BatteryMakeBattery1 = document.getElementById('<%=ddlBatteryMakeBattery1.ClientID %>');
            var BatteryModelCapacityBattery1 = document.getElementById('<%=ddlModelCapacityBattery1.ClientID %>');
            var BatteryMakeBattery2 = document.getElementById('<%=ddlBatteryMakeBattery2.ClientID %>');
            var BatteryModelCapacityBattery2 = document.getElementById('<%=ddlModelCapacityBattery2.ClientID %>');

            if (!RequiredValidation(Battery1, "Battery1 cannot be Blank"))
                return false;

            if (!RequiredValidation(Battery2, "Battery2 cannot be Blank"))
                return false;

            if (Battery1.value == Battery2.value) {
                alert("Battery Numbers should be unique");
                Battery2.focus();
                return false;
            }

            if (BatteryMakeBattery1.selectedIndex == 0) {
                alert("Please Select The Battery Make Battery1");
                BatteryMakeBattery1.focus();
                return false;
            }
            if (BatteryModelCapacityBattery1.selectedIndex == 0) {
                alert("Please Select The Battery Model Capacity Battery1");
                BatteryModelCapacityBattery1.focus();
                return false;
            }
            if (BatteryMakeBattery2.selectedIndex == 0) {
                alert("Please Select The Battery Make Battery2");
                BatteryMakeBattery2.focus();
                return false;
            }
            if (BatteryModelCapacityBattery2.selectedIndex == 0) {
                alert("Please Select The Battery Model Capacity Battery2");
                BatteryModelCapacityBattery2.focus();
                return false;
            }
        }

        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
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

        function isValidVehicleNumber(VehicleNo) {
            if (VehicleNo.match(/^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{1,4}$/)) {
                return true;
            }
            else {
                alert("Enter a valid Vehicle Number eg - 'AP27HY9834' or 'AP27H8'");

                VehicleNo.value = "";
                return false;
            }
        }

    </script>

<%--    <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlTemporaryVehicleDetails" runat="server">
               
                    <asp:HiddenField ID="hdnStepNo" runat="server" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Wizard ID="tempVehDetWizard" runat="server" Height="224px" Width="664px" ActiveStepIndex="0"
                        OnFinishButtonClick="Wizard1_FinishButtonClick" DisplaySideBar="False">
                        <StartNavigationTemplate>
                            <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext" Text="Next" />
                        </StartNavigationTemplate>
                        <WizardSteps>
                            <asp:WizardStep ID="WizardStep1" runat="server" Title="Invoice and Base Details ">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="6" style="text-align: center">
                                            <b>Invoice and Base Details </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Engine No<span style="color: #FF0000">*</span>
                                        </td>
                                        <td style="width: 88px" colspan="2">
                                            <asp:TextBox ID="txtEngineNo" runat="server" CssClass="text1" Width="100px" MaxLength="15" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td colspan="2">&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Chassis No<span style="color: #FF0000">*</span>
                                        </td>
                                        <td style="width: 88px" nowrap="nowrap" colspan="2">
                                            <%-- <cc1:CalendarExtender ID="calExtInvoiceDate" runat="server" Enabled="True" PopupButtonID="imgBtnCalendarInvoiceDate"
                                        TargetControlID="txtInvoiceDate" Format="MM/dd/yyyy">
                                    </cc1:CalendarExtender>--%>
                                            <asp:TextBox ID="txtChassisNo"  CssClass="text1" runat="server" Width="100px" MaxLength="15" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Vehicle No<span style="color: #FF0000">*</span>
                                        </td>
                                        <td style="width: 88px" colspan="2">
                                            <asp:TextBox ID="txtVehicleNo"  CssClass="text1" runat="server" Width="100px" MaxLength="10"
                                                onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Inspected By<span style="color: #FF0000">*</span>
                                        </td>
                                        <td style="width: 88px" colspan="2">
                                            <asp:TextBox ID="txtInspectedBy"  CssClass="text1" runat="server" Width="100px" MaxLength="35" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                        </td>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Inspected Date<span style="color: #FF0000">*</span>
                                        </td>
                                        <td style="width: 88px">
                                            <asp:TextBox ID="txtInspectedDate"  CssClass="text1" runat="server" Width="100px" oncut="return false;"
                                                onpaste="return false;" onkeypress="return false"></asp:TextBox>
                                            <cc1:CalendarExtender ID="calExtInspectedDate" runat="server" TargetControlID="txtInspectedDate"
                                                PopupButtonID="imgBtnCalendarInspectedDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td style="width: 88px">
                                            <asp:ImageButton ID="imgBtnCalendarInspectedDate" runat="server" alt="" Height="19px"
                                                src="images/Calendar.gif" Style="vertical-align: top" Width="19px" />
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                    <%-- <tr>
                                        <td style="width: 177px">
                                            &nbsp;
                                        </td>
                                        <td style="width: 198px">
                                            Vehicle Type<span style="color: #FF0000">*</span> &nbsp;&nbsp; &nbsp;
                                        </td>
                                        <td style="width: 88px" colspan="2">
                                            <asp:DropDownList ID="ddlVehicleTypeIBD" runat="server" Width="100px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px">
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td style="width: 177px">&nbsp;
                                        </td>
                                        <td style="width: 198px">Vehicle Status
                                        </td>
                                        <td style="width: 88px" colspan="2">
                                            <asp:DropDownList ID="ddlVehicleStatus" runat="server"  CssClass="text1" Width="100px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="1">Active</asp:ListItem>
                                                <asp:ListItem Value="0">Inactive</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 177px"></td>
                                    </tr>
                                </table>
                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep2" runat="server" Title="General Information ">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="4" style="text-align: center">
                                            <b>General Information </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Vehicle Model<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlVehicleModel" CssClass="text1" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>KMPL<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtKmpl" CssClass="text1" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                                MaxLength="5"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Vehicle Type<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlVehicleType" CssClass="text1" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Vehicle Emission Type<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleEmissionType" CssClass="text1" runat="server" Width="100px" MaxLength="20"
                                                onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Purchase Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPurchaseDate" CssClass="text1" runat="server" Width="100px" onkeypress="return false" oncut="return false;"
                                                onpaste="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnPurchaseDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="calExtPurchaseDate" runat="server" TargetControlID="txtPurchaseDate"
                                                PopupButtonID="imgBtnPurchaseDate" Format="MM/dd/yyyy" Enabled="True">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Owner Name<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOwnerName" CssClass="text1" runat="server" Width="100px" MaxLength="35" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Manufacturer Name<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlManufacturerName" CssClass="text1" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Vehicle Cost<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleCost" CssClass="text1" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                                MaxLength="11"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Manufacturing Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtManufacturingDate" runat="server" Width="100px" onkeypress="return false" oncut="return false;"
                                                onpaste="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnManufacturingDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="calExtManufacturingDate" runat="server" TargetControlID="txtManufacturingDate"
                                                PopupButtonID="imgBtnManufacturingDate" Format="MM/dd/yyyy" Enabled="True">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Engine Capacity<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEngineCapacity" runat="server" Width="100px" onkeypress="return alphanumeric_only(event);"
                                                MaxLength="8"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 114px">&nbsp;
                                        </td>
                                        <td>Fuel Type<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlFuelType" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 114px"></td>
                                    </tr>
                                </table>
                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep3" runat="server" Title="Insurance Information ">
                                <table style="width: 100%">
                                    <tr>
                                        <td colspan="4" style="text-align: center">
                                            <b>Insurance Information</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>District<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlDistrict" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Insurance Policy No<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInPolicyNo" runat="server" Width="100px" MaxLength="15" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Insurance Type<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlInsType" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Insurance Fee<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInsFee" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                                MaxLength="10"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Current Policy End Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCurrentPolicyEndDate" runat="server" Width="100px" onkeypress="return false" oncut="return false;"
                                                onpaste="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnCurrentPolicyEndDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="calExtCurrentPolicyEndDate" runat="server" TargetControlID="txtCurrentPolicyEndDate"
                                                PopupButtonID="imgBtnCurrentPolicyEndDate" Format="MM/dd/yyyy" Enabled="True">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Insurance Receipt No<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInsuranceReceiptNo" runat="server" Width="100px" MaxLength="15"
                                                onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Insurance Fees Paid Date
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInsuranceFeesPaidDate" runat="server" Width="100px" onkeypress="return false" oncut="return false;"
                                                onpaste="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnInsuranceFeesPaidDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="calExtInsuranceFeesPaidDate" runat="server" TargetControlID="txtInsuranceFeesPaidDate"
                                                PopupButtonID="imgBtnInsuranceFeesPaidDate" Format="MM/dd/yyyy" Enabled="True">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Agency<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlAgency" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Validity Start Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtValiSDate" runat="server" Width="100px"
                                                AutoPostBack="True" OnTextChanged="txtValiSDate_TextChanged" onkeypress="return false" oncut="return false;"
                                                onpaste="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnValiSdate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="calExtValiSDate" runat="server" TargetControlID="txtValiSDate"
                                                PopupButtonID="imgBtnValiSDate" Format="MM/dd/yyyy" Enabled="True">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Policy Validity Period
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlPolicyValidityPeriod" runat="server" Width="105px" OnSelectedIndexChanged="ddlPolicyValidityPeriod_SelectedIndexChanged"
                                                AutoPostBack="True">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="3">3 Month</asp:ListItem>
                                                <asp:ListItem Value="6">6 Month</asp:ListItem>
                                                <asp:ListItem Value="9">9 Month</asp:ListItem>
                                                <asp:ListItem Value="12">1 Year</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px">&nbsp;
                                        </td>
                                        <td>Validity End Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <%--<cc1:CalendarExtender ID="calextValEDate" runat="server" Enabled="true" PopupButtonID="imgbtValEDate"
                                        TargetControlID="txtValEDate" Format="MM/dd/yyyy">
                                    </cc1:CalendarExtender>--%>
                                            <asp:TextBox ID="txtValEDate" runat="server" oncut="return false;" Width="100px"
                                                BackColor="DarkGray" ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 130px"></td>
                                    </tr>
                                </table>
                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep6" runat="server" Title="Tyre Information ">
                                <table style="width: 100%">
                                    <tr>
                                        <td colspan="6" style="text-align: center">
                                            <b>Tyre Information </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="2" style="text-align: center">&nbsp;Tyre Information
                                        </td>
                                        <td>Make
                                        </td>
                                        <td>Model-Size
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;
                                        </td>
                                        <td>FL<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFL" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTyreMakeFL" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelSizeFL" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>FR<span style="color: Red">*</span>
                                        </td>
                                        <td style="width: 161px">
                                            <asp:TextBox ID="txtFR" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTyreMakeFR" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelSizeFR" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>RL<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRL" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTyreMakeRL" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelSizeRL" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>RR<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRR" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTyreMakeRR" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelSizeRR" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>Spare Wheel<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSpareWheel" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTyreMakeSpareWheel" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelSizeSpareWheel" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>Odometer Reading<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOdometerReading" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                                MaxLength="12"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep7" runat="server" Title="Battery Information ">
                                <table style="width: 100%">
                                    <tr>
                                        <td colspan="6" style="text-align: center">
                                            <b>Battery Information </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td colspan="2" style="text-align: center">
                                            <b>Batter Information </b>
                                        </td>
                                        <td style="text-align: center">
                                            <b>Make</b>
                                        </td>
                                        <td>
                                            <b>Model-Capacity</b>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>Battery 1<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBattery1" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlBatteryMakeBattery1" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlModelCapacityBattery1" runat="server" OnSelectedIndexChanged="ddlModelCapacityBattery1_SelectedIndexChanged"
                                                Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 22px">&nbsp;
                                        </td>
                                        <td style="height: 22px">Battery 2<span style="color: Red">*</span>
                                        </td>
                                        <td style="height: 22px">
                                            <asp:TextBox ID="txtBattery2" runat="server" Width="100px" MaxLength="10" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                        </td>
                                        <td style="height: 22px">
                                            <asp:DropDownList ID="ddlBatteryMakeBattery2" runat="server" Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="height: 22px">
                                            <asp:DropDownList ID="ddlModelCapacityBattery2" runat="server" OnSelectedIndexChanged="ddlModelCapacityBattery1_SelectedIndexChanged"
                                                Width="105px">
                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                <asp:ListItem Value="0">Dummy</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="height: 22px">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                </table>
                            </asp:WizardStep>
                        </WizardSteps>
                        <FinishNavigationTemplate>
                            <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                                Text="Previous" />
                            <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" Text="Finish" />
                        </FinishNavigationTemplate>
                        <StepNavigationTemplate>
                            <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                                Text="Previous" />
                            <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next" />
                        </StepNavigationTemplate>
                    </asp:Wizard>
                </fieldset>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

