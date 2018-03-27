<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VehicleMaintenanceandRepairs.VehicleMaintenanceEdit, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type="text/javascript">

        function validation() {

            var VehicleNumber = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
            var District = document.getElementById('<%=  ddlDistrict.ClientID %>');
            var TotalBillAmount = document.getElementById('<%=txtTotalBillAmt.ClientID %>');
            var checkAmount = document.getElementById('<%=chkAmount.ClientID %>');
            var now = new Date();


            if (District)
                if (District.selectedIndex == 0) {
                alert("Please select District");
                District.focus();
                return false;
            }

            if (VehicleNumber)
                if (VehicleNumber.selectedIndex == 0) {
                alert("Please select Vehicle Number");
                VehicleNumber.focus();
                return false;
            }

//            if (!RequiredValidation(MaintenanceDate, "Maintenance Date Cannot be Blank"))
//                return false;

//            if (Date.parse(MaintenanceDate.value) > Date.parse(now)) {
//                alert("Maintenance Date should not be greater than Current Date");
//                MaintenanceDate.focus();
//                return false;
//            }

            var DownDateFull = DownTime.value;
            var DownDate = DownDateFull.split(' ');
            var DownTimeNew = DownDate[1].split(':');
            var DTHours = DownTimeNew[0];
            var DTMinutes = DownTimeNew[1];
            var DownTimeType = DownDate[2];


//            if (Date.parse(DownDate[0]) > Date.parse(MaintenanceDate.value)) {
//                alert("Maintenance Date should be greater than Down Time.");
//                MaintenanceDate.focus();
//                return false;
//            }

//            if (!RequiredValidation(UpOdo, "Up Odo Cannot be Blank"))
//                return false;

//            if (parseFloat(UpOdo.value) < parseFloat(DownOdo.value)) {
//                alert("UpOdo should be greater than DownOdo");
//                UpOdo.focus();
//                return false;
//            }

//            if (!RequiredValidation(Uptime, "Up Time Cannot be Blank"))
//                return false;

//            if (UpHour.selectedIndex == 0) {
//                alert("Please select Up Hour");
//                UpHour.focus();
//                return false;
//            }

//            if (UpMin.selectedIndex == 0) {
//                alert("Please select Up Min");
//                UpMin.focus();
//                return false;
//            }
//            if (Date.parse(MaintenanceDate.value) > Date.parse(Uptime.value + ' ' + UpHour.value + ':' + UpMin.value)) {
//                alert("Up Time should be greater than Maintenance Date.");
//                Uptime.focus();
//                return false;
//            }

//            if (Date.parse(DownDate[0]) == Date.parse(Uptime.value)) {
//                if (DownTimeType == 'PM' && parseInt(DTHours) < 12) {
//                    var DownHr = (parseInt(DTHours) + 12);
//                }
//                else {
//                    var DownHr = parseInt(DTHours);
//                }
//                if (DownHr > (UpHour.value)) {
//                    alert("Up Time should be greater than Down TIme.");
//                    UpHour.focus();
//                    return false;
//                }
//                else if (DownHr == (UpHour.value)) {
//                    if (DTMinutes > (UpMin.value)) {
//                        alert("Up Time should be greater than Down TIme.");
//                        UpMin.focus();
//                        return false;
//                    }
//                }
  //          }


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

        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
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
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        
    </script>

   
    <asp:UpdatePanel ID="updtpnlVehMaintDet" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Vehicle Maintenance Details<br />
                            </legend>
                            <table>
                                <tr>
                                    <td style="width: 60px" class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        District
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtDistrict" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>--%>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 5px">
                                    </td>
                                    <td>
                                        Vehicle No
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehicleNumber" runat="server" Width="135px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtVehicleNumber" runat="server" Visible="false" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" visible="false">
                                       <%-- Maintenance Type--%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMaintenanceType" runat="server" Width="135px" onkeypress="return false;" Visible="false"></asp:TextBox>
                                        <%--<asp:DropDownList ID="ddlMaintenanceType" runat="server" Width="135px">
                                        </asp:DropDownList>--%>
                                    </td>
                                    <td>
                                    </td>
                                    </tr>
                                   <%-- <td>
                                        Maintenance Date
                                    </td>
                                    <td>
                                    </td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="txtMaintenanceDate" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
                                        <asp:ImageButton ID="imgBtnCalendarMaintenanceDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtMaintenanceDate" runat="server" TargetControlID="txtMaintenanceDate"
                                            PopupButtonID="imgBtnCalendarMaintenanceDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Down ODO
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDownOdo" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Down Time
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDownTime" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Up ODO
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUpOdo" runat="server" Width="135px" onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Up Time
                                    </td>
                                    <td>
                                    </td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="txtUptime" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtUptime_CalendarExtender" runat="server" Enabled="True"
                                            TargetControlID="txtUptime" PopupButtonID="ImageButtonUptime" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                        <asp:ImageButton ID="ImageButtonUptime" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                    </td>
                                    <td>
                                    </td>
                                    <td nowrap="nowrap">
                                        <asp:DropDownList ID="ddlUpHour" runat="server" Width="55px">
                                            <asp:ListItem Value="-1">--hh--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlUpMin" runat="server" Width="60px">
                                            <asp:ListItem Value="-1">--mm--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>--%>
                            </table>
                            <br />
                            <fieldset style="padding: 10px 10px 10px 10px" id="fsMaintenance" runat="server">
                                <legend>
                                    <asp:CheckBox ID="chkAmount" runat="server" Text="No Maintenance Amount" OnCheckedChanged="chkAmount_CheckedChanged"
                                        AutoPostBack="true" /></legend>
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
                                                        <asp:CheckBoxList ID="chkbxlistBillType" runat="server" CellPadding="10" CellSpacing="10"
                                                            RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="chkbxlistBillType_SelectedIndexChanged">
                                                            <asp:ListItem Value="SpareParts">Spare Parts</asp:ListItem>
                                                            <asp:ListItem Value="Lubricant">Lubricant</asp:ListItem>
                                                            <asp:ListItem Value="LabourCharges">Labour Charges</asp:ListItem>
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="pnlSPBillDetails" runat="server" Visible="false">
                                    <fieldset style="padding: 10px 10px 0px 10px">
                                        <legend>Spare Parts </legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table align="center">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdvwSPBillDetails" runat="server" AutoGenerateColumns="false"
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" 
                                                                    CellPadding="3" CellSpacing="2"
                                                                    DataKeyNames="RowNumber" CssClass="gridviewStyle" GridLines="None" 
                                                                    onrowdatabound="grdvwSPBillDetails_RowDataBound">
                                                                    <RowStyle CssClass="rowStyleGrid" Width="100%" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNumber" HeaderText="S.No" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:TemplateField Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Vendor Name">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlSpareVendorName" runat="server" Width="60px" />
                                               
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill No.">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSpareBillNo" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColSpBillno") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Date">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSpareBillDate" runat="server" Width="60px" Wrap="true" onpaste="return false"
                                                                                    Text='<%# Eval("ColSpBillDate") %>' oncopy="return false" oncut="return false"
                                                                                    onkeypress="return false"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="calextndrSpareBillDate" runat="server" Format="MM/dd/yyyy"
                                                                                    PopupButtonID="imgBtnQuotationDate" TargetControlID="txtSpareBillDate">
                                                                                </cc1:CalendarExtender>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="EMRI Part Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSpareEMRIpc" runat="server" Width="70px" MaxLength="10" Text='<%# Eval("ColSpEMRIPartCode") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Part Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSparePartCode" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColSpPartCode") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Item Descrip">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlSpareItemDesc" runat="server" Width="60px" 
                                                                                OnSelectedIndexChanged="ddlSpareItemDesc_SelectedIndexChanged"/>
                                                                                 </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSpareQuant" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColSpQuantity") %>'
                                                                                    onkeypress="return isNumber(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Amount">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSpareBillAmount" runat="server" Width="60px" MaxLength="6" onkeypress="return isDecimalNumberKey(event);"
                                                                                    Text='<%# Eval("Column3") %>'></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle CssClass="footerStylegrid" />
                                                                    <PagerStyle CssClass="pagerStylegrid" />
                                                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                                                    <HeaderStyle CssClass="headerStyle" />
                                                                </asp:GridView>
                                                                <%--<asp:HiddenField ID="hdnRowno" runat="server" />--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="rowseparator">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table width="100%" align="center">
                                                                    <tr>
                                                                        <td align="center" style="height: 26px">
                                                                            <asp:Button ID="btnAddNewSPRow" runat="server" Text="Add Row" OnClick="btnAddNewSPRow_Click" />
                                                                        </td>
                                                                        <td style="height: 26px">
                                                                            <asp:Button ID="btnSPReset" runat="server" Text="Reset" OnClick="btnSPReset_Click" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                </asp:Panel>
                                <asp:Panel ID="pnlLubricantBillDetails" runat="server" Visible="false">
                                    <fieldset style="padding: 10px 10px 0px 10px">
                                        <legend>Lubricant</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table align="center">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdvwLubricantBillDetails" runat="server" AutoGenerateColumns="false"
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" 
                                                                    CellPadding="3" CellSpacing="2"
                                                                    DataKeyNames="RowNumberLubri" CssClass="gridviewStyle" GridLines="None" 
                                                                    onrowdatabound="grdvwLubricantBillDetails_RowDataBound">
                                                                    <RowStyle CssClass="rowStyleGrid" Width="100%" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNumberLubri" HeaderText="S.No" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:TemplateField Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Vendor Name">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlLubricantVendorName" runat="server" Width="60px"  />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Number">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantBillNo" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColLubriBillNo") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Date">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantBillDate" runat="server" Width="60px" Wrap="true" onpaste="return false"
                                                                                    Text='<%# Eval("ColLubriBillDate") %>' oncopy="return false" oncut="return false"
                                                                                    onkeypress="return false"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="calextndrLubricantBillDate" runat="server" Format="MM/dd/yyyy"
                                                                                    PopupButtonID="imgBtnQuotationDate" TargetControlID="txtLubricantBillDate">
                                                                                </cc1:CalendarExtender>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="EMRI Part Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantEMRIpc" runat="server" Width="70px" MaxLength="10" 
                                                                                Text='<%# Eval("ColLubriEMRIPartCode") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Part Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantPartCode" runat="server" Width="60px" MaxLength="10"
                                                                                    Text='<%# Eval("ColLubriPartCode") %>' onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Item Descp.">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantItemDesc" runat="server" Width="60px" MaxLength="10"
                                                                                    Text='<%# Eval("ColLubriItemDescription") %>' onkeypress="return alpha_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantQuant" runat="server" Width="60px" MaxLength="10"
                                                                                 Text='<%# Eval("ColLabQuantity") %>'
                                                                                   onkeypress="return isNumber(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Amount">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLubricantBillAmount" runat="server" Width="60px" MaxLength="6"
                                                                                    Text='<%# Eval("ColLubriBillAmount") %>' onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle CssClass="footerStylegrid" />
                                                                    <PagerStyle CssClass="pagerStylegrid" />
                                                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                                                    <HeaderStyle CssClass="headerStyle" />
                                                                </asp:GridView>
                                                                <%--<asp:HiddenField ID="hdnRowno" runat="server" />--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="rowseparator">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table width="100%" align="center">
                                                                    <tr>
                                                                        <td align="center" style="height: 26px">
                                                                            <asp:Button ID="btnAddNewLubriRow" runat="server" Text="Add Row" OnClick="btnAddNewLubriRow_Click" />
                                                                        </td>
                                                                        <td style="height: 26px">
                                                                            <asp:Button ID="btnLubriReset" runat="server" Text="Reset" OnClick="btnLubriReset_Click" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                </asp:Panel>
                                <asp:Panel ID="pnlLabourBillDetails" runat="server" Visible="false">
                                    <fieldset style="padding: 10px 10px 0px 10px">
                                        <legend>LabourCharges</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table align="center">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdvwLabourBillDetails" runat="server" AutoGenerateColumns="false"
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" 
                                                                    CellPadding="3" CellSpacing="2"
                                                                    DataKeyNames="RowNumberLabour" CssClass="gridviewStyle" GridLines="None" 
                                                                    OnRowDataBound="grdvwLabourBillDetails_RowDataBound">
                                                                    <RowStyle CssClass="rowStyleGrid" Width="100%" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNumberLabour" HeaderText="S.No" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:TemplateField Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Vendor Name">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlLabourVendorName" runat="server" Width="60px" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Number">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLabourBillNo" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColLabBillNo") %>'
                                                                                    onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Date">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLabourBillDate" runat="server" Width="60px" Wrap="true" onpaste="return false"
                                                                                    Text='<%# Eval("ColLabBillDate") %>' oncopy="return false" oncut="return false"
                                                                                    onkeypress="return false"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="calextndrLabourBillDate" runat="server" Format="MM/dd/yyyy"
                                                                                    PopupButtonID="imgBtnQuotationDate" TargetControlID="txtLabourBillDate">
                                                                                </cc1:CalendarExtender>
                                                                                
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Aggre"> 
                                                                           <ItemTemplate>
                                                                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourAggregates" runat="server" 
                                                                                    Width="60px" DropDownStyle="DropDownList"  >
                                                                                </cc1:ComboBox>
                                                                                <%-- <asp:DropDownList ID="ddlLabourAggregates" runat="server" Width="60px" />--%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Category">
                                                                            <ItemTemplate>
                                                                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourCategories" runat="server" 
                                                                                    Width="60px" DropDownStyle="DropDownList"  >
                                                                                </cc1:ComboBox>
                                                                                <%--<asp:DropDownList ID="ddlLabourCategories" runat="server" Width="60px" />--%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Sub Category">
                                                                            <ItemTemplate>
                                                                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourSubCategories" runat="server" 
                                                                                    Width="60px" DropDownStyle="DropDownList"  >
                                                                                </cc1:ComboBox>
                                                                                <%--<asp:DropDownList ID="ddlLabourSubCategories" runat="server" Width="60px" />--%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Item Descp.">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLabourItemDesc" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColLabItemDescription") %>'
                                                                                    onkeypress="return alpha_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLabourQuant" runat="server" Width="60px" MaxLength="10" Text='<%# Eval("ColLabQuantity") %>'
                                                                                    onkeypress="return isNumber(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Amount">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtLabourBillAmount" runat="server" Width="60px" MaxLength="6" Text='<%# Eval("Column3") %>'
                                                                                    onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle CssClass="footerStylegrid" />
                                                                    <PagerStyle CssClass="pagerStylegrid" />
                                                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                                                    <HeaderStyle CssClass="headerStyle" />
                                                                </asp:GridView>
                                                                <%--<asp:HiddenField ID="hdnRowno" runat="server" />--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="rowseparator">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table width="100%" align="center">
                                                                    <tr>
                                                                        <td align="center" style="height: 26px">
                                                                            <asp:Button ID="btnAddNewLabourRow" runat="server" Text="Add Row" OnClick="btnAddNewLabourRow_Click" />
                                                                        </td>
                                                                        <td style="height: 26px">
                                                                            <asp:Button ID="btnLabourReset" runat="server" Text="Reset" OnClick="btnLabourReset_Click" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                </asp:Panel>
                                <asp:Panel ID="pnlBillDetailsSummaryBtn" runat="server" Visible="false">
                                    <table width="100%">
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Button ID="btnBillDetailsSummary" runat="server" Text="Bill Details Summary"
                                                    OnClick="btnBillDetailsSummary_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlBillSummaryDetails" runat="server" Visible="false">
                                    <fieldset style="padding: 10px 10px 0px 10px">
                                        <legend>Bill Details Summary</legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table align="center">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdvwBillDetailsSummary" runat="server" AutoGenerateColumns="false"
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10"
                                                                    CellSpacing="2" DataKeyNames="TypeBillDetails" CssClass="gridviewStyle" GridLines="None"
                                                                    Width="100%">
                                                                    <RowStyle CssClass="rowStyleGrid" Width="100%" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="TypeBillDetails" HeaderText="Type" HeaderStyle-Width="150px" />
                                                                        <asp:BoundField DataField="TotalBillNumbers" HeaderText="Total Bills" HeaderStyle-Width="100px"
                                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:BoundField DataField="TotalBillAmount" HeaderText="Total Bill Amount" HeaderStyle-Width="100px"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                    </Columns>
                                                                    <FooterStyle CssClass="footerStylegrid" />
                                                                    <PagerStyle CssClass="pagerStylegrid" />
                                                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                                                    <HeaderStyle CssClass="headerStyle" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="rowseparator">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                </asp:Panel>

                            </fieldset>
                            <table width="100%">
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <div id="divBillAmount" runat="server">
                                    <td style="width: 98px">
                                        Total Bill Amount
                                    </td>
                                    <td style="width: 120px">
                                        <asp:TextBox ID="txtTotalBillAmt" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
                                    </td>
                                    </div>
                                </tr>
                            </table>
                            <br />
                            <table align="center">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" Text="Update" OnClick="btnSave_Click"  />
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td>
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                            <table align="center">
                                <tr align="center">
                                    <td>
                                        <%--  GridView ID="gvRoadTax" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                Width="630px" ForeColor="#333333" GridLines="None" OnRowCommand="gvRoadTax_RowCommand"
                                OnRowDataBound="gvRoadTax_RowDataBound" AllowPaging="True" EmptyDataText="No Records Found"
                                OnPageIndexChanging="gvRoadTax_PageIndexChanging" CssClass="gridviewStyle" CellSpacing="2"--%>
                                        <%-- <div style="width: 600px; height: 400px; overflow: scroll">--%>
                                        <asp:GridView ID="gvVehicleMaintenanceDetails" runat="server" EmptyDataText="No Records Found"
                                            AllowSorting="True" AutoGenerateColumns="False" CssClass="gridviewStyle" CellSpacing="2"
                                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="True"
                                            OnPageIndexChanging="gvVehicleMaintenanceDetails_PageIndexChanging" OnRowCommand="gvVehicleMaintenanceDetails_RowCommand"
                                            EnableSortingAndPagingCallbacks="True">
                                            <RowStyle CssClass="rowStyleGrid" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="VehicleNo">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"OffRoadVehicle_No") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="District">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"District") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maintenanace Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMaintenanaceType" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"MaintenanaceType") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="MaintenanceDate" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMaintenanceDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"MaintenanceDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DownOdo" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDownOdo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DownTimeOdoReading") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DownTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDowntime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Downtime") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="UpOdo" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUpOdo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"UptimeOdoReading") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="UpTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUptime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Uptime") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SpareBillNo" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSpareBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SpareBillNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SpareBillDate" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSpareBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SpareBillDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SpareBillAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSpareBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SpareBillAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LubricantBillNo" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLubricantBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LubricantBillNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LubricantBillDate" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLubricantBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LubricantBillDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LubricantBillAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLubricantBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LubricantBillAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LabourBillNo" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLabourBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LabourBillNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LabourBillDate" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLabourBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LabourBillDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="LabourBillAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLabourBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"LabourBillAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="VehMainEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"OffRoad_Id") %>'
                                                            Text="Edit"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="VehMainDelete" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"OffRoad_Id") %>'
                                                            Text="Delete"></asp:LinkButton>
                                                        <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnkDelete"
                                                            ConfirmText="Are you sure you want to Delete?">
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
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

