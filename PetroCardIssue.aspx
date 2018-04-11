<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="PetroCardIssue.aspx.cs" Inherits="PetroCardIssue" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script src="js/Validation.js"></script>
<script language="javascript" type="text/javascript">

    function isMandatory() {

        switch (document.getElementById("<%= txtPetroCardNumber.ClientID %>").value) {
        case 0:
            alert("Please enter PetroCardNumber");
            document.getElementById("<%= txtPetroCardNumber.ClientID %>").focus();
            return false;
        }

        var agency = document.getElementById('<%= ddlAgency.ClientID %>');
        switch (agency.selectedIndex) {
        case 0:
            alert("Please select the Agency");
            agency.focus();
            return false;
        }

        var cardType = document.getElementById('<%= ddlCardType.ClientID %>');
        switch (cardType.selectedIndex) {
        case 0:
            alert("Please select the CardType");
            cardType.focus();
            return false;
        }


        switch (document.getElementById("<%= txtValidityEndDate.ClientID %>").value) {
        case 0:
            alert("Please Select ValidityEndDate");
            document.getElementById("<%= txtValidityEndDate.ClientID %>").focus();
            return false;
        }
        switch (document.getElementById("<%= txtIssuedDate.ClientID %>").value) {
        case 0:
            alert("Please Select IssuedDate");
            document.getElementById("<%= txtIssuedDate.ClientID %>").focus();
            return false;
        }
        var listFe = document.getElementById('<%= dd_listFe.ClientID %>');
        switch (listFe.selectedIndex) {
        case 0:
            alert("Please select the FE");
            listFe.focus();
            return false;
        }


        var validityEndDate = document.getElementById('<%= txtValidityEndDate.ClientID %>');

        var issuedDate = document.getElementById('<%= txtIssuedDate.ClientID %>');

        if (trim(validityEndDate.value) !== "" && !isValidDate(validityEndDate.value)) {
            alert("Enter the Valid Date");
            validityEndDate.focus();
            return false;
        }


        if (trim(issuedDate.value) !== "" && !isValidDate(issuedDate.value)) {
            alert("Enter the Valid Date");
            issuedDate.focus();
            return false;
        }
        var now = new Date();
        if (Date.parse(validityEndDate.value) < Date.parse(now)) {
            alert("ValidityEndDate should be greater than Current Date");
            validityEndDate.focus();
            return false;
        }

        now = new Date();
        if (Date.parse(issuedDate.value) > Date.parse(now)) {
            alert("Issued Date should not be greater than Current Date");
            issuedDate.focus();
            return false;
        }

        var id = document.getElementById('<%= ddlVehicles.ClientID %>');

        var inputs = id.getElementsByTagName('input');
        var i;
        for (i = 0; i < inputs.length; i++) {
            if (inputs[i].type !== 'text')
                continue;
            if (inputs[i].value !== "" && inputs[i].value != null && inputs[i].value === "--Select--") {
                alert('Select the Vehicle');
                return false;
            }

            break;
        }


        return true;
    }


</script>
<asp:UpdatePanel ID="UpdPanel1" runat="server">
<ContentTemplate>
    <table>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="padding: 10px">
                    <legend>Petro Card Issue</legend>
                    <table align="center">
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="height: 19px; width: 121px;">
                            </td>
                            <td style="height: 19px; width: 101px;">
                                <asp:DropDownList ID="ddlDistricts" runat="server" Width="153px" AutoPostBack="True"
                                                  Visible="false" OnSelectedIndexChanged="ddlDistricts_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td style="height: 19px; width: 135px;">
                                <asp:TextBox ID="txtEdit" runat="server" Visible="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="height: 19px; width: 121px;">
                                PetroCardNumber<span style="color: Red">*</span>
                            </td>
                            <td style="height: 19px; width: 101px;">
                                <asp:TextBox ID="txtPetroCardNumber" runat="server" MaxLength="16"></asp:TextBox>
                            </td>
                            <td style="height: 19px; width: 135px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 121px">
                                Agency<span style="color: Red">*</span>
                            </td>
                            <td style="width: 101px">
                                <asp:DropDownList ID="ddlAgency" runat="server" Width="153px" AutoPostBack="True"
                                                  OnSelectedIndexChanged="ddlAgency_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 135px">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 121px">
                                Card Type<span style="color: Red">*</span>
                            </td>
                            <td style="width: 101px">
                                <asp:DropDownList ID="ddlCardType" runat="server" Width="153px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 135px">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 121px">
                                ValidityEndDate<span style="color: Red">*</span>
                            </td>
                            <td style="width: 101px">
                                <asp:TextBox ID="txtValidityEndDate" runat="server" oncut="return false;" onpaste="return false;"
                                             oncopy="return false;" onkeypress="return false">
                                </asp:TextBox>
                                <cc1:CalendarExtender ID="calValEndDate" runat="server" TargetControlID="txtValidityEndDate"
                                                      Format="dd/MM/yyyy" PopupButtonID="imgBtnCalendarInvoiceDate">
                                </cc1:CalendarExtender>
                            </td>
                            <td nowrap="nowrap" style="width: 51px">
                                <asp:ImageButton ID="imgBtnCalendarInvoiceDate" runat="server" alt="" src="images/Calendar.gif"
                                                 Style="vertical-align: top"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 121px">
                                Issued To FE<span style="color: Red">*</span>
                            </td>
                            <td style="width: 101px">
                                <asp:DropDownList ID="dd_listFe" runat="server" AutoPostBack="True"
                                                  onselectedindexchanged="dd_listFe_SelectedIndexChanged">
                                </asp:DropDownList>

                            </td>
                            <td style="width: 135px">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="height: 19px; width: 121px;">
                                Issued Date<span style="color: Red">*</span>
                            </td>
                            <td style="height: 19px; width: 101px;">
                                <asp:TextBox ID="txtIssuedDate" runat="server" MaxLength="15" onkeypress="return false"
                                             oncut="return false;" onpaste="return false;" oncopy="return false;">
                                </asp:TextBox>
                                <cc1:CalendarExtender ID="calIssuedDate" runat="server" TargetControlID="txtIssuedDate"
                                                      Format="dd/MM/yyyy" PopupButtonID="ImageButton1">
                                </cc1:CalendarExtender>
                            </td>
                            <td nowrap="nowrap" style="width: 51px">
                                <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                                                 Style="vertical-align: top"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 19px; text-align: left; width: 121px;">
                                Issued To Vehicle<span style="color: Red">*</span>
                            </td>
                            <td style="height: 19px; width: 101px;">
                                <cc1:ComboBox AutoCompleteMode="Append" DropDownStyle="DropDownList" ID="ddlVehicles" runat="server" AutoPostBack="True"
                                              Enabled="False">
                                </cc1:ComboBox>


                            </td>
                            <td style="height: 19px; width: 135px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 19px; text-align: left; width: 121px;">
                                Issued To District<span style="color: Red">*</span>
                            </td>
                            <td style="height: 19px; width: 101px;">
                                <asp:DropDownList ID="ddlFeuserDistrict" runat="server" AutoPostBack="True"
                                                  Enabled="False">
                                </asp:DropDownList>
                            </td>
                            <td style="height: 19px; width: 135px;">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 19px; width: 121px;">
                            <asp:Button ID="btSave" runat="server" Text="Save" OnClick="btSave_Click"/>
                            <td style="height: 19px; width: 135px;" align="center">
                                <asp:Button ID="btReset" runat="server" Text="Reset" OnClick="btReset_Click"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="padding: 10px">
                    <table style="height: 99px; width: 102px;" align="center">
                        <tr>
                            <td style="height: 99px; width: 102px;">
                                <asp:GridView ID="gvPetroCardIssue" runat="server" Width="102px" AllowPaging="True"
                                              OnPageIndexChanging="gvPetroCardIssue_PageIndexChanging" PageSize="5" CellPadding="3"
                                              CellSpacing="2" GridLines="None" CssClass="gridviewStyle" HorizontalAlign="Justify"
                                              OnRowEditing="gvPetroCardIssue_RowEditing" OnRowDeleting="gvPetroCardIssue_RowDeleting"
                                              AutoGenerateColumns="False" OnRowCommand="gvPetroCardIssue_RowCommand" EmptyDataText="No Records Found">
                                    <RowStyle CssClass="rowStyleGrid"/>
                                    <Columns>
                                        <asp:BoundField HeaderText="District" DataField="District"/>
                                        <asp:BoundField HeaderText="Card" DataField="CardNum"/>
                                        <asp:BoundField HeaderText="Vehicle" DataField="Vehicle"/>
                                        <asp:BoundField HeaderText="CardType" DataField="CardType"/>
                                        <asp:BoundField HeaderText="Validity" DataField="Validity"/>
                                        <asp:BoundField HeaderText="IssuedFE" DataField="IssueToFE"/>
                                        <asp:BoundField HeaderText="Date" DataField="IssuedDate"/>
                                        <asp:BoundField HeaderText="IssuedDistrict" DataField="IssuedToDistrict"/>
                                        <asp:BoundField HeaderText="IssuedVehicle" DataField="IssuedToVehicle"/>
                                        <asp:TemplateField HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "IssueID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deactivate">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnDeactivate" runat="server" Text="Deactivate" CommandName="Delete"
                                                                CommandArgument='<%#DataBinder.Eval(Container.DataItem, "IssueID") %>'>
                                                </asp:LinkButton>
                                                <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnDeactivate"
                                                                           ConfirmText="Are you sure you want to Deactivate?">
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
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>