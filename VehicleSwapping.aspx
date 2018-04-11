<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleSwapping.aspx.cs" Inherits="VehicleSwapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
    <script type="text/javascript" language="javascript">

        function validation() {
            var district = document.getElementById('<%= ddlDistrict.ClientID %>');
            var srcVehicle = document.getElementById('<%= ddlSrcVehicle.ClientID %>');
            var destVehicle = document.getElementById('<%= ddlDestVehicle.ClientID %>');
            var srcContactNo = document.getElementById('<%= txtSrcContactNo.ClientID %>');
            var destContactNo = document.getElementById('<%= txtDestContactNo.ClientID %>');

            if (district && district.selectedIndex === 0) {
                alert("Please Select District");
                district.focus();
                return false;
            }

            if (srcVehicle && srcVehicle.selectedIndex === 0) {
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
            return true;
        }

    </script>
    <asp:UpdatePanel ID="updtpnlVehSwapping" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Swapping</legend>
                <table style="width: 600px;">
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>

                    <tr>
                        <td>
                            District
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="true" Width="155px"
                                              OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            Requested By
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtRequestedBy" runat="server" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>
                            Source Vehicle
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlSrcVehicle" runat="server" AutoPostBack="true"
                                          Width="155px" OnSelectedIndexChanged="ddlSrcVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            Destination Vehicle
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
                        <td>
                            Base Location
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtSrcBaseLocation" runat="server" Width="150px" BackColor="#CCCCCC"
                                         ReadOnly="True">
                            </asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            Base Location
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
                        <td>
                            Contact Number
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtSrcContactNo" runat="server" Width="150px" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            Contact Number
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
                        <div style="top: 0px; width: 68px;">
                    </tr>
                    <caption>
                        <img id="loaderButton" alt="" src="../images/savingimage.gif"
                             style="display: none"/>
                        <tr>
                            <td align="center" colspan="7" style="">
                                <asp:Panel ID="pnlButton" runat="server">
                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click"
                                                Text="Submit"/>
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click"
                                                Text="Reset"/>
                                </asp:Panel>
                            </td>
                        </tr>
                    </caption>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>