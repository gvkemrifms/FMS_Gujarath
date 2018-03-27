<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Admin.VehicleDecommission, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript" language="javascript">
function validation() {

            var District = document.getElementById('<%= ddlDistrict.ClientID %>');
            var VehicleId = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
            var TxtVehicleId = document.getElementById('<%= txtVehicleNumber.ClientID %>');
            var DecommReason = document.getElementById('<%= txtDecommReason.ClientID %>');
            var DecommDate = document.getElementById('<%= txtDecommDate.ClientID %>');
            var DecommRemark = document.getElementById('<%= txtDecommRemark.ClientID %>');

            var now = new Date();


            if (District)
                if (District.selectedIndex == 0) {
                alert("Please Select District");
                District.focus();
                return false;
            }

            if (VehicleId) {
                var inputs = VehicleId.getElementsByTagName('input');
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
            }

            if (TxtVehicleId)
                if (!RequiredValidation(TxtVehicleId, "Vehicle Number cannot be blank"))
                return false;


            if (!RequiredValidation(DecommReason, "Decommission Reason cannot be blank"))
                return false;

            if (!RequiredValidation(DecommDate, "Decommission Date cannot be blank"))
                return false;

            var now = new Date();
            if (Date.parse(DecommDate.value) > Date.parse(now)) {
                alert("Decommission Date should not be greater than Current Date");
                DecommDate.focus();
                return false;
            }

            if (!RequiredValidation(DecommRemark, "Decommission Remark cannot be blank"))
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

        function numeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode
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
        
    </script>

  <%--  <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="../images/b1.jpg"alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="updtpnlVehDecomm" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Decommission</legend>
                <table width="100%">
                    <tr>
                        <td>
                            <table align="center">
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        District<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtDistrict" runat="server" Visible="false" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Vehicle Number<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="true"
                                            DropDownStyle="DropDownList">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </cc1:ComboBox>
                                        <asp:TextBox ID="txtVehicleNumber" runat="server" Visible="false" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Decommission Reason<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDecommReason" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Decommission Date<span style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td style="width: 250px">
                                        <asp:TextBox ID="txtDecommDate" runat="server" Width="120px" onkeypress="return false"></asp:TextBox>
                                        <asp:ImageButton ID="imgbtnDecommDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtndrDecommDate" runat="server" TargetControlID="txtDecommDate"
                                            PopupButtonID="imgbtnDecommDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Decommission Remark<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDecommRemark" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <table align="center">
                                            <tr>
                                                <td style="width: 125px">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                                                </td>
                                                <td style="width: 55px">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <table align="center">
                    <tr align="center">
                        <td>
                            <asp:GridView ID="grdvwDecommVehicles" runat="server" AutoGenerateColumns="False"
                                CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="True"
                                EmptyDataText="No Records Found" CssClass="gridviewStyle" CellSpacing="2" OnPageIndexChanging="grdvwDecommVehicles_PageIndexChanging"
                                OnRowCommand="grdvwDecommVehicles_RowCommand">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="District">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"District") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleNumber") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Decommission Reason">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDecommReason" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DecommReason") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Decommission Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDecommDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DecommDate") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="DecommVehEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"VehicleDecommId") %>'
                                                Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Revert">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRevert" runat="server" CommandName="DecommVehRevert" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"VehicleDecommId") %>'
                                                Text="Revert"></asp:LinkButton>
                                            <cc1:ConfirmButtonExtender ID="confrmbtnextndrRevert" runat="server" TargetControlID="lnkRevert"
                                                ConfirmText="Are you sure? Want to Revert?">
                                            </cc1:ConfirmButtonExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid" />
                                <PagerStyle CssClass="pagerStylegrid" />
                                <SelectedRowStyle CssClass="selectedRowStyle" />
                                <HeaderStyle CssClass="headerStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

