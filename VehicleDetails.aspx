<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleDetails.aspx.cs" Inherits="VehicleDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
    <script src="../JavaValidations/RequiredFieldValidations.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validation() {
            var engineNo = document.getElementById('<%= txtEngineNumber.ClientID %>');
            var chassisNo = document.getElementById('<%= txtChassisNumber.ClientID %>');
            var vehicleNo = document.getElementById('<%= txtVehicleNumber.ClientID %>');

            if (!RequiredValidation(engineNo, "Engine Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(chassisNo, "Chassis Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(vehicleNo, "Vehicle Number Cannot be Blank"))
                return false;

            if (vehicleNo.value !== "" && !isValidVehicleNumber(vehicleNo.value)) {
                vehicleNo.value = "";
                vehicleNo.focus();
                return false;
            }
            return true;

        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlNewVehicleDetails" runat="server">

                <table align="center">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="center" colspan="2">
                            <b>Vehicle Details</b>
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            Engine Number<span style="color: Red">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEngineNumber" CssClass="text1" runat="server" MaxLength="18" onkeypress="return alphanumeric_withspace_only(event);"></asp:TextBox>
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            Chassis Number<span style="color: Red">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtChassisNumber" CssClass="text1" runat="server" MaxLength="18" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            Vehicle T/R Number<span style="color: Red">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtVehicleNumber" CssClass="text1" runat="server" MaxLength="10" onchange="return isValidVehicleNumber(this.value)"></asp:TextBox>
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px" align="center">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="60px"/>
                        </td>
                        <td align="center">
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        Height="26px" Width="67px"/>
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 134px">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td style="width: 27px">
                            &nbsp;
                        </td>
                    </tr>
                </table>

            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
