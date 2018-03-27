<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.BaseVehicleDetails, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
 <script language="javascript" type="text/javascript">

        //        function DecrementStep() {
        //            stepNo--;
        //        }
        var publicData;
        var vehcostdata;
        var inVoiceDate;
        var purchaseDate;
        var manFactDate;
        var trDate;
        var inscStartDate
        var inscFeeDate;
        var inspectionDate;
        var valid


        var now = new Date();
        function vehicleCostAddition(obj) {
            if (parseFloat(obj.value)) {
                var BasicPrice = document.getElementById('<%=txtBasicPrice.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtBasicPrice.ClientID %>').value;
                var HandlingCharges = document.getElementById('<%=txtHandlingCharges.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtHandlingCharges.ClientID %>').value;
                var ExciseDuty = document.getElementById('<%=txtExciseDuty.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtExciseDuty.ClientID %>').value;
                var EC = document.getElementById('<%=txtEC.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtEC.ClientID %>').value;
                var VAT = document.getElementById('<%=txtVAT.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtVAT.ClientID %>').value;
                var UAV = document.getElementById('<%=txtUAV.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtUAV.ClientID %>').value;
                var SHEC = document.getElementById('<%=txtSHEC.ClientID %>').value == '' ? 0 : document.getElementById('<%=txtSHEC.ClientID %>').value;
                var VehCost = document.getElementById('<%=txtVehCost.ClientID %>');

                VehCost.value = (parseFloat(BasicPrice) + parseFloat(HandlingCharges) + parseFloat(ExciseDuty) + parseFloat(EC) + parseFloat(VAT) + parseFloat(UAV) + parseFloat(SHEC)).toFixed(2);
                document.getElementById('<%=txtVehicleCost.ClientID%>').value = VehCost.value;
            }
            else {
                alert('The value should be a valid decimal value and cannot be zero');
                obj.value = '';
            }

        }


        function validation() {
            var EngineNo = document.getElementById('<%= ddlEngineNo.ClientID %>');
            //  var ChassisNo = document.getElementById('<%= txtChassisNo.ClientID %>');
            var InvoiceNo = document.getElementById('<%= txtInvoiceNo.ClientID %>');
            var InvoiceDate = document.getElementById('<%=txtInvoiceDate.ClientID %>');
            var BasicPrice = document.getElementById('<%=txtBasicPrice.ClientID %>');
            var HandlingCharges = document.getElementById('<%=txtHandlingCharges.ClientID %>');
            var ExciseDuty = document.getElementById('<%=txtExciseDuty.ClientID %>');
            var EC = document.getElementById('<%=txtEC.ClientID %>');
            var VAT = document.getElementById('<%=txtVAT.ClientID %>');
            var UAV = document.getElementById('<%=txtUAV.ClientID %>');
            var SHEC = document.getElementById('<%=txtSHEC.ClientID %>');
            var VehCost = document.getElementById('<%=txtVehCost.ClientID %>');
            publicData = VehCost;
            if (EngineNo.selectedIndex == 0) {
                alert("Please select the Engine Number");
                EngineNo.focus();
                return false;
            }


            if (!RequiredValidation(InvoiceNo, "Invoice Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(InvoiceDate, "Invoice Date cannot be Blank"))
                return false;


            if (trim(InvoiceDate.value) != "") {
                if (!isValidDate(InvoiceDate.value)) {
                    alert("Enter the Valid Date");
                    InvoiceDate.focus();
                    return false;
                }
            }

            inVoiceDate = InvoiceDate.value;

            if (Date.parse(InvoiceDate.value) > Date.parse(now)) {
                alert("Invoice Date should not be greater than Current Date");
                InvoiceDate.focus();
                return false;
            }


            if (!RequiredValidation(BasicPrice, "Basic Price cannot be Blank"))
                return false;

            if (!RequiredValidation(HandlingCharges, "Handling Charges cannot be Blank"))
                return false;

            if (parseFloat(HandlingCharges.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than Handling Charges");
                HandlingCharges.focus();
                return false;
            }

            if (!RequiredValidation(ExciseDuty, "Excise Duty cannot be Blank"))
                return false;

            if (parseFloat(ExciseDuty.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than Excise Duty");
                ExciseDuty.focus();
                return false;
            }

            if (!RequiredValidation(EC, "EC cannot be Blank"))
                return false;

            if (parseFloat(EC.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than EC");
                EC.focus();
                return false;
            }


            if (!RequiredValidation(VAT, "VAT cannot be Blank"))
                return false;

            if (parseFloat(VAT.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than VAT");
                VAT.focus();
                return false;
            }

            if (!RequiredValidation(UAV, "UAV cannot be Blank"))
                return false;

            if (parseFloat(UAV.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than UAV");
                UAV.focus();
                return false;
            }

            if (!RequiredValidation(SHEC, "SHEC cannot be Blank"))
                return false;

            if (parseFloat(SHEC.value) > parseFloat(BasicPrice.value)) {
                alert("Basic Price should be greater than SHEC");
                SHEC.focus();
                return false;
            }

            VehCost.value = (parseFloat(BasicPrice.value) + parseFloat(HandlingCharges.value) + parseFloat(ExciseDuty.value) + parseFloat(EC.value) + parseFloat(VAT.value) + parseFloat(UAV.value) + parseFloat(SHEC.value)).toFixed(2);

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

            if (!RequiredValidation(VehicleEmissionType, "Vehicle Emission Type cannot be Blank"))
                return false;

            if (!RequiredValidation(PurchaseDate, "Purchase Date cannot be Blank"))
                return false;

            if (trim(PurchaseDate.value) != "") {
                if (!isValidDate(PurchaseDate.value)) {
                    alert("Enter the Purchase Date");
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

            if (Date.parse(PurchaseDate.value) > Date.parse(inVoiceDate)) {
                alert("Purchase Date should not be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
                PurchaseDate.focus();
                return false;
            }

            if (!RequiredValidation(OwnerName, "Owner Name cannot be Blank"))
                return false;

            if (ManufacturerName.selectedIndex == 0) {
                alert("Please select the Manufacturer Name");
                ManufacturerName.focus();
                return false;
            }

            if (!RequiredValidation(VehicleCost, "Vehicle Cost cannot be Blank"))
                return false;

            if (parseInt(VehicleCost.value) > parseInt(publicData.value)) {
                alert("Vehicle Cost should be less than Total Value of the Vehicle.(Total Value-" + publicData.value + ")");
                VehicleCost.focus();
                return false;
            }

            if (!RequiredValidation(ManufacturingDate, "Manufacturing Date cannot be Blank"))
                return false;

            if (trim(ManufacturingDate.value) != "") {
                if (!isValidDate(ManufacturingDate.value)) {
                    alert("Enter the Manufacturing Date");
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
                alert("Manufacturing Date should be less than Purchase Date");
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

            var District = document.getElementById('<%=ddlDistrict.ClientID %>');
            var InPolicyNo = document.getElementById('<%=txtInPolicyNo.ClientID %>')
            var InsType = document.getElementById('<%=ddlInsType.ClientID %>');
            var InsFee = document.getElementById('<%=txtInsFee.ClientID %>');
            var InsuranceReceiptNo = document.getElementById('<%=txtInsuranceReceiptNo.ClientID %>');
            var InsuranceFeesPaidDate = document.getElementById('<%=txtInsuranceFeesPaidDate.ClientID %>');
            var Agency = document.getElementById('<%=ddlAgency.ClientID%>');
            // var VehicleCost = document.getElementById('<%=txtVehicleCost.ClientID%>');
            //var ManufacturingDate = document.getElementById('<%=txtManufacturingDate.ClientID %>');
            // var EngineCapacity = document.getElementById('<%=txtEngineCapacity.ClientID %>');
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

            if (!RequiredValidation(InsFee, "Insurance Fee No cannot be Blank"))
                return false;

            if (!RequiredValidation(InsuranceReceiptNo, "Insurance Receipt No cannot be Blank"))
                return false;

            if (!RequiredValidation(InsuranceFeesPaidDate, "InsuranceFees PaidDate No cannot be Blank"))
                return false;

            if (trim(InsuranceFeesPaidDate.value) != "") {
                if (!isValidDate(InsuranceFeesPaidDate.value)) {
                    alert("Enter the valid InsuranceFees PaidDate");
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

            if (Date.parse(InsuranceFeesPaidDate.value) < Date.parse(inVoiceDate)) {
                alert("Insurance Fees Paid Date should be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
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
                    alert("Enter the validity start date");
                    ValiSDate.focus();
                    return false;
                }
            }

            if (Date.parse(ValiSDate.value) > Date.parse(now)) {
                alert("Validity Start Date should not be greater than Current Date");
                ValiSDate.focus();
                return false;
            }

            inscStartDate = ValiSDate.value;

            if (Date.parse(ValiSDate.value) < Date.parse(InsuranceFeesPaidDate.value)) {
                alert("Validity Start Date should not be less than Insurance Fees Paid Date");
                ValiSDate.focus();
                return false;
            }

            if (PolicyValidityPeriod.selectedIndex == 0) {
                alert("Please select the Policy Validity Period");
                PolicyValidityPeriod.focus();
                return false;
            }

            var InspectionDate = document.getElementById('<%=txtInspectionDate.ClientID %>');
            var InspectedBy = document.getElementById('<%=txtInspectedBy.ClientID %>');

            if (!RequiredValidation(InspectionDate, "Inspection Date cannot be Blank"))
                return false;

            if (trim(InspectionDate.value) != "") {
                if (!isValidDate(InspectionDate.value)) {
                    alert("Enter the valid Inspection Date");
                    InspectionDate.focus();
                    return false;
                }
            }

            if (Date.parse(InspectionDate.value) > Date.parse(now)) {
                alert("Inspection Date should not be greater than Current Date");
                InspectionDate.focus();
                return false;
            }
            if (Date.parse(InspectionDate.value) < Date.parse(inscStartDate)) {
                alert("Inspection Date should be greater than Insurance Validity Start Date.(Insurance Start Date-" + inscStartDate + ")");
                InspectionDate.focus();
                return false;
            }

            inspectionDate = InspectionDate.value;

            if (!RequiredValidation(InspectedBy, "Inspected By cannot be Blank"))
                return false;

            var TRNo = document.getElementById('<%=txtTRNo.ClientID %>');
            var TRDate = document.getElementById('<%=txtTRDate.ClientID %>');
            var TRDistrict = document.getElementById('<%=ddlTRDistrict.ClientID %>');
            var VeRTACircle = document.getElementById('<%=txtVeRTACircle.ClientID %>');
            var RoadTaxFee = document.getElementById('<%=txtRoadTaxFee.ClientID %>');
            var SittingCapacity = document.getElementById('<%=txtSittingCapacity.ClientID %>');

            if (!RequiredValidation(TRNo, "TR No cannot be Blank"))
                return false;

            if (!isValidVehicleNumber(TRNo.value)) {
                TRNo.value = "";
                TRNo.focus();
                return false;
            }

            if (!RequiredValidation(TRDate, "TR Date cannot be Blank"))
                return false;

            if (trim(TRDate.value) != "") {
                if (!isValidDate(TRDate.value)) {
                    alert("Enter the valid Inspection Date");
                    TRDate.focus();
                    return false;
                }
            }

            if (Date.parse(TRDate.value) > Date.parse(now)) {
                alert("TR Date should not be greater than Current Date");
                TRDate.focus();
                return false;
            }

            ////                if (Date.parse(TRDate.value) < Date.parse(inVoiceDate)) {
            ////                    alert("TR Date should be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
            ////                    TRDate.focus();
            ////                    return false;
            ////                }

            if (Date.parse(TRDate.value) < Date.parse(inspectionDate)) {
                alert("TR Date should be greater than Inspection Date.(Inspection Date-" + inspectionDate + ")");
                TRDate.focus();
                return false;
            }

            //                if (Date.parse(TRDate.value) < Date.parse(inscStartDate)) {
            //                    alert("TR Date should be greater than Insurance Start Date.(Insurance Start Date-" + inscStartDate + ")");
            //                    TRDate.focus();
            //                    return false;
            //                }


            if (TRDistrict.selectedIndex == 0) {
                alert("Please select the District");
                TRDistrict.focus();
                return false;
            }

            if (!RequiredValidation(VeRTACircle, "Vehicle RTA Circle cannot be Blank"))
                return false;

            if (!RequiredValidation(RoadTaxFee, "Road Tax Fee cannot be Blank"))
                return false;

            if (!RequiredValidation(SittingCapacity, "Seating Capacity cannot be Blank"))
                return false;
            var FL = document.getElementById('<%=txtFL.ClientID %>');
            var FR = document.getElementById('<%=txtFR.ClientID %>');
            var RL = document.getElementById('<%=txtRL.ClientID %>');
            var RR = document.getElementById('<%=txtRR.ClientID %>');
            var SpareWheel = document.getElementById('<%=txtSpareWheel.ClientID %>');
            var TyreMake = document.getElementById('<%=ddlTyreMake.ClientID %>');
            var ModelSize = document.getElementById('<%=ddlModelSize.ClientID %>');
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

            for (var i = 0; i < (Tyre.length - 1); i++) {
                for (var j = i + 1; j < Tyre.length; j++) {
                    if (Tyre[i] == Tyre[j]) {
                        alert("Tyre numbers should be unique");
                        return false;
                    }
                }
            }

            if (TyreMake.selectedIndex == 0) {
                alert("Please select the Tyre Make");
                TyreMake.focus();
                return false;
            }

            if (ModelSize.selectedIndex == 0) {
                alert("Please select the Model Size");
                ModelSize.focus();
                return false;
            }

            if (!RequiredValidation(OdometerReading, "Odometer Reading cannot be Blank"))
                return false;

            var Battery1 = document.getElementById('<%=txtBattery1.ClientID %>');
            var Battery2 = document.getElementById('<%=txtBattery2.ClientID %>');
            var BatteryMake = document.getElementById('<%=ddlBatteryMake.ClientID %>');
            var ModelCapacity = document.getElementById('<%=ddlModelCapacity.ClientID %>');

            if (!RequiredValidation(Battery1, "Battery1 cannot be Blank"))
                return false;

            if (!RequiredValidation(Battery2, "Battery2 cannot be Blank"))
                return false;

            if (Battery1.value == Battery2.value) {
                alert("Battery Numbers should be unique");
                Battery2.focus();
                return false;
            }

            if (BatteryMake.selectedIndex == 0) {
                alert("Please select the Battery Make");
                BatteryMake.focus();
                return false;
            }
            if (ModelCapacity.selectedIndex == 0) {
                alert("Please select the Model Capacity");
                ModelCapacity.focus();
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

                if (!RequiredValidation(VehicleEmissionType, "Vehicle Emission Type cannot be Blank"))
                    return false;

                if (!RequiredValidation(PurchaseDate, "Purchase Date cannot be Blank"))
                    return false;

                if (trim(PurchaseDate.value) != "") {
                    if (!isValidDate(PurchaseDate.value)) {
                        alert("Enter the Purchase Date");
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

                if (Date.parse(PurchaseDate.value) > Date.parse(inVoiceDate)) {
                    alert("Purchase Date should not be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
                    PurchaseDate.focus();
                    return false;
                }

                if (!RequiredValidation(OwnerName, "Owner Name cannot be Blank"))
                    return false;

                if (ManufacturerName.selectedIndex == 0) {
                    alert("Please select the Manufacturer Name");
                    ManufacturerName.focus();
                    return false;
                }

                if (!RequiredValidation(VehicleCost, "Vehicle Cost cannot be Blank"))
                    return false;

                if (parseInt(VehicleCost.value) > parseInt(publicData.value)) {
                    alert("Vehicle Cost should be less than Total Value of the Vehicle.(Total Value-" + publicData.value + ")");
                    VehicleCost.focus();
                    return false;
                }

                if (!RequiredValidation(ManufacturingDate, "Manufacturing Date cannot be Blank"))
                    return false;

                if (trim(ManufacturingDate.value) != "") {
                    if (!isValidDate(ManufacturingDate.value)) {
                        alert("Enter the Manufacturing Date");
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
                    alert("Manufacturing Date should be less than Purchase Date");
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
                var InsuranceReceiptNo = document.getElementById('<%=txtInsuranceReceiptNo.ClientID %>');
                var InsuranceFeesPaidDate = document.getElementById('<%=txtInsuranceFeesPaidDate.ClientID %>');
                var Agency = document.getElementById('<%=ddlAgency.ClientID%>');
                // var VehicleCost = document.getElementById('<%=txtVehicleCost.ClientID%>');
                //var ManufacturingDate = document.getElementById('<%=txtManufacturingDate.ClientID %>');
                // var EngineCapacity = document.getElementById('<%=txtEngineCapacity.ClientID %>');
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

                if (!RequiredValidation(InsFee, "Insurance Fee No cannot be Blank"))
                    return false;

                if (!RequiredValidation(InsuranceReceiptNo, "Insurance Receipt No cannot be Blank"))
                    return false;

                if (!RequiredValidation(InsuranceFeesPaidDate, "InsuranceFees PaidDate No cannot be Blank"))
                    return false;

                if (trim(InsuranceFeesPaidDate.value) != "") {
                    if (!isValidDate(InsuranceFeesPaidDate.value)) {
                        alert("Enter the valid InsuranceFees PaidDate");
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

                if (Date.parse(InsuranceFeesPaidDate.value) < Date.parse(inVoiceDate)) {
                    alert("Insurance Fees Paid Date should be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
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
                        alert("Enter the validity start date");
                        ValiSDate.focus();
                        return false;
                    }
                }

                if (Date.parse(ValiSDate.value) > Date.parse(now)) {
                    alert("Validity Start Date should not be greater than Current Date");
                    ValiSDate.focus();
                    return false;
                }

                inscStartDate = ValiSDate.value;

                if (Date.parse(ValiSDate.value) < Date.parse(InsuranceFeesPaidDate.value)) {
                    alert("Validity Start Date should not be less than Insurance Fees Paid Date");
                    ValiSDate.focus();
                    return false;
                }

                if (PolicyValidityPeriod.selectedIndex == 0) {
                    alert("Please select the Policy Validity Period");
                    PolicyValidityPeriod.focus();
                    return false;
                }

                stepNo++;
            }
            //Inspection Information
            else if (stepNo == 2) {

                var InspectionDate = document.getElementById('<%=txtInspectionDate.ClientID %>');
                var InspectedBy = document.getElementById('<%=txtInspectedBy.ClientID %>');

                if (!RequiredValidation(InspectionDate, "Inspection Date cannot be Blank"))
                    return false;

                if (trim(InspectionDate.value) != "") {
                    if (!isValidDate(InspectionDate.value)) {
                        alert("Enter the valid Inspection Date");
                        InspectionDate.focus();
                        return false;
                    }
                }

                if (Date.parse(InspectionDate.value) > Date.parse(now)) {
                    alert("Inspection Date should not be greater than Current Date");
                    InspectionDate.focus();
                    return false;
                }
                if (Date.parse(InspectionDate.value) < Date.parse(inscStartDate)) {
                    alert("Inspection Date should be greater than Insurance Validity Start Date.(Insurance Start Date-" + inscStartDate + ")");
                    InspectionDate.focus();
                    return false;
                }

                inspectionDate = InspectionDate.value;

                if (!RequiredValidation(InspectedBy, "Inspected By cannot be Blank"))
                    return false;

                stepNo++;

            }
            else if (stepNo == 3) {
                var TRNo = document.getElementById('<%=txtTRNo.ClientID %>');
                var TRDate = document.getElementById('<%=txtTRDate.ClientID %>');
                var TRDistrict = document.getElementById('<%=ddlTRDistrict.ClientID %>');
                var VeRTACircle = document.getElementById('<%=txtVeRTACircle.ClientID %>');
                var RoadTaxFee = document.getElementById('<%=txtRoadTaxFee.ClientID %>');
                var SittingCapacity = document.getElementById('<%=txtSittingCapacity.ClientID %>');

                if (!RequiredValidation(TRNo, "TR No cannot be Blank"))
                    return false;

                if (!isValidVehicleNumber(TRNo.value)) {
                    TRNo.value = "";
                    TRNo.focus();
                    return false;
                }

                if (!RequiredValidation(TRDate, "TR Date cannot be Blank"))
                    return false;

                if (trim(TRDate.value) != "") {
                    if (!isValidDate(TRDate.value)) {
                        alert("Enter the valid Inspection Date");
                        TRDate.focus();
                        return false;
                    }
                }

                if (Date.parse(TRDate.value) > Date.parse(now)) {
                    alert("TR Date should not be greater than Current Date");
                    TRDate.focus();
                    return false;
                }

                ////                if (Date.parse(TRDate.value) < Date.parse(inVoiceDate)) {
                ////                    alert("TR Date should be greater than Invoice Date.(Invoice Date-" + inVoiceDate + ")");
                ////                    TRDate.focus();
                ////                    return false;
                ////                }

                if (Date.parse(TRDate.value) < Date.parse(inspectionDate)) {
                    alert("TR Date should be greater than Inspection Date.(Inspection Date-" + inspectionDate + ")");
                    TRDate.focus();
                    return false;
                }

                //                if (Date.parse(TRDate.value) < Date.parse(inscStartDate)) {
                //                    alert("TR Date should be greater than Insurance Start Date.(Insurance Start Date-" + inscStartDate + ")");
                //                    TRDate.focus();
                //                    return false;
                //                }


                if (TRDistrict.selectedIndex == 0) {
                    alert("Please select the District");
                    TRDistrict.focus();
                    return false;
                }

                if (!RequiredValidation(VeRTACircle, "Vehicle RTA Circle cannot be Blank"))
                    return false;

                if (!RequiredValidation(RoadTaxFee, "Road Tax Fee cannot be Blank"))
                    return false;

                if (!RequiredValidation(SittingCapacity, "Seating Capacity cannot be Blank"))
                    return false;
                stepNo++;
            }
            else if (stepNo == 4) {
                var FL = document.getElementById('<%=txtFL.ClientID %>');
                var FR = document.getElementById('<%=txtFR.ClientID %>');
                var RL = document.getElementById('<%=txtRL.ClientID %>');
                var RR = document.getElementById('<%=txtRR.ClientID %>');
                var SpareWheel = document.getElementById('<%=txtSpareWheel.ClientID %>');
                var TyreMake = document.getElementById('<%=ddlTyreMake.ClientID %>');
                var ModelSize = document.getElementById('<%=ddlModelSize.ClientID %>');
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

                for (var i = 0; i < (Tyre.length - 1); i++) {
                    for (var j = i + 1; j < Tyre.length; j++) {
                        if (Tyre[i] == Tyre[j]) {
                            alert("Tyre numbers should be unique");
                            return false;
                        }
                    }
                }

                if (TyreMake.selectedIndex == 0) {
                    alert("Please select the Tyre Make");
                    TyreMake.focus();
                    return false;
                }

                if (ModelSize.selectedIndex == 0) {
                    alert("Please select the Model Size");
                    ModelSize.focus();
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
            var BatteryMake = document.getElementById('<%=ddlBatteryMake.ClientID %>');
            var ModelCapacity = document.getElementById('<%=ddlModelCapacity.ClientID %>');

            if (!RequiredValidation(Battery1, "Battery1 cannot be Blank"))
                return false;

            if (!RequiredValidation(Battery2, "Battery2 cannot be Blank"))
                return false;

            if (Battery1.value == Battery2.value) {
                alert("Battery Numbers should be unique");
                Battery2.focus();
                return false;
            }

            if (BatteryMake.selectedIndex == 0) {
                alert("Please select the Battery Make");
                BatteryMake.focus();
                return false;
            }
            if (ModelCapacity.selectedIndex == 0) {
                alert("Please select the Model Capacity");
                ModelCapacity.focus();
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

        function numeric(event) {
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
                alert("Enter a valid Vehicle T/R Number eg - 'AP27HY9834' or 'AP27H8'");
                return false;
            }
        } 
        
    
    </script>

   
    <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlBaseVehicleDetails" runat="server">
                <asp:HiddenField ID="hdnStepNo" runat="server" />
              
                    <table style="width: 100%">
                        <tr>
                            <td colspan="5" style="text-align: center">
                                <b>Base Details </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                Engine No<span style="color: Red">*</span>
                            </td>
                            <td align="center">
                                <asp:DropDownList ID="ddlEngineNo" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEngineNo_SelectedIndexChanged"
                                    Width="150px" TabIndex="1">
                                </asp:DropDownList>
                            </td>
                            <td align="center">
                                Chassis No<span style="color: Red">*</span>
                            </td>
                            <td align="center">
                                &nbsp;<asp:TextBox ID="txtChassisNo" runat="server" BackColor="DarkGray" ReadOnly="True"
                                    Width="150px" TabIndex="2"></asp:TextBox></td>
                        </tr>
                    </table>
                
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Invoice and Base Details</legend>
                    <table style="width: 100%;">
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Invoice Details </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Invoice No<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtInvoiceNo" runat="server" Width="100px" onkeypress="return alphanumeric_only(event);"
                                    MaxLength="15" TabIndex="3"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Invoice Date<span style="color: Red">*</span>
                            </td>
                            <td style="width: 103px" nowrap="nowrap">
                                <asp:TextBox ID="txtInvoiceDate" runat="server" oncut="return false;" onpaste="return false;"
                                    Width="100px" onkeypress="return false" TabIndex="4"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtInvoiceDate" runat="server" Enabled="True" PopupButtonID="imgBtnCalendarInvoiceDate"
                                    TargetControlID="txtInvoiceDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                            </td>
                            <td nowrap="nowrap" style="width: 51px">
                                <asp:ImageButton ID="imgBtnCalendarInvoiceDate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Basic Price<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtBasicPrice" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="11" onchange="return vehicleCostAddition(this)" TabIndex="5"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Handling Charges<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtHandlingCharges" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="8" onchange="return vehicleCostAddition(this)" TabIndex="6"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Excise Duty<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtExciseDuty" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="8" onchange="return vehicleCostAddition(this)" TabIndex="7"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                EC<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtEC" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="8" onchange="return vehicleCostAddition(this)" TabIndex="8"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                VAT<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtVAT" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="8" onchange="return vehicleCostAddition(this)" TabIndex="9"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Cess on UAV<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtUAV" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="8" onchange="return vehicleCostAddition(this)" TabIndex="10"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                SHEC<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtSHEC" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    AutoPostBack="True" MaxLength="8" 
                                    onchange="return vehicleCostAddition(this)" TabIndex="11"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 164px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 164px">
                                &nbsp;
                            </td>
                            <td style="width: 198px">
                                Total Value<span style="color: Red">*</span>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtVehCost" runat="server" BackColor="DarkGray" Width="100px" 
                                    onkeypress="return false" TabIndex="12"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>General Information</legend>
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>General Information </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Vehicle Model<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVehicleModel" runat="server" Width="105px" 
                                    TabIndex="13">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 150px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 37px">
                                &nbsp;
                            </td>
                            <td>
                                KMPL<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtKmpl" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="5" TabIndex="14"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Vehicle Type<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVehicleType" runat="server" Width="105px" 
                                    TabIndex="15">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 150px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 37px">
                                &nbsp;
                            </td>
                            <td>
                                Vehicle Emission Type<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVehicleEmissionType" runat="server" Width="100px" MaxLength="10"
                                    onkeypress="return alpha_only(event);" TabIndex="16"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Purchase Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPurchaseDate" runat="server" Width="100px" onkeypress="return false"
                                    oncut="return false;" onpaste="return false;" TabIndex="17"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtPurDate" runat="server" Enabled="True" PopupButtonID="imgbtPurchaseDate"
                                    TargetControlID="txtPurchaseDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="imgbtPurchaseDate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="18" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 150px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 37px">
                                &nbsp;
                            </td>
                            <td>
                                Owner Name<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOwnerName" runat="server" Width="100px" MaxLength="35" 
                                    onkeypress="return alpha_only_withspace(event);" TabIndex="19"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Manufacturer Name<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlManufacturerName" runat="server" Width="105px" 
                                    TabIndex="20">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 150px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 37px">
                                &nbsp;
                            </td>
                            <td>
                                Vehicle Cost<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVehicleCost" runat="server" Width="100px" onkeypress="return false;"
                                    MaxLength="11" ReadOnly="True" TabIndex="21"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Manufacturing Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtManufacturingDate" runat="server" Width="100px" onkeypress="return false"
                                    oncut="return false;" onpaste="return false;" TabIndex="22"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtManufDate" runat="server" Enabled="True" PopupButtonID="imgbtManufacturingDate"
                                    TargetControlID="txtManufacturingDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="imgbtManufacturingDate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="23" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 150px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 37px">
                                &nbsp;
                            </td>
                            <td>
                                Engine Capacity<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEngineCapacity" runat="server" Width="100px" onkeypress="return alphanumeric_only(event);"
                                    MaxLength="8" TabIndex="24"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Fuel Type<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFuelType" runat="server" Width="105px" TabIndex="25">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Insurance Information</legend>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Insurance Information</b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                District<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDistrict" runat="server" Width="105px" TabIndex="26">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 152px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 35px">
                                &nbsp;
                            </td>
                            <td>
                                Insurance Policy No<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInPolicyNo" runat="server" Width="100px" MaxLength="15" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="27"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Insurance Type<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInsType" runat="server" Width="105px" TabIndex="28">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 152px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 35px">
                                &nbsp;
                            </td>
                            <td>
                                Insurance Fee<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInsFee" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="11" TabIndex="29"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <%-- <tr>
                                        <td style="width: 152px">
                                            &nbsp;
                                        </td>
                                        <td>
                                            Current Policy End Date<span style="color: Red">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCurrentPolicyEndDate" runat="server" Width="100px" onkeypress="return false"></asp:TextBox>
                                            <asp:ImageButton ID="imgbtCurrentPolicyEndDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" PopupButtonID="imgbtCurrentPolicyEndDate"
                                                TargetControlID="txtCurrentPolicyEndDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" style="width: 152px">
                                        </td>
                                    </tr>--%>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Insurance Receipt No<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInsuranceReceiptNo" runat="server" Width="100px" MaxLength="15"
                                    onkeypress="return alphanumeric_only(event);" TabIndex="30"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 152px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 35px">
                                &nbsp;
                            </td>
                            <td>
                                Insurance Fees Paid Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtInsuranceFeesPaidDate" runat="server" Width="100px" onkeypress="return false"
                                    oncut="return false;" onpaste="return false;" TabIndex="31"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtInsuranceFeesPaidDate_CalendarExtender" runat="server"
                                    Enabled="True" PopupButtonID="imgbtInsuranceFeesPaidDate" Format="MM/dd/yyyy"
                                    TargetControlID="txtInsuranceFeesPaidDate">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="imgbtInsuranceFeesPaidDate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="32" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Agency<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAgency" runat="server" Width="105px" TabIndex="33">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 152px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 35px">
                                &nbsp;
                            </td>
                            <td>
                                Validity Start Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtValiSDate" runat="server" Width="100px" AutoPostBack="True" OnTextChanged="txtValiSDate_TextChanged"
                                    onkeypress="return false;" oncut="return false;" onpaste="return false;" 
                                    TabIndex="34"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExValiSDate" runat="server" Enabled="True" PopupButtonID="imgbtValiSdate"
                                    TargetControlID="txtValiSDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="imgbtValiSdate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="35" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 69px">
                                &nbsp;
                            </td>
                            <td>
                                Policy Validity Period
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPolicyValidityPeriod" runat="server" Width="105px" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlPolicyValidityPeriod_SelectedIndexChanged" 
                                    TabIndex="36">
                                    <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    <asp:ListItem Value="3">3 Month</asp:ListItem>
                                    <asp:ListItem Value="6">6 Month</asp:ListItem>
                                    <asp:ListItem Value="9">9 Month</asp:ListItem>
                                    <asp:ListItem Value="12">1 Year</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 152px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 35px">
                                &nbsp;
                            </td>
                            <td>
                                Validity End Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtValEDate" runat="server" oncut="return false;" onpaste="return false;"
                                    Width="100px" BackColor="DarkGray" ReadOnly="True" TabIndex="37"></asp:TextBox>
                                <%--   <cc1:CalendarExtender ID="calextValEDate" runat="server" Enabled="True" PopupButtonID="imgbtValEDate"
                                                TargetControlID="txtValEDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>--%>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 69px">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Inspection Information</legend>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Inspection Information </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 67px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 67px">
                                &nbsp;
                            </td>
                            <td>
                                Inspection Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInspectionDate" runat="server" Width="105px" onkeypress="return false;"
                                    oncut="return false;" onpaste="return false;" TabIndex="38"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtInspectionDate" runat="server" Enabled="True" PopupButtonID="imgbtInspectionDt"
                                    TargetControlID="txtInspectionDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="imgbtInspectionDt" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="39" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- <tr>
                            <td class="rowseparator" style="width: 183px">
                            </td>
                        </tr>
                        
                        <tr>--%>
                            <%--  <td class="rowseparator" style="width: 183px">
                        </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 27px">
                                &nbsp;
                            </td>
                            <td>
                                Inspected By<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInspectedBy" runat="server" TabIndex="40" onkeypress="return alpha_only_withspace(event);"
                                    Width="105px" MaxLength="35"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <tr>
                                <td class="rowseparator" style="width: 67px">
                                </td>
                            </tr>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Temporary Registration</legend>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Temporary Registration </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 68px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 68px">
                                &nbsp;
                            </td>
                            <td>
                                T/R No<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTRNo" runat="server" Width="100px" MaxLength="10" 
                                    TabIndex="41"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 157px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 52px">
                                &nbsp;
                            </td>
                            <td>
                                T/R Date<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTRDate" runat="server" oncut="return false;" onpaste="return false;"
                                    Width="100px" onkeypress="return false;" TabIndex="42"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtTRDate" runat="server" Enabled="True" PopupButtonID="ImgbtTRDate"
                                    TargetControlID="txtTRDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                                <asp:ImageButton ID="ImgbtTRDate" runat="server" alt="" src="images/Calendar.gif"
                                    Style="vertical-align: top" TabIndex="43" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 68px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 68px">
                                &nbsp;
                            </td>
                            <td>
                                T/R District<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTRDistrict" runat="server" Width="105px" TabIndex="44">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 157px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 52px">
                                &nbsp;
                            </td>
                            <td>
                                Vehicle RTA Circle<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVeRTACircle" runat="server" Width="100px" MaxLength="20" 
                                    onkeypress="return alpha_only_withspace(event);" TabIndex="45"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 68px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 68px">
                                &nbsp;
                            </td>
                            <td>
                                Road Tax Fee<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRoadTaxFee" runat="server" Width="100px" onkeypress="return isDecimalNumberKey(event);"
                                    MaxLength="9" TabIndex="46"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 157px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 52px">
                                &nbsp;
                            </td>
                            <td>
                                Seating Capacity<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSittingCapacity" runat="server" Width="100px" onkeypress="return numeric(event);"
                                    MaxLength="2" TabIndex="47"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 68px">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Tyre Information</legend>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Tyre Information </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                FL<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFL" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="48"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>
                        <tr>
                            <td class="rowseparator" style="width: 170px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 67px">
                                &nbsp;
                            </td>
                            <td>
                                FR<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFR" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="49"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                RL<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRL" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="50"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--  </tr>
                        <tr>
                            <td class="rowseparator" style="width: 170px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 67px">
                                &nbsp;
                            </td>
                            <td>
                                RR<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRR" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="51"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                Spare Wheel<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSpareWheel" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="52"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--  </tr>
                        <tr>
                            <td class="rowseparator" style="width: 170px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 67px">
                                &nbsp;
                            </td>
                            <td>
                                Make<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTyreMake" runat="server" Width="105px" TabIndex="53">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                Model-Size<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlModelSize" runat="server" Width="105px" TabIndex="54">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--  </tr>
                        <tr>
                            <td class="rowseparator" style="width: 170px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 67px">
                                &nbsp;
                            </td>
                            <td>
                                Odometer Reading<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOdometerReading" runat="server" Width="100px" onkeypress="return numeric(event);"
                                    MaxLength="12" TabIndex="55"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                &nbsp;&nbsp;&nbsp;
                <fieldset style="padding: 10px; width: 645px;">
                    <legend>Battery Information</legend>
                    <table style="width: 100%">
                        <tr>
                            <td colspan="10" style="text-align: center">
                                <b>Battery Information </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                Battery 1<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBattery1" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="56"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%-- </tr>--%>
                            <%-- <tr>
                            <td class="rowseparator" style="width: 169px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 70px;">
                                &nbsp;
                            </td>
                            <td>
                                Battery 2<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBattery2" runat="server" Width="100px" MaxLength="10" 
                                    onkeypress="return alphanumeric_only(event);" TabIndex="57"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                Make<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlBatteryMake" runat="server" Width="105px" 
                                    TabIndex="58">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <%--</tr>
                        <tr>
                            <td class="rowseparator" style="width: 169px">
                            </td>
                        </tr>
                        <tr>--%>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td>
                                Model Capacity<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlModelCapacity" runat="server" Width="105px" 
                                    TabIndex="59">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 70px">
                                &nbsp;
                            </td>
                            <td colspan="2">
                                <b>
                                    <asp:LinkButton ID="lbtnMapVehicleTools" runat="server" Text="Map Vehicle Tools"
                                        Visible="False"></asp:LinkButton>
                                </b>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator" style="width: 70px">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <asp:Button ID="btnValidate" runat="server" Text="validate" Style="display: none" />
            </asp:Panel>
            <table align="center" style="margin-top: 20px">
                <tr>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Submit" Width="60px" TabIndex="60"
                            OnClientClick="return validation();" Height="30px" 
                            OnClick="btnSave_Click" />
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <asp:Button ID="btnReset" runat="server" Text="Reset" TabIndex="61" Height="30px"
                            Width="60px" OnClick="btnReset_Click" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

