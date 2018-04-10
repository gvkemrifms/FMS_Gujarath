<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/temp.master" CodeFile="VehiclemaintenanceNonoffroad.aspx.cs" Inherits="VehiclemaintenanceNonoffroad" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .WrapStyle TD {
            word-break: break-all;
        }
    </style>
    <script language="javascript" type="text/javascript">

        function Validation() {
            var vehiclenoddl = document.getElementById('<%= ddlVehicles.ClientID %>');
            if (vehiclenoddl && vehiclenoddl.selectedIndex === 0) {
                alert("Please select Vehicle number");
                vehiclenoddl.focus();
                return false;
            }
            return true;
        }

        function alphanumeric_only(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 48 && keycode <= 57) ||
                (keycode >= 65 && keycode <= 90) ||
                (keycode >= 97 && keycode <= 122);
        }

        function numeric_only(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return keycode >= 48 && keycode <= 57;
        }

        function isDecimalNumberKey(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode === 190 || charCode === 46 || charCode > 31 && (charCode < 48 || charCode > 57)) {
                var txtBox = document.getElementById(event.srcElement.id);
                return txtBox.value.indexOf('.') === -1;
            } else return true;
        }

        function alpha_only(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122);
        }

        function numeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode === 190 || charCode > 31 && (charCode < 48 || charCode > 57)) {
                var txtBox = document.getElementById(event.srcElement.id);
                return txtBox.value.indexOf('.') === -1;
            } else return true;
        }

        function alpha_only_withspace(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode === 32);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="Updtepanelvehoffroad" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Non OffRoad</legend>
                <table style="width: 640px;">
                    <tr>
                        <td colspan="7"></td>
                    </tr>
                    <tr>
                        <td style="width: 162px">Vehicle Number<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td colspan="5">
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicles" runat="server" AutoPostBack="true"
                                DropDownStyle="DropDownList"
                                OnSelectedIndexChanged="ddlVehicles_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator" style="width: 162px"></td>
                    </tr>
                    <div id="divLocationDetails" runat="server">
                        <tr>
                            <td style="width: 162px">District<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td style="width: 148px">
                                <asp:TextBox runat="server" ID="txtDistrict" Enabled="False" />
                            </td>
                            <td class="columnseparator"></td>
                            <td>Location<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:TextBox runat="server" ID="txtLocation" Enabled="False" />
                            </td>
                        </tr>
                    </div>
                </table>
                <asp:Panel ID="pnlBillDetails" runat="server">
                    <fieldset style="padding: 0px 0px 0px 0px">
                        <legend>Maintenance Details </legend>

                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMtype" Text="Maintenance Type" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMaintenanceType" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="lblmdate" Text="Maintenance Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMaintenanceDate" runat="server"
                                        onkeypress="return false">
                                    </asp:TextBox>
                                    <cc1:CalendarExtender ID="calextndrBillDate22" runat="server" Format="dd/MM/yyyy"
                                        PopupButtonID="imgBtnQuotationDate" TargetControlID="txtMaintenanceDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblvName" Text="Vendor Name" runat="server"></asp:Label>
                                </td>

                                <td>
                                    <asp:DropDownList ID="ddlVendorName" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblBno" Text="Bill Number" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillNo" runat="server" MaxLength="10"
                                        onkeypress="return numeric(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblBillDate" Text="Bill Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillDate" runat="server"
                                        onkeypress="return false">
                                    </asp:TextBox>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                                        PopupButtonID="imgBtnQuotationDate" TargetControlID="txtBillDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPartCode" Text="Part Code" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPartCode" runat="server" MaxLength="10"
                                        onkeypress="return numeric_only(event);">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblItemDescription" Text="Item Description" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtItemDesc" runat="server"
                                        onkeypress="return alpha_only_withspace(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblQuantity" Text="Item Quantity" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtQuant" runat="server" MaxLength="5"
                                        onkeypress="return numeric(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="lblBillAmount" Text="Bill Amount" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillAmount" runat="server" MaxLength="12" onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <asp:Button runat="server" ID="Button1" Text="Save" Width="52px"
                                        OnClick="btnSave_Click" OnClientClick="return Validation()" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSPReset" runat="server" Text="Reset"
                                        OnClick="btnSPReset_Click" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                </asp:Panel>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

