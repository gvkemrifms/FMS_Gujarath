<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Others.VehicleDecommissionApproval, App_Web_m0x5b0wx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validation(obj, Id) {
            var txtVehicleNumber = obj.id.replace(Id, "txtVehicleNumber");
            var txtApproveRejectedRemarks = obj.id.replace(Id, "txtApproveRejectedRemarks");
            var txtDecommisionDate = obj.id.replace(Id, "txtDecommisionDate");

            var VehicleNumber = document.getElementById(txtVehicleNumber);
            var ApproveRejectedRemarks = document.getElementById(txtApproveRejectedRemarks);
            var DecommisionDate = document.getElementById(txtDecommisionDate);

            if (trim(VehicleNumber.value) == '') {
                alert("Vehicle Number Cannot be Blank");
                VehicleNumber.focus();
                return false;
            }

            if (trim(ApproveRejectedRemarks.value) == '') {
                alert("Approve Rejected Remarks Cannot be Blank");
                ApproveRejectedRemarks.focus();
                return false;
            }
            if (Id != "btnReject") {

                if (trim(DecommisionDate.value) == '') {
                    alert("Decommision Date Cannot be Blank");
                    DecommisionDate.focus();
                    return false;
                }

                if (DecommisionDate.value != "") {
                    if (!isValidDate(DecommisionDate.value)) {
                        alert("Enter the Valid Date");
                        DecommisionDate.focus();
                        return false;
                    }
                }
            }
        }

        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
        }

        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function isDecimalNumberKey(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            //debugger;
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


        function alphanumeric_only_withspace(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32)) {
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


        function remark(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode != 34) && (keycode != 39)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }


    </script>

   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2" width="100%">
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
                        <asp:GridView ID="grdVehicleDecompositionApproval" runat="server" AutoGenerateColumns="False"
                            Width="630px" AllowPaging="True" OnRowCommand="grdVehicleDecompositionApproval_RowCommand"
                            CellPadding="4" ForeColor="#333333" GridLines="None" EmptyDataText="No Records Found"
                            CssClass="gridviewStyle">
                            <RowStyle CssClass="rowStyleGrid" />
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnVehicleNumber" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"VehicleProposalId") %>'
                                            CommandName="vehicleApproval"><%#DataBinder.Eval(Container.DataItem, "VehicleNumber")%></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Off Road Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOffRoadDateandDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"OffRoadDate") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Km Covered">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalKmCovered" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TotalDistanceTravelled") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Registration">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofRegistration" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DateOfRegistration") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Survey By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateofPurchase" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SurveyBy") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Survey Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSurveyorRemark" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SurveyRemark") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Proposed Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProposedRemarks" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ProposedRemark") %>'>&#39;&gt;</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--     <asp:TemplateField HeaderText="Creation Data">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCreationDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DateOfRegistration") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InActive Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInactiveDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"DateOfRegistration") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                            </Columns>
                            <FooterStyle CssClass="footerStylegrid" />
                            <PagerStyle CssClass="pagerStylegrid" />
                            <SelectedRowStyle CssClass="selectedRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlVehicleDecommissionApproval" runat="server">
                            <fieldset style="padding: 10px">
                                <table cellpadding="2" cellspacing="2" width="80%">
                                    <tr>
                                        <td class="tdlabel">Vehicle Number
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleNumber" runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Off Road Date and Time
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td nowrap="nowrap">
                                            <table>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <asp:TextBox ID="txtOffRoadDate" runat="server" Width="70px" onkeypress="return false;"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="imgOffRoadDate"
                                                            TargetControlID="txtOffRoadDate">
                                                        </cc1:CalendarExtender>
                                                        <asp:ImageButton ID="imgOffRoadDate" runat="server" ImageUrl="images/Calendar.gif" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlistTimeHour" runat="server" Visible="false">
                                                            <asp:ListItem Selected="True" Text="--hh--" Value="--hh--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlistTimeMinute" runat="server" Visible="false">
                                                            <asp:ListItem Selected="True" Text="--mm--" Value="--hh--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
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
                                            <asp:TextBox ID="txtDateOfRegistration" runat="server" onkeypress="return false;"></asp:TextBox>
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
                                        <td class="tdlabel">Date of Launching
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDateOfLaunching" runat="server" onkeypress="return false;"></asp:TextBox>
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
                                        <td class="tdlabel">Date of Purchase
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDateofPurchase" runat="server" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnDateofPurchase" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" PopupButtonID="imgBtnDateofPurchase"
                                                TargetControlID="txtDateofPurchase" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Survey Date
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtSurveyDate" runat="server" onkeypress="return false;"></asp:TextBox>
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
                                        <td class="tdlabel">Survey By
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtSurveyBy" runat="server" onkeypress="return alpha_only_withspace(event);"
                                                MaxLength="35"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Proposed Remarks
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtProposedRemarks" runat="server" TextMode="MultiLine" onkeypress="return alphanumeric_only_withspace(event);"
                                                MaxLength="200"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Approved/Rejected Remarks<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtApproveRejectedRemarks" runat="server" onkeypress="return alphanumeric_only_withspace(event);"
                                                MaxLength="200" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdlabel">Decommission Date<font color="red">*</font>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtDecommisionDate" runat="server" onkeypress="return false;"></asp:TextBox>
                                            <asp:ImageButton ID="imgBtnDecommisionDate" runat="server" ImageUrl="images/Calendar.gif" />
                                            <cc1:CalendarExtender ID="CalendarExtender6" runat="server" PopupButtonID="imgBtnDecommisionDate"
                                                TargetControlID="txtDecommisionDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnAccept" runat="server" Text="Accept" OnClick="btnAccept_Click" />
                                            <asp:Button ID="btnReject" runat="server" Text="Rejected" OnClick="btnReject_Click" />
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
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

