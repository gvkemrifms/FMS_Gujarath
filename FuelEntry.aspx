<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelEntry.aspx.cs" Inherits="FuelEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:UpdatePanel runat="server">
<ContentTemplate>
<script type="text/javascript">
    $(function() {
        $('#<%= ddlVehicleNumber.ClientID %>').select2({
            disable_search_threshold: 5,
            search_contains: true,
            minimumResultsForSearch: 20,
            placeholder: "Select an option"
        });
    });

</script>

<fieldset style="padding: 10px">
<legend align="center" style="color: brown">Fuel Entry</legend>
<table align="center">
<br/>
<tr>
    <td style="float: left">
        Vehicle Number<span style="color: Red">*</span>
    </td>
    <td>
        <asp:DropDownList AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="True"
                          OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged" Width="150px">
        </asp:DropDownList>
    </td>
    <td style="float: right; padding-right: 10px">
        Borrowed Vehicle
    </td>
    <td >
        <asp:DropDownList AutoCompleteMode="Append" ID="ddlDistrict" runat="server" AutoPostBack="True"
                          OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged" Width="150px" CssClass="search_3">
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="rowseparator" colspan="4">
    </td>
</tr>
<tr>
    <td style="width: auto">
        District
    </td>
    <td>
        <asp:Label ID="lblDistrict" runat="server"/>
    </td>
    <td style="float: right; padding: 10px">
        Base Location
    </td>
    <td>
        <asp:Label ID="lblLocation" runat="server"/>
    </td>
</tr>
<tr>
    <td class="rowseparator" colspan="4">
    </td>
</tr>
<tr>
    <td style="float: left">
        Date<span style="color: Red">*</span>
    </td>
    <td>
        <asp:TextBox ID="txtFuelEntryDate" runat="server" MaxLength="15" oncut="return false;"
                     onkeypress="return false" CssClass="search_3" onpaste="return false;">
        </asp:TextBox>
        <cc1:CalendarExtender ID="entDate" runat="server" Format="MM/dd/yyyy" CssClass="cal_Theme1" PopupButtonID="ImageButton1"
                              TargetControlID="txtFuelEntryDate">
        </cc1:CalendarExtender>
        <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                         style="float: right; vertical-align: top;"/>
    </td>
    <td style="float: right; padding: 10px">
        Bill Number<span style="color: Red">*</span>
    </td>
    <td >
        <asp:TextBox ID="txtBillNumber" CssClass="search_3" runat="server" MaxLength="16"></asp:TextBox>
    </td>
</tr>

<tr>
    <td >
        Odometer(km)<span style="color: Red">*</span>
    </td>
    <td >
        <asp:TextBox ID="txtOdometer" runat="server" CssClass="search_3" MaxLength="6"></asp:TextBox>
    </td>
    <td style="float: right; padding-right: 10px">
        Bunk Name<span style="color: Red">*</span>
    </td>
    <td >
        <div>
            <asp:DropDownList Style="float: left" ID="ddlBunkName" runat="server">
            </asp:DropDownList>
            <asp:TextBox Style="float: left" CssClass="search_3" ID="txtBunkName" runat="server" MaxLength="20" Enabled="false" Width="200px"></asp:TextBox>
        </div>
        <div>
            <asp:LinkButton ID="linkExisting" runat="server" Style="float: right" OnClick="linkExisting_Click"
                            Text="Add Existing">
            </asp:LinkButton>
            <asp:LinkButton ID="lnkNew" runat="server" Style="float: right" OnClick="lnkNew_Click"
                            Text="Add New">
            </asp:LinkButton>
        </div>
    </td>
</tr>
<tr>
    <td >
        Paymode<span style="color: Red">*</span>
    </td>
    <td >
        <asp:DropDownList ID="ddlPaymode" runat="server" CssClass="search_3" AutoCompleteMode="Append" AutoPostBack="True"
                          OnSelectedIndexChanged="ddlPaymode_SelectedIndexChanged">
        </asp:DropDownList>
    </td>
    <td style="float: right; padding-right: 10px">
        Quantity(Litres)<span style="color: Red">*</span>
    </td>
    <td>
        <asp:TextBox ID="txtQuantity" CssClass="search_3" runat="server" MaxLength="6" OnChange="onKeyPressBlockNumbers1(this.value);"></asp:TextBox>
    </td>
</tr>

<tr>
    <td >
        Petro Card Number<span style="color: Red">*</span>
    </td>
    <td >
        <asp:DropDownList ID="ddlPetroCardNumber" CssClass="search_3" runat="server" AutoCompleteMode="Append"
                          AutoPostBack="True" OnSelectedIndexChanged="ddlPetroCardNumber_SelectedIndexChanged">
        </asp:DropDownList>
    </td>
    <td style="float: right; padding: 10px">
        Unit Price(Rs)<span style="color: Red">*</span>
    </td>
    <td>
        <asp:TextBox ID="txtUnitPrice" CssClass="search_3" runat="server" MaxLength="6" onchange="onKeyPressBlockNumbers(this.value);"></asp:TextBox>
    </td>
</tr>

<tr>
    <td >
        Agency<span style="color: Red">*</span>
    </td>
    <td >
        <asp:DropDownList ID="ddlAgency" CssClass="search_3" runat="server" AutoCompleteMode="Append">
        </asp:DropDownList>
    </td>
    <td style="float: right; padding-right: 10px">
        Amount(Rs)<span style="color: Red">*</span>
    </td>
    <td >
        <asp:TextBox ID="txtAmount" runat="server" CssClass="search_3" Enabled="False"></asp:TextBox>
    </td>
</tr>

<tr>
    <td >
        Location<span style="color: Red">*</span>
    </td>
    <td >
        <asp:TextBox ID="txtLocation" runat="server" CssClass="search_3" MaxLength="20"></asp:TextBox>
    </td>
    <td style="float: right; padding: 10px">
        Pilot ID<span style="color: Red">*</span>
    </td>
    <td>
        <asp:TextBox ID="txtPilotID" runat="server" CssClass="search_3" MaxLength="6"></asp:TextBox>
    </td>
</tr>

<tr>
    <td >
        Pilot Name<span style="color: Red">*</span>
    </td>
    <td >
        <asp:TextBox ID="txtPilotName" CssClass="search_3" runat="server"></asp:TextBox>
    </td>
    <td style="float: right; padding-right: 10px">
        Card Swiped
    </td>
    <td >
        <asp:DropDownList ID="ddlCardSwiped" CssClass="search_3" runat="server">
            <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
            <asp:ListItem Text="No" Value="0"></asp:ListItem>
            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>

<tr>
    <td style="padding: 10px">
        Remarks
    </td>
    <td>
        <asp:TextBox ID="txtRemarks" CssClass="search_3" runat="server"/>
    </td>
</tr>
<tr>
    <td class="rowseparator">
    </td>
</tr>
<tr>
    <td >
        <asp:TextBox ID="txtSegmentID" runat="server" CssClass="search_3" Visible="False"></asp:TextBox>
    </td>
    <td >
        <asp:Button ID="Save" runat="server" CssClass="form-submit-button" OnClick="Save_Click" OnClientClick="if (!validationFuelEntry()) return false;"
                    Text="Save"/>
    </td>
    <td >
        <asp:Button ID="Reset" runat="server" OnClick="Reset_Click" Text="Reset" CssClass="form-reset-button"/>
    </td>
    <td >
        <asp:TextBox ID="txtEdit" CssClass="search_3" runat="server" Visible="False"></asp:TextBox>
    </td>
</tr>

</table>
<br/>
</fieldset>
<fieldset style="padding: 10px">
    <table align="center" style="width: 615px">
        <tr>
            <td style="width: 100px">
                <asp:GridView ID="gvFuelEntry" runat="server" BorderWidth="1px" BorderColor="brown" AllowPaging="true" AutoGenerateColumns="False"
                              CellPadding="3" CellSpacing="2" EmptyDataText="No Records Found"
                              GridLines="None" OnPageIndexChanging="gvFuelEntry_PageIndexChanging" OnRowCommand="gvFuelEntry_RowCommand"
                              PageSize="5" Width="609px" class="table table-striped table-bordered table-hover">
                    <RowStyle CssClass="rowStyleGrid"/>
                    <Columns>
                        <asp:BoundField DataField="vehno" HeaderText="Vehicle"/>
                        <asp:BoundField DataField="EntryDate" HeaderText="Date"/>
                        <asp:BoundField DataField="odo" HeaderText="Odometer"/>
                        <asp:BoundField DataField="mode" HeaderText="mode"/>
                        <asp:BoundField DataField="agency" HeaderText="agency"/>
                        <asp:BoundField DataField="Cardno" HeaderText="Cardno"/>
                        <asp:BoundField DataField="BillNo" HeaderText="BillNo"/>
                        <asp:BoundField DataField="Qty" HeaderText="Qty"/>
                        <asp:BoundField DataField="Price" HeaderText="Price"/>
                        <asp:BoundField DataField="Amount" HeaderText="Amount"/>
                        <asp:BoundField DataField="StatusDesc" HeaderText="Status"/>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "FuelEntryID") %>'
                                                CommandName="EditFuel" Text="Edit">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "FuelEntryID") %>'
                                                CommandName="DeleteFuel" Text="Delete">
                                </asp:LinkButton>
                                <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to DELETE"
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
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:GridView ID="gvLastTransactions" runat="server" AutoGenerateColumns="False"
                              Caption="Last Five Transactions" CaptionAlign="Top" CellPadding="3" CellSpacing="2"
                              CssClass="gridviewStyle" EmptyDataText="No Records Found" GridLines="None" PageSize="5"
                              Width="609px">
                    <RowStyle CssClass="rowStyleGrid"/>
                    <Columns>
                        <asp:BoundField DataField="vehno" HeaderText="Vehicle"/>
                        <asp:BoundField DataField="EntryDate" HeaderText="Date"/>
                        <asp:BoundField DataField="odo" HeaderText="Odometer"/>
                        <asp:BoundField DataField="mode" HeaderText="mode"/>
                        <asp:BoundField DataField="agency" HeaderText="agency"/>
                        <asp:BoundField DataField="Cardno" HeaderText="Cardno"/>
                        <asp:BoundField DataField="BillNo" HeaderText="BillNo"/>
                        <asp:BoundField DataField="Qty" HeaderText="Qty"/>
                        <asp:BoundField DataField="Price" HeaderText="Price"/>
                        <asp:BoundField DataField="Amount" HeaderText="Amount"/>
                        <asp:BoundField DataField="StatusDesc" HeaderText="Status"/>
                    </Columns>
                    <FooterStyle CssClass="footerStylegrid"/>
                    <PagerStyle CssClass="pagerStylegrid"/>
                    <SelectedRowStyle CssClass="selectedRowStyle"/>
                    <HeaderStyle CssClass="headerStyle"/>
                </asp:GridView>
            </td>
        </tr>
    </table>
</fieldset>
<asp:HiddenField ID="maxOdo" runat="server"/>
<script type="text/javascript">
    function sum() {
        var text1 = parseFloat(document.getElementById("<%= txtQuantity.ClientID %>").value);
        var text2 = parseFloat(document.getElementById("<%= txtUnitPrice.ClientID %>").value);
        var text3 = text1 * text2;
        document.getElementById("<%= txtAmount.ClientID %>").value = text3.toFixed(2);
    }

    function validationFuelEntry() {
        var vehicleNumber = $("#<%= ddlVehicleNumber.ClientID %> option:selected").text().toLowerCase();
        switch (vehicleNumber) {
        case '--select--':
            return alert("Please Select the VehicleNumber");
        }
        var fuelEntryDate = document.getElementById('<%= txtFuelEntryDate.ClientID %>');

        if (!RequiredValidation(fuelEntryDate, "Fuel Entry Date Cannot be Blank"))
            return false;

        if (trim(fuelEntryDate.value) !== "") {
            if (!isValidDate(fuelEntryDate.value)) {
                alert("Enter the Valid Date");
                fuelEntryDate.focus();
                return false;
            }
        }

        var now = new Date();
        if (Date.parse(fuelEntryDate.value) > Date.parse(now)) {
            alert("Fuel Entry Date should not be greater than Current Date");
            fuelEntryDate.focus();
            return false;
        }

        if (document.getElementById("<%= txtBillNumber.ClientID %>").value === '') {
            alert("Please Enter BillNumber value");
            document.getElementById("<%= txtBillNumber.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtOdometer.ClientID %>").value === '') {
            alert("Please Enter Odometer value");
            document.getElementById("<%= txtOdometer.ClientID %>").focus();
            return false;
        }

        var paymode = document.getElementById('<%= ddlPaymode.ClientID %>');

        if (paymode.selectedIndex === 0) {
            alert("Please select the Paymode");
            paymode.focus();
            return false;
        }

        if (paymode.options[paymode.selectedIndex].text === "Card") {
            var agency = document.getElementById('<%= ddlAgency.ClientID %>');

            if (agency.selectedIndex === 0) {
                alert("Please select the Agency");
                agency.focus();
                return false;
            }

            var petroCardNumber = document.getElementById('<%= ddlPetroCardNumber.ClientID %>');

            if (petroCardNumber.selectedIndex === 0) {
                alert("Please select the PetroCardNumber");
                petroCardNumber.focus();
                return false;
            }
        }
        if (document.getElementById("<%= txtQuantity.ClientID %>").value === '') {
            alert("Please Enter quantity value");
            document.getElementById("<%= txtQuantity.ClientID %>").focus();
            return false;
        }

        if (document.getElementById("<%= txtUnitPrice.ClientID %>").value === '') {
            alert("Please Enter UnitPrice value");
            document.getElementById("<%= txtUnitPrice.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtLocation.ClientID %>").value === '') {
            alert("Please Enter Location value");
            document.getElementById("<%= txtLocation.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtPilotID.ClientID %>").value === '') {
            alert("Please Enter Pilot ID");
            document.getElementById("<%= txtPilotID.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtPilotName.ClientID %>").value === '') {
            alert("Please Enter Pilot Name");
            document.getElementById("<%= txtPilotName.ClientID %>").focus();
            return false;
        }


        var cardSwiped = document.getElementById('<%= ddlCardSwiped.ClientID %>');

        if (cardSwiped.selectedIndex === 0) {
            alert("Please select the CardSwipedStatus");
            cardSwiped.focus();
            return false;
        }

        var maxOdo = document.getElementById("<%= maxOdo.ClientID %>");
        var givenOdo = document.getElementById("<%= txtOdometer.ClientID %>");

        if (parseInt(maxOdo.value) >= parseInt(givenOdo.value)) {
            alert("Odometer value should be greater than the Previous Odometer value (Pre Odo Reading=" +
                maxOdo.value +
                ")");
            givenOdo.focus();
            return false;
        }

        return true;
    }


    function onKeyPressBlockNumbers(value) {
        var reg = /^\-?([1-9]\d*|0)(\.\d?[1-9])?$/;
        if (!reg.test(value)) {
            alert("please enter numeric values only");
            document.getElementById("<%= txtUnitPrice.ClientID %>").value = "";
            return false;
        }

        var text5 = parseFloat(document.getElementById("<%= txtUnitPrice.ClientID %>").value);
        if (text5 > 75) {
            alert("Unit Price Cant be greater than 75");
            document.getElementById("<%= txtUnitPrice.ClientID %>").value = "";
            return false;
        }

        sum();
        return reg.test(value);
    }


    function onKeyPressBlockNumbers1(value) {
        var reg = /^\-?([1-9]\d*|0)(\.\d?[1-9])?$/;
        if (!reg.test(value)) {
            alert("please enter numeric values only");
            document.getElementById("<%= txtQuantity.ClientID %>").value = "";
            return false;
        }

        var text5 = parseFloat(document.getElementById("<%= txtQuantity.ClientID %>").value);
        if (text5 > 65) {
            alert("Quantity Cant be greater than 65");
            document.getElementById("<%= txtQuantity.ClientID %>").value = "";
            return false;
        }

        sum();
        return reg.test(value);
    }
</script>

</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>