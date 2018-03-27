<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VehicleAccidentDetails, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validation(obj, Id) {

            var now = new Date();

            var ddlistVehicleNumber = obj.id.replace(Id, "ddlistVehicleNumber");
            var txtIncidentTitle = obj.id.replace(Id, "txtIncidentTitle");
            //var txtAgeofVehicle = obj.id.replace(Id, "txtAgeofVehicle");
            var txtKilometerRun = obj.id.replace(Id, "txtKilometerRun");
            //var txtIncidentHandledBy = obj.id.replace(Id, "txtIncidentHandledBy");

            //var txtAccidentDescription = obj.id.replace(Id, "txtAccidentDescription");
            var txtAccidentDateTime = obj.id.replace(Id, "txtAccidentDateTime");
            //var ddlistHour = obj.id.replace(Id, "ddlistHour");
            //var ddlistMinute = obj.id.replace(Id, "ddlistMinute");
            //var txtActionInitiatedBy = obj.id.replace(Id, "txtActionInitiatedBy");
            var txtInitiatedTime = obj.id.replace(Id, "txtInitiatedTime");
            //var ddlistInitiatedHr = obj.id.replace(Id, "ddlistInitiatedHr");
            //var ddlistInitiatedTimeMin = obj.id.replace(Id, "ddlistInitiatedTimeMin");
            //var txtInitialContainmentAction = obj.id.replace(Id, "txtInitialContainmentAction");
            //var txtAccidentRootCause = obj.id.replace(Id, "txtAccidentRootCause");

            //var txtDamagetoAmbulance = obj.id.replace(Id, "txtDamagetoAmbulance");
            //var txtDamageto3rdPartyProperty = obj.id.replace(Id, "txtDamageto3rdPartyProperty");

            var txtPilotName = obj.id.replace(Id, "txtPilotName");
            var txtDrivingLicenseNumber = obj.id.replace(Id, "txtDrivingLicenseNumber");
            var txtExpiryDate = obj.id.replace(Id, "txtExpiryDate");
            //var txtExpiryDate = obj.id.replace(Id, "txtExpiryDate");
            //var ddListEmtName = obj.id.replace(Id, "ddListEmtName");

            //var txtInjuriestoEMRIStaff = obj.id.replace(Id, "txtInjuriestoEMRIStaff");
            //var txt3rdPartyPersonal = obj.id.replace(Id, "txt3rdPartyPersonal");
            //var txtApproxRepairCost = obj.id.replace(Id, "txtApproxRepairCost");


            var id = document.getElementById('<%= ddlistVehicleNumber.ClientID %>');

            var IncidentTitle = document.getElementById('<%= txtIncidentTitle.ClientID %>');
            var KilometerRun = document.getElementById('<%= txtKilometerRun.ClientID %>');
            var AccidentDateTime = document.getElementById('<%= txtAccidentDateTime.ClientID %>');
            var InitiatedTime = document.getElementById('<%= txtInitiatedTime.ClientID %>');
            var Hour = document.getElementById('<%= ddlistHour.ClientID %>');
            var Minute = document.getElementById('<%= ddlistMinute.ClientID %>');
            var Hour1 = document.getElementById('<%= ddlistInitiatedHr.ClientID %>');
            var Minute1 = document.getElementById('<%= ddlistInitiatedTimeMin.ClientID %>');
            var PilotName = document.getElementById('<%= txtPilotName.ClientID %>');

            var DrivingLicenseNumber = document.getElementById('<%= txtDrivingLicenseNumber.ClientID %>');
            var ExpiryDate = document.getElementById('<%= txtExpiryDate.ClientID %>');

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

            if (trim(IncidentTitle.value) == '') {
                alert("Incident Title Cannot be Blank");
                IncidentTitle.focus();
                return false;
            }

            if (trim(KilometerRun.value) == '') {
                alert("Kilometer Run Cannot be Blank");
                KilometerRun.focus();
                return false;
            }

            if (trim(PilotName.value) == '') {
                alert("Pilot Name Cannot be Blank");
                PilotName.focus();
                return false;
            }

            if (trim(DrivingLicenseNumber.value) == '') {
                alert("Driving LicenseNumber Cannot be Blank");
                DrivingLicenseNumber.focus();
                return false;
            }

            if (trim(ExpiryDate.value) == '') {
                alert("ExpiryDate cannot be Blank");
                ExpiryDate.focus();
                return false;
            }

            if (trim(ExpiryDate.value) != "") {
                if (!isValidDate(ExpiryDate.value)) {
                    alert("Enter the Valid Date");
                    ExpiryDate.focus();
                    return false;
                }
            }

            if (Date.parse(ExpiryDate.value) < Date.parse(now)) {
                alert("Expiry Date should not be less than Current Date");
                ExpiryDate.focus();
                return false;
            }

            if (trim(AccidentDateTime.value) != "") {
                if (!isValidDate(AccidentDateTime.value)) {
                    alert("Enter the Valid Date");
                    AccidentDateTime.focus();
                    return false;
                }
            }

            if (Date.parse(AccidentDateTime.value) > Date.parse(now)) {
                alert("Accident Date should not be greater than Current Date");
                AccidentDateTime.focus();
                return false;
            }


            //txtInitiatedTime
            if (trim(InitiatedTime.value) != "") {
                if (!isValidDate(InitiatedTime.value)) {
                    alert("Enter the Valid Date");
                    InitiatedTime.focus();
                    return false;
                }
            }

            if (Date.parse(InitiatedTime.value) > Date.parse(now)) {
                alert("Initiated Date should not be greater than Current Date");
                InitiatedTime.focus();
                return false;
            }
            if (Date.parse(AccidentDateTime.value) > Date.parse(InitiatedTime.value)) {
                alert("Initiated Date should be greater than Accident Date");
                InitiatedTime.focus();
                return false;
            }

            if (Hour.selectedIndex == 0) {
                alert("Please select hour");
                Hour.focus();
                return false;
            }

            if (Minute.selectedIndex == 0) {
                alert("Please select minute");
                Minute.focus();
                return false;
            }

            if (Hour1.selectedIndex == 0) {
                alert("Please select hour");
                Hour1.focus();
                return false;
            }

            if (Minute1.selectedIndex == 0) {
                alert("Please select minute");
                Minute1.focus();
                return false;
            }

            if (parseInt(Hour.value) > parseInt(Hour1.value)) {
                alert("End Time should be greater than the Start Time value");
                Hour1.focus();
                return false;
            }
            if (parseInt(Hour.value) == parseInt(Hour1.value)) {
                if (parseInt(Minute.value) > parseInt(Minute1.value)) {
                    alert("End Time should be greater than the Start Time value");
                    Minute1.focus();
                    return false;
                }

                else if (parseInt(Minute.value) == parseInt(Minute1.value)) {
                    alert("End Time should be greater than the Start Time value");
                    Minute1.focus();
                    return false;
                }
            }


            return true;
        }


        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
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

        function alphanumeric_only_withspace(e) {
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

    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlVehicleAccidentDetails" runat="server">
                <table>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset style="padding: 10px">
                                <legend><b>Vehicle Accident Details</b></legend>
                                <table cellpadding="2" cellspacing="2" width="100%" style="margin-right: 15px;">
                                    <tr>
                                        <td colspan="3">&nbsp;
                                        </td>
                                        <td valign="top" colspan="3">
                                            <tr>
                                                <td colspan="3">
                                                    <b>Incident and Vehicle Details</b>
                                                </td>
                                                <td colspan="3" valign="top">
                                                    <b>Resource Details</b>
                                                    <tr>
                                                        <td>Vehicle Number <font color="red">*</font>
                                                        </td>
                                                        <td colspan="2">
                                                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlistVehicleNumber" runat="server" Width="130px"
                                                                AutoPostBack="True"
                                                                OnSelectedIndexChanged="ddlistVehicleNumber_SelectedIndexChanged" DropDownStyle="DropDownList">
                                                            </cc1:ComboBox>


                                                        </td>
                                                        <td>Pilot Name<font color="red">*</font>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtPilotName" runat="server" Width="130px" onkeypress="return alpha_only(event);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Incident Title<font color="red">*</font>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtIncidentTitle" runat="server" MaxLength="20" Width="130px"
                                                                onkeypress="return alphanumeric_only_withspace(event);"></asp:TextBox>
                                                        </td>
                                                        <td>Driving License Number <font color="red">*</font>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtDrivingLicenseNumber" runat="server" MaxLength="20" Width="130px"
                                                                onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Age of the Vehicle
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtAgeofVehicle" runat="server" MaxLength="10" Width="130px" onkeypress="return isDecimalNumberKey(event);" ReadOnly="true"></asp:TextBox>
                                                        </td>
                                                        <td>Expiry Date<font color="red">*</font>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtExpiryDate" runat="server" MaxLength="20" Width="130px" onkeypress="return false;"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="txtExpiryDate_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                                                PopupButtonID="imgBtnHandOverDate" TargetControlID="txtExpiryDate">
                                                            </cc1:CalendarExtender>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="imgBtnHandOverDate" runat="server" ImageUrl="images/Calendar.gif" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Kilometer Run<font color="red">*</font>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtKilometerRun" runat="server" MaxLength="15" onkeypress="return isDecimalNumberKey(event);"
                                                                Width="130px"></asp:TextBox>
                                                        </td>
                                                        <td>EMT Name
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmtName" runat="server" Width="130px" onkeypress="return alpha_only(event);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Incident Handled By
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtIncidentHandledBy" runat="server" MaxLength="35" Width="130px"
                                                                onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                                        </td>
                                                        <td>Is Vehicle Operational
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:RadioButtonList ID="rdBtnIsVehicleOPerational" runat="server" RepeatColumns="3"
                                                                RepeatDirection="Horizontal">
                                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </td>
                                                <tr>
                                                    <td>&nbsp;
                                                    </td>
                                                    <td colspan="2">&nbsp;
                                                    </td>
                                                    <td>&nbsp;
                                                    </td>
                                                    <td colspan="2">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <b>Initiation</b>
                                                    </td>
                                                    <td colspan="3">
                                                        <b>Incident Impact Details</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="2">Accident Description
                                                    </td>
                                                    <td colspan="2" rowspan="2">
                                                        <asp:TextBox ID="txtAccidentDescription" runat="server" MaxLength="250" TextMode="MultiLine"
                                                            Width="130px" onkeypress="return remark(event);"></asp:TextBox>
                                                    </td>
                                                    <td>Injuries to EMRI Staff
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtInjuriestoEMRIStaff" runat="server" MaxLength="20" Width="130px"
                                                            onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">Injuries to 3rd Party Personal
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txt3rdPartyPersonal" runat="server" MaxLength="20" Width="130px"
                                                            onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 14px" rowspan="2">Accident Date and Time<font color="red">*</font>
                                                    </td>
                                                    <td style="height: 14px" rowspan="2">
                                                        <asp:TextBox ID="txtAccidentDateTime" runat="server" MaxLength="20" Width="130px"
                                                            onkeypress="return false;"></asp:TextBox>
                                                        <asp:ImageButton ID="imgPODate" runat="server" ImageUrl="images/Calendar.gif" />
                                                        <cc1:CalendarExtender ID="txtAccidentDateTime_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                                            PopupButtonID="imgPODate" TargetControlID="txtAccidentDateTime">
                                                        </cc1:CalendarExtender>
                                                        <asp:DropDownList ID="ddlistHour" runat="server" Width="50px">
                                                            <asp:ListItem Selected="True" Text="--hh--" Value="--hh--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlistMinute" runat="server" Width="50px">
                                                            <asp:ListItem Selected="True" Text="--mm--" Value="--hh--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="height: 14px" rowspan="2"></td>
                                                    <td style="height: 14px" nowrap="nowrap">Approx Repair Cost
                                                    </td>
                                                    <td style="height: 14px" colspan="2">
                                                        <asp:TextBox ID="txtApproxRepairCost" runat="server" MaxLength="7" onkeypress="return isDecimalNumberKey(event);"
                                                            Width="130px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap" style="height: 14px">&nbsp;
                                                    </td>
                                                    <td colspan="2" style="height: 14px">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Action Initiated By
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtActionInitiatedBy" runat="server" MaxLength="35" Width="130px"
                                                            onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Initiated Time<font color="red">*</font>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtInitiatedTime" runat="server" MaxLength="20" Width="130px" onkeypress="return false;"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="txtInitiatedTime_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                                            PopupButtonID="imgPOInitiatedTime" TargetControlID="txtInitiatedTime">
                                                        </cc1:CalendarExtender>
                                                        <asp:ImageButton ID="imgPOInitiatedTime" runat="server" ImageUrl="images/Calendar.gif" />
                                                        <asp:DropDownList ID="ddlistInitiatedHr" runat="server" Width="50px">
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlistInitiatedTimeMin" runat="server" Width="50px">
                                                            <asp:ListItem Selected="True" Text="--mm--" Value="--hh--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>&nbsp;
                                                    </td>
                                                    <td colspan="3">
                                                        <b>Other Details</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Initial Containment Action
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtInitialContainmentAction" runat="server" MaxLength="35" Width="130px"
                                                            onkeypress="return alphanumeric_only_withspace(event);"></asp:TextBox>
                                                    </td>
                                                    <td>Area Police Station
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtAreaPoliceStation" runat="server" MaxLength="35" Width="130px"
                                                            onkeypress="return alphanumeric_only_withspace(event);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </tr>
                                            <tr>
                                                <td>Accident Root Cause
                                                </td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtAccidentRootCause" runat="server" MaxLength="50" Width="130px"
                                                        onkeypress="return alphanumeric_only_withspace(event);"></asp:TextBox>
                                                </td>
                                                <td>CD/FIR NO/Panchnama
                                                </td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtFirPanchname" runat="server" MaxLength="35" Width="130px"
                                                        onkeypress="return remark(event);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" width="100">&nbsp;
                                                </td>
                                                <td style="width: 0">ReportedBy
                                                </td>
                                                <td width="100" colspan="2">
                                                    <asp:TextBox ID="txtReportedBY" runat="server" MaxLength="35" Width="130px"
                                                        onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" width="100" nowrap="nowrap">
                                                    <b>Damage Details</b>&nbsp;
                                                </td>
                                                <td style="width: 0">Remarks
                                                </td>
                                                <td colspan="2" width="100">
                                                    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="200"
                                                        TextMode="MultiLine" Width="130px"
                                                        onkeypress="return remark(event);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Damage to Ambulance
                                                </td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtDamagetoAmbulance" runat="server" MaxLength="200" TextMode="MultiLine"
                                                        Width="130px" onkeypress="return remark(event);"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;Is Insurance Claim Required
                                                </td>
                                                <td colspan="2">
                                                    <asp:RadioButtonList ID="rdBtnIsInsuranceClaimed" runat="server" RepeatColumns="3"
                                                        RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="True" Text="True">Yes</asp:ListItem>
                                                        <asp:ListItem Value="False" Text="False">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">Damage to 3rd Party Property
                                                </td>
                                                <td nowrap="nowrap" colspan="2">
                                                    <asp:TextBox ID="txtDamageto3rdPartyProperty" runat="server" MaxLength="200" TextMode="MultiLine"
                                                        Width="130px" onkeypress="return remark(event);"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;
                                                </td>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" nowrap="nowrap">&nbsp;
                                                </td>
                                                <td colspan="3">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" align="center">
                                                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
                                                    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator" colspan="3" width="100"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" nowrap="nowrap" width="100"></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="grdVehicleAccidentDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            OnPageIndexChanging="grdVehicleAccidentDetails_PageIndexChanging" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Accident Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccidentTitle" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Accident Date and Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccidentDateandTime" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleNumber" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="District">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDistrict" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="location">
                                    <ItemTemplate>
                                        <asp:Label ID="lbllocation" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnEdit" runat="server" CommandArgument='<%DataBinder.Eval(Container.Dataitem,"")%>'
                                            CommandName="vehicleAccidentedit" Text="Edit"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnDelete" runat="server" CommandArgument='<%DataBinder.Eval(Container.Dataitem,"")%>'
                                            CommandName="vehicleAccidentDelete" Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

