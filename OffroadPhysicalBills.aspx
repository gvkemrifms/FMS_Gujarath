<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="OffroadPhysicalBills.aspx.cs" Inherits="OffroadPhysicalBills" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
    function dateselect(ev) {
        var calendarBehavior1 = window.$find("cc1");
        var d = calendarBehavior1._selectedDate;
        var now = new Date();
        calendarBehavior1.get_element().value = d.format("dd/MM/yyyy") + " " + now.format("HH:mm:ss");
    }

    function validation2() {
        var fldDocketNo = document.getElementById('<%= txtDocketNo.ClientID %>');
        var fldReceiptDate = document.getElementById('<%= txtReceiptDate.ClientID %>');
        var fldCourierName = document.getElementById('<%= txtCourierName.ClientID %>');
        var fldBillAm = document.getElementById('<%= txtBillAmount.ClientID %>');
        if (!RequiredValidation(fldReceiptDate, "Receipt Date cannot be left blank"))
            return false;
        if (!RequiredValidation(fldBillAm, "Bill Amount cannot be left blank"))
            return false;
        if (!RequiredValidation(fldCourierName, "Courier Name cannot be left blank"))
            return false;

        if (!RequiredValidation(fldDocketNo, "Docket Number cannot be left blank"))
            return false;
    }

    function RequiredValidation(ctrl, msg) {
        if (trim(ctrl.value) === '') {
            alert(msg);
            ctrl.focus();
            return false;
        } else
            return true;
    }

    function trim(value) {
        value = value.replace(/^\s+/, '');
        value = value.replace(/\s+$/, '');
        return value;

    }

    function validation() {

        var fldDistrict = document.getElementById('<%= ddlDistricts.ClientID %>');
        var fldDocketNo = document.getElementById('<%= txtDocketNo.ClientID %>');
        var fldVehicleno = document.getElementById('<%= ddlVehicleNo.ClientID %>');
        var fldBillNo = document.getElementById('<%= ddlBillNo.ClientID %>');
        var fldReceiptDate = document.getElementById('<%= txtReceiptDate.ClientID %>');
        var fldCourierName = document.getElementById('<%= txtCourierName.ClientID %>');
        var fldBillAm = document.getElementById('<%= txtBillAmount.ClientID %>');
        var now = new Date();


        if (fldDistrict && fldDistrict.selectedIndex === 0) {
            alert("Please Select District");
            fldDistrict.focus();
            return false;
        }
        if (fldVehicleno && fldVehicleno.selectedIndex === 0) {
            alert("Please select Vehicle");
            fldVehicleno.focus();
            return false;
        }
        if (fldDocketNo && fldBillNo.selectedIndex === 0) {
            alert("Please select BillNo");
            fldBillNo.focus();
            return false;
        }

        if (!requiredValidation(fldBillAm, "Bill Amount cannot be left blank"))
            return false;
        if (!requiredValidation(fldReceiptDate, "Receipt Date cannot be left blank"))
            return false;
        if (!requiredValidation(fldCourierName, "Courier Name cannot be left blank"))
            return false;

        if (!requiredValidation(fldDocketNo, "Docket Number cannot be left blank"))
            return false;
        if (Date.parse(fldReceiptDate.value) > Date.parse(now)) {
            alert("Receipts Date should not be greater than Current Date");
            fldReceiptDate.focus();
            return false;
        }

        function requiredValidation(ctrl, msg) {
            switch (trim(ctrl.value)) {
            case '':
                alert(msg);
                ctrl.focus();
                return false;
            default:
                return true;
            }
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

    function alpha_only(e) {
        var keycode;
        if (window.event || event || e) keycode = window.event.keyCode;
        else return true;
        return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122);
    }

    function alpha_only_withspace(e) {
        var keycode;
        if (window.event || event || e) keycode = window.event.keyCode;
        else return true;
        return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode === 32);
    }

    function trim(value) {
        value = value.replace(/^\s+/, '');
        value = value.replace(/\s+$/, '');
        return value;

    }


    function isDecimalNumberKey(event) {
        var charCode = (event.which) ? event.which : event.keyCode;
        if (charCode === 190 || charCode === 46 || charCode > 31 && (charCode < 48 || charCode > 57)) {
            var txtBox = document.getElementById(event.srcElement.id);
            return txtBox.value.indexOf('.') === -1;
        } else return true;
    }


</script>
<asp:UpdatePanel ID="updtpnlVehMaintDet" runat="server">
<ContentTemplate>
<table width="100%">
<tr>
<td>
<fieldset style="padding: 10px">
<legend>
    Off Road Physical Bills<br/>
</legend>
<table>
    <tr>
        <td style="width: 85px" class="rowseparator">
        </td>
    </tr>
    <tr>
        <td>
            District
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:DropDownList ID="ddlDistricts" Height="16px" Width="120px" runat="server" OnSelectedIndexChanged="ddlDistricts_SelectedIndexChanged"
                              AutoPostBack="true">
            </asp:DropDownList>
        </td>


        <td class="columnseparator">
        </td>

        <td>
            Vehicle No
        </td>
        <td class="columnseparator">
        </td>
        <td>
        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNo" runat="server" AutoPostBack="true"
                      OnSelectedIndexChanged="ddlVehicleNo_SelectedIndexChanged" DropDownStyle="DropDownList">
        </cc1:ComboBox>

    </tr>
    <tr>
        <td style="width: 85px" class="rowseparator">
        </td>
    </tr>
    <tr>
        <td>
            Bill No
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:DropDownList runat="server" ID="ddlBillNo" Width="122px"
                              AutoPostBack="True"
                              onselectedindexchanged="ddlBillNo_SelectedIndexChanged"/>
        </td>
        <td class="columnseparator">

        </td>
        <td>
            BreakDown ID
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:Label runat="server" ID="lblBreakdwn"/>
        </td>

    </tr>

    <tr>
        <td style="width: 85px" class="rowseparator">
        </td>
    </tr>
</table>
<table>
    <tr>
        <td>
            Bill Amount
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox ID="txtBillAmount" runat="server"
                         onkeypress="return numeric_only(event);"/>
        </td>
        <td class="columnseparator">
        </td>
        <td>
            Down Time
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox ID="txtDownTime" runat="server" Enabled="false"/>
        </td>
        <td class="columnseparator">
        </td>
        <td>
            Up Time
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox ID="txtUpTime" runat="server" Enabled="false"/>
        </td>
    </tr>
    <tr>
        <td style="width: 85px" class="rowseparator">
        </td>
    </tr>
    <tr>
        <td>
            Receipt Date
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtReceiptDate" Width="114px" onkeypress="false;"/>
            <cc1:CalendarExtender ID="calExtMaintenanceDate" runat="server" TargetControlID="txtReceiptDate"
                                  PopupButtonID="imgBtnCalendarMaintenanceDate" Format="dd'/'MM'/'yyyy HH':'mm':'ss"
                                  OnClientDateSelectionChanged="dateselect">
            </cc1:CalendarExtender>
        </td>
        <td class="columnseparator">
        </td>
        <td>
            Courier Name
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtCourierName" onkeypress="return alpha_only_withspace(event);"/>
        </td>
        <td class="columnseparator">
        </td>
        <td>
            Docket No
        </td>
        <td class="columnseparator">
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtDocketNo" onkeypress="return numeric_only(event);"/>
        </td>
    </tr>
    <tr>
        <td class="rowseparator">
        </td>
    </tr>
</table>
<table>
    <tr>
        <td>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnSave" Text="Save"
                        onclick="btnSave_Click" OnClientClick="return validation()"/>

            <asp:HiddenField ID="HiddenField1" runat="server"/>
            <asp:Button runat="server" ID="btnUpdate" Visible="false" Text="Update"
                        onclick="btnUpdate_Click" OnClientClick="return validation2()"/>
            <asp:Button runat="server" ID="btnReset" Text="Reset" onclick="btnReset_Click"/>
            <%----%>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
</table>
<div>
    <div style="width: 200px; float: left">
    </div>
    <div style="float: left">
        <asp:GridView ID="gvVehiclePhysicalBillDetails" runat="server" EmptyDataText="No Records Found"
                      AllowSorting="True" AutoGenerateColumns="False" CssClass="gridviewStyle" CellSpacing="2"
                      CellPadding="4" ForeColor="#333333" GridLines="None" Width="650px" AllowPaging="True"
                      EnableSortingAndPagingCallbacks="True"
                      onrowcommand="gvVehiclePhysicalBillDetails_RowCommand" onpageindexchanging="gvVehiclePhysicalBillDetails_PageIndexChanging">
            <RowStyle CssClass="rowStyleGrid"/>
            <Columns>
                <asp:TemplateField HeaderText="District">
                    <ItemTemplate>
                        <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "District") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Break Down">
                    <ItemTemplate>
                        <asp:Label ID="lblBrkdwn" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Vehicle No">
                    <ItemTemplate>
                        <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Vechicleno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill No">
                    <ItemTemplate>
                        <asp:Label ID="lblBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "BillNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Amount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Down Time">
                    <ItemTemplate>
                        <asp:Label ID="lblDownTime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "downtime") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Up Time">
                    <ItemTemplate>
                        <asp:Label ID="lblUptime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Uptime") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Receipt Date">
                    <ItemTemplate>
                        <asp:Label ID="lblReceiptDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ReceiptDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Courier Name">
                    <ItemTemplate>
                        <asp:Label ID="lblCourier_Name" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Courier_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rejection Reason">
                    <ItemTemplate>
                        <asp:Label ID="lblReject" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ReasonforReject") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket No">
                    <ItemTemplate>
                        <asp:Label ID="lblDocketNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DocketNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="VehMainEdit" CommandArgument=" <%# Container.DataItemIndex %>"
                                        Text="Edit">
                        </asp:LinkButton>

                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="footerStylegrid"/>
            <PagerStyle CssClass="pagerStylegrid"/>
            <SelectedRowStyle CssClass="selectedRowStyle"/>
            <HeaderStyle CssClass="headerStyle"/>
        </asp:GridView>
    </div>
</div>
</fieldset>
</td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>


