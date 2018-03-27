<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Others.HandOverToOwner, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript" language="javascript">
    
        function validation(obj, Id) {
         
            var txtVehicleNumber = obj.id.replace(Id, "txtVehicleNumber");
            var txtHandOverTo = obj.id.replace(Id, "txtHandOverTo");
            var txtHandOverDate = obj.id.replace(Id, "txtHandOverDate");
            var txtHandOverBy = obj.id.replace(Id, "txtHandOverBy");
            var txtOdoreading = obj.id.replace(Id, "txtOdoreading");

            var VehicleNumber = document.getElementById(txtVehicleNumber);
            var HandOverTo = document.getElementById(txtHandOverTo);
            var HandOverDate = document.getElementById(txtHandOverDate);
            var HandOverBy = document.getElementById(txtHandOverBy);
            var OdoReading = document.getElementById(txtOdoreading);


            if (trim(VehicleNumber.value) == '') {
                alert("VehicleNumber To Cannot be Blank");
                VehicleNumber.focus();
                return false;
            }

            if (trim(HandOverTo.value) == '') {
                alert("Hand Over To Cannot be Blank");
                HandOverTo.focus();
                return false;
            }

            if (trim(HandOverDate.value) == '') {
                alert("Hand Over Date Cannot be Blank");
                HandOverDate.focus();
                return false;
            }

            if (HandOverDate.value != "") {
                if (!isValidDate(HandOverDate.value)) {
                    alert("Enter the Valid Date");
                    HandOverDate.focus();
                    return false;
                }
            }
            
            var now = new Date();
            
            if(Date.parse(HandOverDate.value) > Date.parse(now))
            {
                alert("HandOver Date should not be greater than Current Date");
                HandOverDate.focus();
                return false;
            }

            if (trim(HandOverBy.value) == '') {
                alert("Hand Over By Cannot be Blank");
                HandOverBy.focus();
                return false;
            }

            if (trim(OdoReading.value) == '') {
                alert("Odo Reading Cannot be Blank");
                OdoReading.focus();
                return false;
            }

            return true;
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

        function checkEnter(e) {

            var characterCode

            if (e && e.which) {
                e = e
                characterCode = e.which
            }
            else {
                e = event
                characterCode = e.keyCode
            }

            if (characterCode == 13) {
                document.getElementById('btnget').click();
                return false
            }
            else {
                return true
            }
        }
        
        function alpha_only_withspace(e) 
            {
            var keycode; 
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode; 
            else if (e) keycode = e.which;
            else return true;if((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)|| (keycode == 32)) 
            {
                return true; 
            }
            else
            {
                return false; 
            }
            return true; 
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
       
    </script>

    <%--<asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>--%>
    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td class="heading">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlgrdTemporaryVehicle" runat="server">
                            <fieldset style="padding: 10px">
                                <legend>Temporary Vehicle </legend>
                                <asp:GridView ID="grdTemporaryVehicle" runat="server" AutoGenerateColumns="False"
                                    CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="grdTemporaryVehicle_RowCommand"
                                    Width="238px" EmptyDataText="No Records Found" CssClass="gridviewStyle">
                                    <RowStyle CssClass="rowStyleGrid" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Vehicle Number">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkBtnVehicleNumber" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "VehicleID")%>'
                                                    CommandName="vehicleAccidentedit"><%#DataBinder.Eval(Container.DataItem, "VehicleNumber")%></asp:LinkButton>
                                                <asp:LinkButton ID="hdnLnkShowModal" runat="server" Style="display: none;"></asp:LinkButton>
                                                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="hdnLnkShowModal"
                                                    PopupControlID="Panel1" OkControlID="btnClose" CancelControlID="btnReset" BackgroundCssClass="modalBackground">
                                                </cc1:ModalPopupExtender>
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
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <asp:Panel ID="Panel1" runat="server" Style="display: none; padding: 10px" CssClass="modalPanel">
                            <table cellpadding="2" cellspacing="2" width="100%">
                                <tr>
                                    <td class="tdlabel">
                                        Vehicle Number
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVehicleNumber" runat="server" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdlabel">
                                        Hand Over To<font color="red">*</font>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHandOverTo" runat="server" onkeypress="return alpha_only_withspace(event);" MaxLength="35"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdlabel">
                                        Hand Over Date<font color="red">*</font>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHandOverDate" runat="server" onkeypress="return false;"></asp:TextBox>
                                        <asp:ImageButton ID="imgBtnHandOverDate" runat="server" ImageUrl="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="MM/dd/yyyy" PopupButtonID="imgBtnHandOverDate"
                                            TargetControlID="txtHandOverDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdlabel">
                                        Hand Over By<font color="red">*</font>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHandOverBy" runat="server" onkeypress="return alpha_only_withspace(event);" MaxLength="35"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdlabel">
                                        Odo Reading<font color="red">*</font>
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOdoreading" runat="server" onkeypress="return isDecimalNumberKey(event);" MaxLength="10"></asp:TextBox>
                                    </td>
                                </tr> 
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnClose" runat="server" Text="Save" Style="display: none;" />
                                        <asp:Button ID="btnReset" runat="server" Text="Cancel" OnClick="btnReset_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Hand Over to Owner</legend>
                            <asp:GridView ID="grdVehicleDecompositionApproval" runat="server" AutoGenerateColumns="False"
                                Width="630px" OnRowCommand="grdVehicleDecompositionApproval_RowCommand" AllowPaging="True"
                                OnPageIndexChanging="grdVehicleDecompositionApproval_PageIndexChanging" CellPadding="4"
                                ForeColor="#333333" GridLines="None" EmptyDataText="No Records Found" CssClass="gridviewStyle">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Vehicle Number">
                                        <ItemTemplate>
                                            <%#DataBinder.Eval(Container.DataItem, "VehicleNumber")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Recieved From">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRecievedFrom" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "HandOverBy")%>'></asp:Label>
                                            <%--                                        <asp:Label ID="lblvehicleID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber")%>'
                                            Visible="true"></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Recieved Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRecievedDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ReceivedDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Recieved Odo Reading">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRecievedOdoReading" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OdoReading")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid" />
                                <PagerStyle CssClass="pagerStylegrid" />
                                <SelectedRowStyle CssClass="selectedRowStyle" />
                                <HeaderStyle CssClass="headerStyle" />
                            </asp:GridView>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

