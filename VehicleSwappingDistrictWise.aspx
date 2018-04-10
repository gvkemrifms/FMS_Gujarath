<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSwappingDistrictWise.aspx.cs" Inherits="VehicleSwappingDistrictWise" %>

<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.40412.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">

        function validation() {
            var district = document.getElementById('<%= ddlSourceDistrict.ClientID %>');
            var srcVehicle = document.getElementById('<%= ddlSrcVehicle.ClientID %>');
            var destVehicle = document.getElementById('<%= ddlDestVehicle.ClientID %>');
            var srcContactNo = document.getElementById('<%= txtSrcContactNo.ClientID %>');
            var destContactNo = document.getElementById('<%= txtDestContactNo.ClientID %>');

            if (district)
                switch (district.selectedIndex) {
                    case 0:
                        alert("Please select District");
                        district.focus();
                        return false;
                }

            if (srcVehicle)
                switch (srcVehicle.selectedIndex) {
                    case 0:
                        alert("Please select Source Vehicle");
                        srcVehicle.focus();
                        return false;
                }

            if (destVehicle && destVehicle.selectedIndex === 0) {
                alert("Please select Destination Vehicle");
                destVehicle.focus();
                return false;
            }

            if (!RequiredValidation(srcContactNo, "Source Contact Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(destContactNo, "Destination Contact Number Cannot be Blank"))
                return false;

            document.getElementById("loaderButton").style.display = '';
            document.all('<%= pnlButton.ClientID %>').style.display = "none";

        }

        function RequiredValidation(ctrl, msg) {
            switch (trim(ctrl.value)) {
                case '':
                    alert(msg);
                    ctrl.focus();
                    return false;
                default:
                    return true;
            }
        }


        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function numeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode === 190 || charCode > 31 && (charCode < 48 || charCode > 57)) {
                var txtBox = document.getElementById(event.srcElement.id);
                return txtBox.value.indexOf('.') === -1;
            } else return true;
        }

    </script>

    <asp:UpdatePanel ID="updtpnlVehSwapping" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>District Vehicle Swapping</legend>
                <table style="width: 600px;">
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>District
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlSourceDistrict" runat="server" AutoPostBack="true" Width="155px"
                                OnSelectedIndexChanged="ddlSourceDistrict_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Districts
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlDestDistrict" AutoPostBack="true" Width="155px"
                                OnSelectedIndexChanged="ddlDestDistrict_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Source Vehicle
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlSrcVehicle" runat="server" AutoPostBack="true"
                                Width="155px" OnSelectedIndexChanged="ddlSrcVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Destination Vehicle
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlDestVehicle" runat="server" AutoPostBack="true"
                                Width="155px" OnSelectedIndexChanged="ddlDestVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Base Location
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtSrcBaseLocation" runat="server" Width="150px" BackColor="#CCCCCC"
                                ReadOnly="True">
                            </asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Base Location
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtDestBaseLocation" runat="server" Width="150px" BackColor="#CCCCCC"
                                ReadOnly="True">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Contact Number
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtSrcContactNo" runat="server" Width="150px" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Contact Number
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtDestContactNo" runat="server" Width="150px" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Requested By
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtRequestedBy" runat="server" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <div style="top: 0px; width: 68px;">
                            <img src="../images/savingimage.gif" style="display: none" id="loaderButton" alt="" />
                            <td colspan="7" align="center" style="">
                                <asp:Panel ID="pnlButton" runat="server">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                                    &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                                </asp:Panel>
                            </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
