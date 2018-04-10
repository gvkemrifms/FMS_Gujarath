﻿<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleDecommissionProposal.aspx.cs" Inherits="VehicleDecommissionProposal" %>

<%@ Import Namespace="System.ComponentModel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validation(obj, id) {

            var now = new Date();
            var txtVehicleNumber = obj.id.replace(id, "txtVehicleNumber");
            var txtDateOfRegistration = obj.id.replace(id, "txtDateOfRegistration");
            var txtDateOfPurchase = obj.id.replace(id, "txtDateOfPurchase");
            var txtDateOfLaunching = obj.id.replace(id, "txtDateOfLaunching");
            var txtSurveyDate = obj.id.replace(id, "txtSurveyDate");
            var txtSurveyBy = obj.id.replace(id, "txtSurveyBy");
            var txtSurveyRemarks = obj.id.replace(id, "txtSurveyRemarks");
            var txtProposedRemarks = obj.id.replace(id, "txtProposedRemarks");
            var txtTotalMaintenanceExpenses = obj.id.replace(id, "txtTotalMaintenanceExpenses");
            var txtNumberofAccidents = obj.id.replace(id, "txtNumberofAccidents");
            var vehicleNumber = document.getElementById(txtVehicleNumber);
            var dateOfRegistration = document.getElementById(txtDateOfRegistration);
            var dateOfPurchase = document.getElementById(txtDateOfPurchase);
            var dateOfLaunching = document.getElementById(txtDateOfLaunching);
            var surveyDate = document.getElementById(txtSurveyDate);
            var surveyBy = document.getElementById(txtSurveyBy);
            var surveyRemarks = document.getElementById(txtSurveyRemarks);
            var proposedRemarks = document.getElementById(txtProposedRemarks);
            var totalMaintenanceExpenses = document.getElementById(txtTotalMaintenanceExpenses);
            var numberofAccidents = document.getElementById(txtNumberofAccidents);

            switch (trim(vehicleNumber.value)) {
                case '':
                    alert("Vehicle Number Cannot be Blank");
                    vehicleNumber.focus();
                    return false;
            }


            if (Date.parse(dateOfRegistration.value) > Date.parse(now)) {
                alert("Date Of Registration should not be greater than Current Date");
                dateOfRegistration.focus();
                return false;
            }

            if (Date.parse(dateOfPurchase.value) > Date.parse(now)) {
                alert("Date Of Purchase should not be greater than Current Date");
                dateOfPurchase.focus();
                return false;
            }

            if (Date.parse(dateOfLaunching.value) > Date.parse(now)) {
                alert("Date Of Launching should not be greater than Current Date");
                dateOfLaunching.focus();
                return false;
            }


            switch (trim(surveyDate.value)) {
                case '':
                    alert("Survey Date Cannot be Blank");
                    surveyDate.focus();
                    return false;
            }

            switch (surveyDate.value) {
                case "":
                    break;
                default:
                    if (!isValidDate(surveyDate.value)) {
                        alert("Enter the valid SurveyDate");
                        surveyDate.focus();
                        return false;
                    }
                    break;
            }

            if (Date.parse(surveyDate.value) > Date.parse(now)) {
                alert("Survey Date should not be greater than Current Date");
                surveyDate.focus();
                return false;
            }


            switch (trim(surveyBy.value)) {
                case '':
                    alert("Survey By  Cannot be Blank");
                    surveyBy.focus();
                    return false;
            }

            switch (trim(surveyRemarks.value)) {
                case '':
                    alert("Survey Remarks Cannot be Blank");
                    surveyRemarks.focus();
                    return false;
            }

            switch (trim(proposedRemarks.value)) {
                case '':
                    alert("Proposed Remarks Cannot be Blank");
                    proposedRemarks.focus();
                    return false;
            }

            switch (trim(totalMaintenanceExpenses.value)) {
                case '':
                    alert("Total Maintenance Expenses Cannot be Blank");
                    totalMaintenanceExpenses.focus();
                    return false;
            }

            switch (trim(numberofAccidents.value)) {
                case '':
                    alert("Number of Accidents Cannot be Blank");
                    numberofAccidents.focus();
                    return false;
            }
            return true;
        }

        function isValidDate(subject) {
            return !!subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/);
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

        function numericOnly(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode === 190 || charCode > 31 && (charCode < 48 || charCode > 57)) {
                var txtBox = document.getElementById(event.srcElement.id);
                return txtBox.value.indexOf('.') === -1;
            } else return true;
        }

        function alphanumeric_only(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 48 && keycode <= 57) ||
                (keycode >= 65 && keycode <= 90) ||
                (keycode >= 97 && keycode <= 122);
        }

        function alphanumeric_only_withspace(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 48 && keycode <= 57) ||
                (keycode >= 65 && keycode <= 90) ||
                (keycode >= 97 && keycode <= 122) ||
                (keycode === 32);
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


        function remark(e) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode !== 34) && (keycode !== 39);
        }

    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlgrdViewVehicleDecommisionProposal" runat="server">
                            <fieldset style="padding: 10px;">
                                <asp:GridView ID="grdViewVehicleDecommisionProposal" runat="server" AutoGenerateColumns="False"
                                    OnRowCommand="grdViewVehicleDecommisionProposal_RowCommand"
                                    CellPadding="4" ForeColor="#333333"
                                    Width="630px" EmptyDataText="No Records Found" CssClass="gridviewStyle"
                                    OnPageIndexChanging="grdViewVehicleDecommisionProposal_PageIndexChanging"
                                    PageSize="20" AllowPaging="True">
                                    <RowStyle CssClass="rowStyleGrid" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Vehicle Number">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkBtnVehicleNumber" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "vi_LocationId") %>'
                                                    CommandName="vehicleProposal">
                                    <%#DataBinder.Eval(Container.DataItem, "vi_VehicleNumber") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Total Km Covered">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalKmCovered" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TotalKmCovered") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date of Registration">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateofRegistration" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RegDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date of Purchase">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PurchaseDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="footerStylegrid" />
                                    <PagerStyle CssClass="pagerStylegrid" />
                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                    <HeaderStyle CssClass="headerStyle" />
                                </asp:GridView>
                            </fieldset>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlVehicleDecommissionProposal" runat="server">
                            <fieldset style="padding: 10px;">
                                <table>
                                    <tr>
                                        <td class="tdlabel">Vehicle Number
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleNumber" runat="server" Width="200" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>

                                    <tr>
                                        <td class="tdlabel">Total Km Covered
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTotalKmCovered" runat="server" Width="200px"
                                                onkeypress="return numericOnly(event);" MaxLength="10">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Date of Registration
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDateOfRegistration" runat="server" Width="200" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnDateOfRegistration" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" PopupButtonID="imgBtnDateOfRegistration"
                                                TargetControlID="txtDateOfRegistration" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Date of Purchase
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDateOfPurchase" runat="server" Width="200" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnDateOfPurchase" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" PopupButtonID="imgBtnDateOfPurchase"
                                                TargetControlID="txtDateOfPurchase" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Date of Launching
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDateOfLaunching" runat="server" Width="200" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnDateOfLaunching" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" PopupButtonID="imgBtnDateOfLaunching"
                                                TargetControlID="txtDateOfLaunching" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Survey Date<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtSurveyDate" runat="server" Width="200" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnSurveyDate" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender5" runat="server" PopupButtonID="imgBtnSurveyDate"
                                                TargetControlID="txtSurveyDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Survey By<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtSurveyBy" runat="server" Width="200"
                                                onkeypress="return alpha_only_withspace(event);" MaxLength="35">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Survey Remarks<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtSurveyRemarks" runat="server" TextMode="MultiLine"
                                                Width="200" onkeypress="return alphanumeric_only_withspace(event);" MaxLength="200">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Proposed Remarks<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtProposedRemarks" runat="server" TextMode="MultiLine"
                                                Width="200" onkeypress="return alphanumeric_only_withspace(event);" MaxLength="200">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Total Maintenance Expenses<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTotalMaintenanceExpenses" runat="server"
                                                onkeypress="return isDecimalNumberKey(event);" MaxLength="6">
                                            </asp:TextBox>
                                            <asp:LinkButton ID="lnkBtnTotalMaintenanceExpenses" runat="server" Visible="false">
                                View
                                History
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Number of Accidents<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtNumberofAccidents" runat="server"
                                                onkeypress="return numericOnly(event);" MaxLength="5">
                                            </asp:TextBox>
                                            <asp:LinkButton ID="lnkBtnNumberofAccidents" runat="server" Visible="false">
                                View
                                History
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="grdViewVehicleDecomissionApproval" runat="server" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" EmptyDataText="No Records Found"
                            CssClass="gridviewStyle">
                            <RowStyle CssClass="rowStyleGrid" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No">
                                    <ItemTemplate>
                                        <%# ((GridViewRow) Container).RowIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Survey Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SurveyDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Survey By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SurveyBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Survey Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SurveyRemark") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Proposed Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ProposedRemark") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "StatusDesc") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnEdit" runat="server" Text="Edit" CommandArgument='<% DataBinder.Eval(Container.Dataitem, "VehicleProposalId") %>'
                                            CommandName="vehicleAccidentedit" Visible="false">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnDelete" runat="server" Text="Delete" CommandArgument='<% DataBinder.Eval(Container.Dataitem, "") %>'
                                            CommandName="vehicleAccidentDelete" Visible="false">
                                        </asp:LinkButton>
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
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

