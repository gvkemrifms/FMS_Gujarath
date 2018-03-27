<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.VehicleDetails, App_Web_m0x5b0wx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script src="../JavaValidations/RequiredFieldValidations.js" type="text/javascript">

    </script>

    <script language="javascript" type="text/javascript">
        function validation() {


            var EngineNo = document.getElementById('<%= txtEngineNumber.ClientID %>');
            var ChassisNo = document.getElementById('<%= txtChassisNumber.ClientID %>');
            var VehicleNo = document.getElementById('<%= txtVehicleNumber.ClientID %>');

            if (!RequiredValidation(EngineNo, "Engine Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(ChassisNo, "Chassis Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(VehicleNo, "Vehicle Number Cannot be Blank"))
                return false;

            if (VehicleNo.value != "") {
                if (!isValidVehicleNumber(VehicleNo.value)) {
                    VehicleNo.value = "";
                    VehicleNo.focus();
                    return false;
                }
            }


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

        //        function isDecimalNumberKey(event) {
        //            var charCode = (event.which) ? event.which : event.keyCode
        //            //debugger;
        //            if (charCode == 190 || charCode == 46) {
        //                var txtBox = document.getElementById(event.srcElement.id);
        //                if (txtBox.value.indexOf('.') == -1)
        //                    return true;
        //                else
        //                    return false;
        //            }
        //            else if (charCode > 31 && (charCode < 48 || charCode > 57))
        //                return false;
        //            else
        //                return true;
        //        }

        //        function isDecimalNumberOnly(event) {
        //            var charCode = (event.which) ? event.which : event.keyCode
        //            //debugger;
        //            if (charCode == 190) {
        //                var txtBox = document.getElementById(event.srcElement.id);
        //                if (txtBox.value.indexOf('.') == -1)
        //                    return true;
        //                else
        //                    return false;
        //            }
        //            else if (charCode > 31 && (charCode < 48 || charCode > 57))
        //                return false;
        //            else
        //                return true;
        //        }
    </script>

  
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlNewVehicleDetails" runat="server">
                
                    <table align="center">
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td align="center" colspan="2">
                                <b>Vehicle Details</b>
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">Engine Number<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEngineNumber" CssClass="text1" runat="server" MaxLength="18" onkeypress="return alphanumeric_withspace_only(event);"></asp:TextBox>
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">Chassis Number<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtChassisNumber" CssClass="text1" runat="server" MaxLength="18" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">Vehicle T/R Number<span style="color: Red">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVehicleNumber" CssClass="text1" runat="server" MaxLength="10" onchange="return isValidVehicleNumber(this.value)"></asp:TextBox>
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px" align="center">
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="60px" />
                            </td>
                            <td align="center">
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                    Height="26px" Width="67px" />
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td style="width: 134px">&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                            <td style="width: 27px">&nbsp;
                            </td>
                        </tr>
                    </table>
             
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

