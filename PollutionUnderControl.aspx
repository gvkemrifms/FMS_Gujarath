<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="PollutionUnderControl.aspx.cs" Inherits="PollutionUnderControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<style>
    .button {
        border: none;
        border-radius: 4px;
        color: #FFFFFF;
        cursor: pointer;
        display: inline-block;
        font-size: 28px;
        http: //localhost:58742/VehicleInsurance.aspx padding:0px;
        margin: 5px;
        text-align: center;
        transition: all 0.5s;
        width: 122px;
    }

    .button span {
        cursor: pointer;
        display: inline-block;
        position: relative;
        transition: 0.5s;
    }

    .button span:after {
        content: '\00bb';
        opacity: 0;
        position: absolute;
        right: -20px;
        top: 0;
        transition: 0.5s;
    }

    .button:hover span { padding-right: 25px; }

    .button:hover span:after {
        opacity: 1;
        right: 0;
    }
</style>

<script language="javascript" type="text/javascript">
    function validation() {
        var pollutionValidityStartDate = document.getElementById('<%= txtPollutionValidityStartDate.ClientID %>');
        var pollutionValidityPeriod = document.getElementById('<%= ddlPollutionValidityPeriod.ClientID %>');
        var pollutionReceiptNo = document.getElementById('<%= txtPollutionReceiptNo.ClientID %>');
        var pollutionFee = document.getElementById('<%= txtPollutionFee.ClientID %>');
        var vehiclePurchaseDate = document.getElementById('<%= vehiclePurchaseDate.ClientID %>');
        var now = new Date();
        var id = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
        var inputs = id.getElementsByTagName('input');
        var i;
        for (i = 0; i < inputs.length; i++) {
            switch (inputs[i].type) {
            case 'text':
                if (inputs[i].value !== "" && inputs[i].value != null && inputs[i].value === "--Select--") {
                    alert('Select the Vehicle');
                    return false;
                }
                break;
            }
        }
        if (!RequiredValidation(pollutionValidityStartDate, "Pollution Validity Start Date Cannot be Blank"))
            return false;
        if (!isValidDate(pollutionValidityStartDate.value)) {
            alert("Enter Valid Date");
            pollutionValidityStartDate.focus();
            return false;
        }

        if (Date.parse(pollutionValidityStartDate.value) > Date.parse(now)) {
            alert("Pollution Validity Start Date should not be greater than Current Date");
            pollutionValidityStartDate.focus();
            return false;
        }

        if (Date.parse(pollutionValidityStartDate.value) < Date.parse(vehiclePurchaseDate.value)) {
            alert("Pollution Validity Start Date should be greater than Purchase Date.(PurchaseDate-" +
                vehiclePurchaseDate.value +
                ")");
            pollutionValidityStartDate.focus();
            return false;
        }

        switch (pollutionValidityPeriod.selectedIndex) {
        case 0:
            alert("Please select Pollution Validity Period");
            pollutionValidityPeriod.focus();
            return false;
        }

        if (!RequiredValidation(pollutionReceiptNo, "Pollution Receipt No Cannot be Blank"))
            return false;

        if (!RequiredValidation(pollutionFee, "Pollution Fee Cannot be Blank"))
            return false;
        return true;
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

    function isDecimalNumberKey(event) {
        var charCode = (event.which) ? event.which : event.keyCode;
        if (charCode === 190 || charCode === 46) {
            var txtBox = document.getElementById(event.srcElement.id);
            return txtBox.value.indexOf('.') === -1;
        } else
            return charCode <= 31 || (charCode >= 48 && charCode <= 57);
    }

    function isValidDate(subject) {
        return !!subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/);
    }

    function alphanumeric_only(e) {
        var keycode;
        if (window.event || event || e) keycode = window.event.keyCode;
        else return true;
        return (keycode >= 48 && keycode <= 57) ||
            (keycode >= 65 && keycode <= 90) ||
            (keycode >= 97 && keycode <= 122);

    }

    function alpha_only(e) {
        var keycode;
        if (window.event || event || e) keycode = window.event.keyCode;
        else return true;
        return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122);
    }

</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<table>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td>
        <asp:Panel ID="pnlPUC" runat="server">
            <table style="width: 100%" class="table table-striped table-bordered table-hover">
                <tr>
                    <td align="center" style="font-size: small; font-weight: bold" colspan="5"></td>
                </tr>
                <tr>
                    <td align="center" colspan="5"></td>
                </tr>
                <tr>
                    <td style="width: 200px"></td>
                    <td align="left" style="width: 226px">
                        Vehicle Number<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" AutoPostBack="true" runat="server"
                                      Width="150px" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged" DropDownStyle="DropDownList">
                            <asp:ListItem></asp:ListItem>
                        </cc1:ComboBox>
                        <asp:TextBox ID="txtVehicleNumber" class="text1" runat="server" MaxLength="15" Visible="False"
                                     Width="145px" ReadOnly="True">
                        </asp:TextBox>
                    </td>
                    <td align="center" style="width: 185px"></td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left" style="width: 286px">
                        Pollution Validity Start Date<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <asp:TextBox ID="txtPollutionValidityStartDate" class="text1" AutoPostBack="true" runat="server"
                                     Width="145px" OnTextChanged="txtPollutionValidityStartDate_TextChanged1" onkeypress="return false"
                                     oncut="return false;" onpaste="return false;">
                        </asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:ImageButton ID="imgBtnPollutionValidityStartDate" runat="server" Style="vertical-align: top"
                                         alt="" src="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="calextPollutionValidityStartDate" runat="server" TargetControlID="txtPollutionValidityStartDate"
                                              PopupButtonID="imgBtnPollutionValidityStartDate" Format="MM/dd/yyyy">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left" style="width: 226px">
                        Pollution Validity Period<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <asp:DropDownList ID="ddlPollutionValidityPeriod" class="text1" runat="server" Width="150px" OnSelectedIndexChanged="ddlPollutionValidityPeriod_SelectedIndexChanged"
                                          AutoPostBack="True">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            <asp:ListItem Value="3">3 Month</asp:ListItem>
                            <asp:ListItem Value="6">6 Month</asp:ListItem>
                            <asp:ListItem Value="9">9 Month</asp:ListItem>
                            <asp:ListItem Value="12">1 Year</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="center"></td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left" style="width: 226px">
                        Pollution Validity End Date<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <asp:TextBox ID="txtPollutionValidityEndDate" class="text1" runat="server" Width="145px" BackColor="DarkGray"
                                     ReadOnly="True">
                        </asp:TextBox>
                    </td>
                    <td align="center"></td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left" style="width: 226px">
                        Pollution Receipt No.<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <asp:TextBox ID="txtPollutionReceiptNo" class="text1" runat="server" Width="145px" MaxLength="15"
                                     onkeypress="return alphanumeric_only(event);">
                        </asp:TextBox>
                    </td>
                    <td align="center"></td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left" style="width: 226px">
                        Pollution Fee<span style="color: Red">*</span>
                    </td>
                    <td align="left" colspan="2">
                        <asp:TextBox ID="txtPollutionFee" class="text1" runat="server" Width="145px" onkeypress="return isDecimalNumberKey(event);"
                                     MaxLength="9">
                        </asp:TextBox>
                    </td>
                    <td align="center"></td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center" style="width: 226px">
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                    <td align="center" style="width: 50px">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center" style="width: 226px">
                        <asp:Button ID="btSave" runat="server" Text="Save" OnClick="btSave_Click"/>
                    </td>
                    <td align="left">
                        <asp:Button ID="btReset" runat="server" Text="Reset" OnClick="btReset_Click"/>
                    </td>
                    <td align="center" style="width: 50px">
                        &nbsp;
                    </td>
                    <td align="center">
                        <asp:LinkButton ID="lbtnViewHistory" runat="server" Visible="False">View History</asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="center" style="width: 226px"></td>
                    <td align="left" colspan="2"></td>
                    <td align="center"></td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td align="center" style="width: 226px">
                        &nbsp;
                    </td>
                    <td align="left" colspan="2">
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr align="center">
    <td>
        <asp:GridView ID="gvPollutionUnderControl" runat="server" AutoGenerateColumns="False"
                      CellPadding="4" Width="630px" ForeColor="#333333" GridLines="None" OnRowCommand="gvPollutionUnderControl_RowCommand"
                      OnRowDataBound="gvPollutionUnderControl_RowDataBound" EmptyDataText="No Records Found"
                      AllowPaging="True" OnPageIndexChanging="gvPollutionUnderControl_PageIndexChanging"
                      CssClass="mydatagrid" PagerStyle-CssClass="pager"
                      HeaderStyle-CssClass="header" CellSpacing="2">
            <RowStyle CssClass="rows"/>
            <Columns>
                <asp:TemplateField HeaderText="Vehicle Number">
                    <ItemTemplate>
                        <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PUC Validity Start Date">
                    <ItemTemplate>
                        <asp:Label ID="lblPUCValidityStartDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PUCValidityStartDate") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PUC Validity Period">
                    <ItemTemplate>
                        <asp:Label ID="lblPUCValidityPeriod" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem, "PUCValidityPeriod") %>'>
                        </asp:Label>
                        <asp:Label ID="lblPUCValidityPeriodText" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PUC Validity End Date">
                    <ItemTemplate>
                        <asp:Label ID="lblPUCValidityEndDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PUCValidityEndDate") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PUC Receipt No">
                    <ItemTemplate>
                        <asp:Label ID="lblPUCReceiptNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PUCReceiptNo") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PUC Fee">
                    <ItemTemplate>
                        <asp:Label ID="lblPUCFee" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PUCFee") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="roadTaxEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "PollutionUnderControlID") %>'
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
    </td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<asp:HiddenField ID="vehiclePurchaseDate" runat="server"/>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

