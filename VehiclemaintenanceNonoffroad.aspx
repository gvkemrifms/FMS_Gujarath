<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VehiclemaintenanceNonoffroad, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script language="javascript" type="text/javascript">

        function Validation() {
            var vehiclenoddl = document.getElementById('<%=ddlVehicles.ClientID %>');


            if (vehiclenoddl)
                if (vehiclenoddl.selectedIndex == 0) {
                alert("Please select Vehicle number");
                vehiclenoddl.focus();
                return false;
            }

//            if (!RequiredValidation(vehicleno, "Vehicle no cannot be left blank"))
//                return false;

//            if (!RequiredValidation(maintenanceType, "Maintenance Type cannot be left blank"))
//                return false;

//            if (!RequiredValidation(maintenanceDate, "Maintenance Date cannot be left blank"))
//                return false;
//            if (!RequiredValidation(VendorName, "Vendor Name cannot be left blank"))
//                return false;

//            if (!RequiredValidation(billno, "Bill no cannot be left blank"))
//                return false;

//            if (!RequiredValidation(billdate, "Bill date cannot be left blank"))
//                return false;
//            if (!RequiredValidation(partcode, "Part code cannot be left blank"))
//                return false;

//            if (!RequiredValidation(itemdesc, "Item Description cannot be left blank"))
//                return false;

//            if (!RequiredValidation(Quantity, "Quantity cannot be left blank"))
//                return false;
//            if (!RequiredValidation(amount, "Amount cannot be left blank"))
//                return false;

//            if (Date.parse(maintenanceDate.value) > Date.parse(now)) {
//                alert("Maintenance Date should not be greater than Current Date");
//                maintenanceDate.focus();
//                return false;
//            }
//            if (Date.parse(billdate.value) > Date.parse(now)) {
//                alert("Bill Date should not be greater than Current Date");
//                maintenanceDate.focus();
//                return false;
//            }

            
//            function RequiredValidation(ctrl, msg) {
//                if (trim(ctrl.value) == '') {
//                    alert(msg);
//                    ctrl.focus();
//                    return false;
//                }
//                else
//                    return true;
//            }
//            function trim(value) {
//                value = value.replace(/^\s+/, '');
//                value = value.replace(/\s+$/, '');
//                return value;
//            }
        
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
    function numeric_only(e) {
        if (window.event) keycode = window.event.keyCode;
        else if (event) keycode = event.keyCode;
        else if (e) keycode = e.which;
        else return true; if ((keycode >= 48 && keycode <= 57)) {
            return true;
        }
        else {
            return false;
        }
        return true;
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

</script>
   <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>
    <asp:UpdatePanel ID="Updtepanelvehoffroad" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Non OffRoad</legend>
                <table style="width: 640px;">
                    <tr>
                        <td colspan="7">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 162px" >
                            Vehicle Number<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td colspan="5" >
                            <%--<asp:DropDownList ID="ddlVehicles" runat="server" Width="30%" 
                                AutoPostBack="True" CausesValidation="True">--%>
                                
                            <%--</asp:DropDownList>--%>
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicles" runat="server" AutoPostBack="true"
                                DropDownStyle="DropDownList" 
                                onselectedindexchanged="ddlVehicles_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox> 
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator" style="width: 162px">
                        </td>
                    </tr>
                    <div id="divLocationDetails" runat="server">
                    <tr>
                        <td style="width: 162px">
                            District<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td style="width: 148px">
                            <asp:TextBox runat="server" ID="txtDistrict" Enabled="False" />
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            Location<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtLocation" Enabled="False" />
                        </td>
                    </tr>
                    </div>
                    </table>
                    <asp:Panel ID="pnlBillDetails" runat="server">
                                    <fieldset style="padding: 0px 0px 0px 0px">
                                        <legend>Maintenance Details </legend>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <table align="center">
                                                        <tr >
                                                            <td>
                                                                <asp:GridView ID="grdvwMaintenanceDetails" runat="server" AutoGenerateColumns="false"
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" 
                                                                    CellPadding="3" CellSpacing="2"
                                                                    DataKeyNames="RowNumber" CssClass="gridviewStyle" GridLines="None" 
                                                                    onrowdatabound="grdvwMaintenanceDetails_RowDataBound" 
                                                                    onrowcommand="grdvwMaintenanceDetails_RowCommand" 
                                                                    onpageindexchanging="grdvwMaintenanceDetails_PageIndexChanging">
                                                                    <RowStyle CssClass="rowStyleGrid" Width="100%" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNumber" HeaderText="S.No" ItemStyle-HorizontalAlign="Center" />
                                                                        <asp:TemplateField Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Vehicle No">
                                                                            <ItemTemplate>
                                                                               <asp:TextBox ID="txtVehicleNo" runat="server" Width="60px" Text='<%# Eval("ColVehNo  ")%>' ToolTip="dd"
                                                                               onkeypress="return alphanumeric_only(event)" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Main tenance Type">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlMaintenanceType" runat="server" Width="60px" >
                                                                                </asp:DropDownList>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Main tenance Date">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtMaintenanceDate" runat="server" Width="70px"  Text='<%# Eval("ColMainBillDate") %>'
                                                                                onkeypress="return false"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="calextndrBillDate22" runat="server" Format="MM/dd/yyyy"
                                                                                    PopupButtonID="imgBtnQuotationDate" TargetControlID="txtMaintenanceDate">
                                                                                    </cc1:CalendarExtender>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Vendor Name">
                                                                            <ItemTemplate>
                                                                               <asp:DropDownList ID="ddlVendorName" runat="server" Width="60px" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill No.">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtBillNo" runat="server" Width="50px" MaxLength="10" Text='<%# Eval("ColBillno") %>'
                                                                                onkeypress="return numeric(event)"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Date">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtBillDate" runat="server" Width="50px" Wrap="true" onpaste="return false" Text='<%# Eval("ColBillDate") %>'
                                                                                    oncopy="return false" oncut="return false" onkeypress="return false"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="calextndrBillDate" runat="server" Format="MM/dd/yyyy"
                                                                                    PopupButtonID="imgBtnQuotationDate" TargetControlID="txtBillDate">
                                                                                </cc1:CalendarExtender>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Part Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtPartCode" runat="server" Width="50px" MaxLength="10" Text='<%# Eval("ColPartCode") %>'
                                                                                onkeypress="return numeric_only(event);"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Item Descrip">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtItemDesc" runat="server" Width="60px"  Text='<%# Eval("ColItemDescription") %>'
                                                                                onkeypress="return alpha_only_withspace(event)"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtQuant" runat="server" Width="60px" MaxLength="5"  Text='<%# Eval("ColQuantity") %>'
                                                                                onkeypress="return numeric(event)"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bill Amount">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtBillAmount" runat="server" Width="60px" MaxLength="12" onkeypress="return isDecimalNumberKey(event);" Text='<%# Eval("Column3") %>'></asp:TextBox>
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
                                                                            <%--<asp:Button ID="btnAddNewSPRow" runat="server" Text="Add Row" 
                                                                                onclick="btnAddNewSPRow_Click"  />--%>
                                                                                 <asp:Button runat="server" ID="Button1" Text="Save" Width="52px" 
                                                                                            onclick="btnSave_Click" OnClientClick="return Validation()" />
                                                                        </td>
                                                                        <td style="height: 26px">
                                                                            <asp:Button ID="btnSPReset" runat="server" Text="Reset" 
                                                                                onclick="btnSPReset_Click"  />
                                                                        </td>
                                                                    </tr>
                                                         <%--<tr>
                                                            <td class="rowseparator">
                                                            </td>
                                                        </tr>
                                                        <tr align="center" >
                                                        <td colspan="5">
                                                          <asp:Button runat="server" ID="btnSave" Text="Save" Width="52px" 
                                                                onclick="btnSave_Click" />
                                                        </td>
                                                        </tr>--%>
                                                        
                                                                </table>
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
         </ContentTemplate>
       </asp:UpdatePanel>
</asp:Content>

