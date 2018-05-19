<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/temp.master" CodeFile="VehicleMaintenanceDetailsNew.aspx.cs" Inherits="VehicleMaintenanceDetailsNew" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script language="javascript" type="text/javascript">

    function validation() {

        var vehicleNumber = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
        var district = document.getElementById('<%= ddlDistrict.ClientID %>');
        var maintenanceDate = document.getElementById('<%= txtMaintenanceDate.ClientID %>');
        var downOdo = document.getElementById('<%= txtDownOdo.ClientID %>');
        var downTime = document.getElementById('<%= txtDownTime.ClientID %>');
        var upOdo = document.getElementById('<%= txtUpOdo.ClientID %>');
        var uptime = document.getElementById('<%= txtUptime.ClientID %>');
        var upHour = document.getElementById('<%= ddlUpHour.ClientID %>');
        var upMin = document.getElementById('<%= ddlUpMin.ClientID %>');
        var now = new Date();
        if (district && district.selectedIndex === 0) {
            alert("Please select District");
            district.focus();
            return false;
        }

        if (vehicleNumber && vehicleNumber.selectedIndex === 0) {
            alert("Please select Vehicle Number");
            vehicleNumber.focus();
            return false;
        }

        if (!RequiredValidation(maintenanceDate, "Maintenance Date Cannot be Blank"))
            return false;

        if (Date.parse(maintenanceDate.value) >
            Date.parse(now.getDate() +
                "/" +
                now.getMonth() +
                1 +
                "/" +
                now.getFullYear() +
                " " +
                now.getHours() +
                ":" +
                now.getMinutes())) {
            alert("Maintenance Date should not be greater than Current Date");
            maintenanceDate.focus();
            return false;
        }

        var downDateFull = downTime.value;
        var downDate = downDateFull.split(' ');
        var downTimeNew = downDate[1].split(':');
        var dtHours = downTimeNew[0];
        var downTimeType = downDate[2];
        if (!RequiredValidation(upOdo, "Up Odo Cannot be Blank"))
            return false;

        if (parseFloat(upOdo.value) < parseFloat(downOdo.value)) {
            alert("UpOdo should be greater than DownOdo");
            upOdo.focus();
            return false;
        }

        if (!RequiredValidation(uptime, "Up Time Cannot be Blank"))
            return false;

        switch (upHour.selectedIndex) {
        case 0:
            alert("Please select Up Hour");
            upHour.focus();
            return false;
        }

        switch (upMin.selectedIndex) {
        case 0:
            alert("Please select Up Min");
            upMin.focus();
            return false;
        }
        if (Date.parse(maintenanceDate.value) > Date.parse(uptime.value + ' ' + upHour.value + ':' + upMin.value)) {
            alert("Up Time should be greater than Maintenance Date.");
            uptime.focus();
            return false;
        }

        switch (Date.parse(downDate[0])) {
        case Date.parse(uptime.value):
            var downHr;
            downHr = downTimeType === 'PM' && parseInt(dtHours) < 12 ? parseInt(dtHours) + 12 : parseInt(dtHours);
            if (downHr > (upHour.value) || downHr === (upHour.value)) {
                alert("Up Time should be greater than Down TIme.");
                upHour.focus();
                return false;
            }
            break;
        }

        return true;
    }

</script>
<asp:UpdatePanel runat="server">
<ContentTemplate>
<script type="text/javascript">
    function pageLoad() {
        $('#<%= ddlDistrict.ClientID %>').select2({
            disable_search_threshold: 5,
            search_contains: true,
            minimumResultsForSearch: 2,
            placeholder: "Select an option"
        });
        $('#<%= ddlVehicleNumber.ClientID %>').select2({
            disable_search_threshold: 5,
            search_contains: true,
            minimumResultsForSearch: 2,
            placeholder: "Select an option"
        });
    }
</script>

<table align="center">
<tr>
<td>
<fieldset style="padding: 10px">
<legend align="center" style="color: brown">
    Vehicle Maintenance Details<br/>
</legend>
<table align="center">
    <tr>
        <td style="width: 80px" class="rowseparator"></td>
    </tr>
    <tr>
        <td>
            District<span style="color: red">*</span>
        </td>
        <td></td>
        <td>

            <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
        <td style="width: 5px"></td>
        <td>
            Vehicle No<span style="color: red">*</span>
        </td>
        <td></td>
        <td>
            <asp:DropDownList ID="ddlVehicleNumber" runat="server" Width="135px" AutoPostBack="True"
                              OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:TextBox ID="txtVehicleNumber" runat="server" Visible="false" onkeypress="return false;"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            Maintenance Type
        </td>
        <td></td>
        <td>
            <asp:TextBox ID="txtMaintenanceType" CssClass="search_3" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>
        </td>
        <td></td>
        <td>
            Maintenance Date
        </td>
        <td></td>
        <td nowrap="nowrap">
            <asp:TextBox ID="txtMaintenanceDate" CssClass="search_3" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
            <asp:ImageButton ID="imgBtnCalendarMaintenanceDate" runat="server" Style="vertical-align: top"
                             alt="" src="images/Calendar.gif"/>
            <cc1:CalendarExtender runat="server" TargetControlID="txtMaintenanceDate"
                                  PopupButtonID="imgBtnCalendarMaintenanceDate" Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
        </td>
        <td></td>
    </tr>
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr>
        <td>
            Down ODO
        </td>
        <td></td>
        <td>
            <asp:TextBox ID="txtDownOdo" CssClass="search_3" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>
        </td>
        <td></td>
        <td>
            Down Time
        </td>
        <td></td>
        <td>
            <asp:TextBox ID="txtDownTime" CssClass="search_3" runat="server" Width="135px" onkeypress="return false;"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr>
        <td>
            Up ODO
        </td>
        <td></td>
        <td>
            <asp:TextBox ID="txtUpOdo" CssClass="search_3" runat="server" Width="135px" onkeypress="return numericOnly(this);"
                         onmousedown="DisableRightClick(event);" onkeydown="return DisableCtrlKey(event)">
            </asp:TextBox>
        </td>
        <td></td>
        <td>
            Up Time
        </td>
        <td></td>
        <td nowrap="nowrap">
            <asp:TextBox ID="txtUptime" CssClass="search_3" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
            <cc1:CalendarExtender runat="server" Enabled="True"
                                  TargetControlID="txtUptime" PopupButtonID="ImageButtonUptime" Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <asp:ImageButton ID="ImageButtonUptime" runat="server" Style="vertical-align: top"
                             alt="" src="images/Calendar.gif"/>
        </td>
        <td></td>
        <td nowrap="nowrap">
            <asp:DropDownList ID="ddlUpHour" CssClass="search_3" runat="server" Width="55px">
                <asp:ListItem Value="-1">--hh--</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlUpMin" CssClass="search_3" runat="server" Width="80px">
                <asp:ListItem Value="-1">--mm--</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr>
        <td>
            BreakDown ID
        </td>
        <td class="columnseparator"></td>
        <td>
            <asp:Label runat="server" ID="lblBreakdownID"/>
        </td>
        <td class="columnseparator"></td>
        <td>
            Approved Cost
        </td>
        <td>
            <asp:Label runat="server" ID="lblApprovedCost"/>
        </td>
    </tr>
</table>
<br/>
<fieldset style="padding: 10px 10px 10px 10px">
<legend>
    <asp:CheckBox ID="chkAmount" runat="server" Text="No Maintenance Amount" OnCheckedChanged="chkAmount_CheckedChanged"
                  AutoPostBack="true"/>
</legend>
<table align="center">
    <tr>
        <td>
            <table align="center">
                <tr>
                    <td class="rowseparator"></td>
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
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:Panel ID="pnlSPBillDetails" runat="server" Visible="false">
    <fieldset style="padding: 10px 10px 0px 10px">
        <legend>Spare Parts </legend>
        <table align="center">
            <tr>
                <td>
                    <table align="center">
                        <tr>
                            <td>
                                <asp:GridView ID="grdvwSPBillDetails" runat="server" AutoGenerateColumns="false"
                                              BackColor="#DEBA84" BorderColor="brown" BorderWidth="1px" CellPadding="3" CellSpacing="2"
                                              DataKeyNames="RowNumber" CssClass="gridview" GridLines="Both" OnRowDataBound="grdvwSPBillDetails_RowDataBound">
                                    <RowStyle CssClass="rowStyleGrid" Width="100%"/>
                                    <Columns>
                                        <asp:BoundField DataField="RowNumber" HeaderText="S.No" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:TemplateField Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor Name">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlSpareVendorName" CssClass="search_3" runat="server" Width="80px"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill No.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpareBillNo" CssClass="search_3" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColSpBillno") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Date">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpareBillDate" CssClass="search_3" runat="server" Width="80px" Wrap="true" onpaste="return false"
                                                             Text='<%# Eval("ColSpBillDate") %>' oncopy="return false" oncut="return false"
                                                             onkeypress="return false">
                                                </asp:TextBox>
                                                <cc1:CalendarExtender ID="calextndrSpareBillDate" runat="server" Format="dd/MM/yyyy"
                                                                      PopupButtonID="imgBtnQuotationDate" TargetControlID="txtSpareBillDate">
                                                </cc1:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="EMRI Part Code">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpareEMRIpc" CssClass="search_3" runat="server" Width="70px" MaxLength="10" Text='<%# Eval("ColSpEMRIPartCode") %>'
                                                             onkeypress="return alphanumeric_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Part Code">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSparePartCode" CssClass="search_3" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColSpPartCode") %>'
                                                             onkeypress="return alphanumeric_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Item Descrip">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlSpareItemDesc" CssClass="search_3" runat="server" Width="80px" AutoPostBack="true"
                                                                  OnSelectedIndexChanged="ddlSpareItemDesc_SelectedIndexChanged"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpareQuant" CssClass="search_3" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColSpQuantity") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Amount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpareBillAmount" CssClass="search_3" runat="server" Width="80px" MaxLength="6" onkeypress="return isDecimalNumberKey(event);"
                                                             Text='<%# Eval("Column3") %>'>
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStylegrid"/>
                                    <PagerStyle CssClass="pagerStylegrid"/>
                                    <SelectedRowStyle CssClass="selectedRowStyle"/>
                                    <HeaderStyle CssClass="headerStyle"/>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" align="center">
                                    <tr>
                                        <td align="center" style="height: 26px">
                                            <asp:Button runat="server" CssClass="form-submit-button" Text="Add Row" OnClick="btnAddNewSPRow_Click"/>
                                        </td>
                                        <td style="height: 26px">
                                            <asp:Button runat="server" CssClass="form-reset-button" Text="Reset" OnClick="btnSPReset_Click"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
        </table>
    </fieldset>
    <br/>
</asp:Panel>
<asp:Panel ID="pnlLubricantBillDetails" runat="server" Visible="false">
    <fieldset style="padding: 10px 10px 0px 10px">
        <legend>Lubricant</legend>
        <table align="center">
            <tr>
                <td>
                    <table align="center">
                        <tr>
                            <td>
                                <asp:GridView ID="grdvwLubricantBillDetails" runat="server" AutoGenerateColumns="false"
                                              BackColor="#DEBA84" BorderColor="brown" BorderWidth="1px" CellPadding="3" CellSpacing="2"
                                              DataKeyNames="RowNumberLubri" CssClass="gridviewStyle" GridLines="Both" OnRowDataBound="grdvwLubricantBillDetails_RowDataBound">
                                    <RowStyle CssClass="rowStyleGrid" Width="100%"/>
                                    <Columns>
                                        <asp:BoundField DataField="RowNumberLubri" HeaderText="S.No" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:TemplateField Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor Name">
                                            <ItemTemplate>
                                                <asp:DropDownList CssClass="center" ID="ddlLubricantVendorName" runat="server" Width="80px"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Number">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantBillNo" CssClass="search_3" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColLubriBillNo") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Date">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantBillDate" CssClass="search_3" runat="server" Width="80px" Wrap="true" onpaste="return false"
                                                             Text='<%# Eval("ColLubriBillDate") %>' oncopy="return false" oncut="return false"
                                                             onkeypress="return false">
                                                </asp:TextBox>
                                                <cc1:CalendarExtender ID="calextndrLubricantBillDate" runat="server" Format="MM/dd/yyyy"
                                                                      PopupButtonID="imgBtnQuotationDate" TargetControlID="txtLubricantBillDate">
                                                </cc1:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="EMRI Part Code">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantEMRIpc" CssClass="search_3" runat="server" Width="70px" MaxLength="10" Text='<%# Eval("ColLubriEMRIPartCode") %>'
                                                             onkeypress="return alphanumeric_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Part Code">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantPartCode" CssClass="search_3" runat="server" Width="80px" MaxLength="10"
                                                             Text='<%# Eval("ColLubriPartCode") %>' onkeypress="return alphanumeric_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Item Descp.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantItemDesc" runat="server" Width="80px" MaxLength="10"
                                                             Text='<%# Eval("ColLubriItemDescription") %>' onkeypress="return alpha_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantQuant" CssClass="search_3" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColLabQuantity") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Amount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLubricantBillAmount" CssClass="" runat="server" Width="80px" MaxLength="6"
                                                             Text='<%# Eval("ColLubriBillAmount") %>' onkeypress="return isDecimalNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStylegrid"/>
                                    <PagerStyle CssClass="pagerStylegrid"/>
                                    <SelectedRowStyle CssClass="selectedRowStyle"/>
                                    <HeaderStyle CssClass="headerStyle"/>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" align="center">
                                    <tr>
                                        <td align="center" style="height: 26px">
                                            <asp:Button runat="server" CssClass="form-submit-button" Text="Add Row" OnClick="btnAddNewLubriRow_Click"/>
                                        </td>
                                        <td style="height: 26px">
                                            <asp:Button runat="server" CssClass="form-reset-button" Text="Reset" OnClick="btnLubriReset_Click"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
        </table>
    </fieldset>
    <br/>
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
                                              BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="3" CellSpacing="2"
                                              DataKeyNames="RowNumberLabour" CssClass="gridviewStyle" GridLines="Both" OnRowDataBound="grdvwLabourBillDetails_RowDataBound">
                                    <RowStyle CssClass="rowStyleGrid" Width="100%"/>
                                    <Columns>
                                        <asp:BoundField DataField="RowNumberLabour" HeaderText="S.No" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:TemplateField Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowno" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor Name">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlLabourVendorName" runat="server" Width="80px"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Number">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourBillNo" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColLabBillNo") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Date">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourBillDate" runat="server" Width="80px" Wrap="true" onpaste="return false"
                                                             Text='<%# Eval("ColLabBillDate") %>' oncopy="return false" oncut="return false"
                                                             onkeypress="return false">
                                                </asp:TextBox>
                                                <cc1:CalendarExtender ID="calextndrLabourBillDate" runat="server" Format="MM/dd/yyyy"
                                                                      PopupButtonID="imgBtnQuotationDate" TargetControlID="txtLabourBillDate">
                                                </cc1:CalendarExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Aggre">
                                            <ItemTemplate>
                                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourAggregates" runat="server" AutoPostBack="true"
                                                              Width="80px" DropDownStyle="DropDownList">
                                                </cc1:ComboBox>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourCategories" runat="server" AutoPostBack="true"
                                                              Width="80px" DropDownStyle="DropDownList">
                                                </cc1:ComboBox>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sub Category">
                                            <ItemTemplate>
                                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlLabourSubCategories" runat="server" AutoPostBack="true"
                                                              Width="80px" DropDownStyle="DropDownList">
                                                </cc1:ComboBox>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Item Descp.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourItemDesc" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColLabItemDescription") %>'
                                                             onkeypress="return alpha_only(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourQuant" runat="server" Width="80px" MaxLength="10" Text='<%# Eval("ColLabQuantity") %>'
                                                             onkeypress="return isNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Amount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourBillAmount" runat="server" Width="80px" MaxLength="6" Text='<%# Eval("Column3") %>'
                                                             onkeypress="return isDecimalNumberKey(event);">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStylegrid"/>
                                    <PagerStyle CssClass="pagerStylegrid"/>
                                    <SelectedRowStyle CssClass="selectedRowStyle"/>
                                    <HeaderStyle CssClass="headerStyle"/>
                                </asp:GridView>

                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" align="center">
                                    <tr>
                                        <td align="center" style="height: 26px">
                                            <asp:Button ID="btnAddNewLabourRow" runat="server" CssClass="form-submit-button" Text="Add Row" OnClick="btnAddNewLabourRow_Click"/>
                                        </td>
                                        <td style="height: 26px">
                                            <asp:Button ID="btnLabourReset" runat="server" Text="Reset" CssClass="form-reset-button" OnClick="btnLabourReset_Click"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
        </table>
    </fieldset>
    <br/>
</asp:Panel>
<asp:Panel ID="pnlBillDetailsSummaryBtn" runat="server" Visible="false">
    <table width="100%">
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnBillDetailsSummary" CssClass="form-submit-button" runat="server" Text="Bill Details Summary" width="180px"
                            OnClick="btnBillDetailsSummary_Click"/>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlBillSummaryDetails" runat="server" Visible="false">
    <fieldset style="padding: 10px 10px 0px 10px">
        <legend>Bill Details Summary</legend>
        <table align="center">
            <tr>
                <td>
                    <table align="center">
                        <tr>
                            <td>
                                <asp:GridView ID="grdvwBillDetailsSummary" runat="server" AutoGenerateColumns="false"
                                              BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10"
                                              CellSpacing="2" DataKeyNames="TypeBillDetails" CssClass="gridviewStyle" GridLines="None"
                                              Width="100%">
                                    <RowStyle CssClass="rowStyleGrid" Width="100%"/>
                                    <Columns>
                                        <asp:BoundField DataField="TypeBillDetails" HeaderText="Type" HeaderStyle-Width="150px"/>
                                        <asp:BoundField DataField="TotalBillNumbers" HeaderText="Total Bills" HeaderStyle-Width="100px"
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                                        <asp:BoundField DataField="TotalBillAmount" HeaderText="Total Bill Amount" HeaderStyle-Width="100px"
                                                        HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                                    </Columns>
                                    <FooterStyle CssClass="footerStylegrid"/>
                                    <PagerStyle CssClass="pagerStylegrid"/>
                                    <SelectedRowStyle CssClass="selectedRowStyle"/>
                                    <HeaderStyle CssClass="headerStyle"/>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
    <br/>
</asp:Panel>
</fieldset>
<table width="100%">
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <tr>
        <td></td>
        <td style="width: 98px">
            Total Bill Amount
        </td>
        <td style="width: 120px">
            <asp:TextBox ID="txtTotalBillAmt" CssClass="search_3" runat="server" Width="120px" onkeypress="return false;"></asp:TextBox>
        </td>
    </tr>
</table>
<asp:GridView ID="gvVehicleMaintenanceDetails" runat="server" AllowPaging="True"
              AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CellSpacing="2"
              CssClass="gridviewStyle" EmptyDataText="No Records Found" EnableSortingAndPagingCallbacks="True"
              ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvVehicleMaintenanceDetails_PageIndexChanging"
              OnRowCommand="gvVehicleMaintenanceDetails_RowCommand" OnSelectedIndexChanged="gvVehicleMaintenanceDetails_SelectedIndexChanged"
              Width="630px" Visible="false">
    <RowStyle CssClass="rowStyleGrid"/>
    <Columns>
        <asp:TemplateField HeaderText="VehicleNo">
            <ItemTemplate>
                <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OffRoadVehicle_No") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="District">
            <ItemTemplate>
                <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "District") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Maintenanace Type">
            <ItemTemplate>
                <asp:Label ID="lblMaintenanaceType" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MaintenanaceType") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="MaintenanceDate" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblMaintenanceDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MaintenanceDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DownOdo" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblDownOdo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DownTimeOdoReading") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DownTime">
            <ItemTemplate>
                <asp:Label ID="lblDowntime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Downtime") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="UpOdo" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblUpOdo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "UptimeOdoReading") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="UpTime">
            <ItemTemplate>
                <asp:Label ID="lblUptime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Uptime") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SpareBillNo" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblSpareBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SpareBillNo") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SpareBillDate" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblSpareBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SpareBillDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SpareBillAmount" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblSpareBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SpareBillAmount") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LubricantBillNo" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLubricantBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LubricantBillNo") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LubricantBillDate" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLubricantBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LubricantBillDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LubricantBillAmount" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLubricantBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LubricantBillAmount") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LabourBillNo" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLabourBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LabourBillNo") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LabourBillDate" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLabourBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LabourBillDate") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="LabourBillAmount" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lblLabourBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LabourBillAmount") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Edit">
            <ItemTemplate>
                <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "OffRoad_Id") %>'
                                CommandName="VehMainEdit" Text="Edit">
                </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "OffRoad_Id") %>'
                                CommandName="VehMainDelete" Text="Delete">
                </asp:LinkButton>
                <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to Delete?"
                                           TargetControlID="lnkDelete">
                </cc1:ConfirmButtonExtender>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <FooterStyle CssClass="footerStylegrid"/>
    <PagerStyle CssClass="pagerStylegrid"/>
    <SelectedRowStyle CssClass="selectedRowStyle"/>
    <HeaderStyle CssClass="headerStyle"/>
</asp:GridView>
<br/>
<table align="center">
    <tr>
        <td>
            <asp:Button ID="btnSave" runat="server" CssClass="form-submit-button" Text="Save" OnClick="btnSave_Click" Enabled="false"/>
        </td>
        <td style="width: 100px"></td>
        <td>
            <asp:Button ID="btnReset" runat="server" CssClass="form-reset-button" Text="Reset" OnClick="btnReset_Click"/>
        </td>
    </tr>
</table>
<br/>
<br/>
<table align="center">
    <tr align="center">
        <td></td>
    </tr>
</table>
</fieldset>
</td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>