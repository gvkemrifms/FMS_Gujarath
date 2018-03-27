<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.BatteryDetails, App_Web_m0x5b0wx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolKit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">


        function OnlyAlphabets(myfield, e, dec) {
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

        function OnlyAlphaNumeric(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode == 32) || (keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

        function OnlyNumbers(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }

        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function isValidDate(subject) {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) {
                return true;
            } else {
                return false;
            }
        }

        function validationBatteryDetails() {
            if (document.getElementById("<%=txtBatteryItemCode.ClientID %>").value == 0) {
                       alert("Please Enter Battery Item Code");
                       document.getElementById("<%=txtBatteryItemCode.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtBatteryMake.ClientID %>").value == 0) {
                       alert("Please Enter Battery Make");
                       document.getElementById("<%=txtBatteryMake.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtBatteryModel.ClientID %>").value == 0) {
                       alert("Please Enter Battery Model");
                       document.getElementById("<%=txtBatteryModel.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtBatteryCapacity.ClientID %>").value == 0) {
                       alert("Please Enter Battery Capacity");
                       document.getElementById("<%=txtBatteryCapacity.ClientID %>").focus();
                    return false;
                }

                if (document.getElementById("<%=txtBatteryExpiryDate.ClientID %>").value == 0) {
                       alert("Please Enter Battery Expiry Date");
                       document.getElementById("<%=txtBatteryExpiryDate.ClientID %>").focus();
                    return false;
                }

                var DCDate = document.getElementById('<%=txtBatteryExpiryDate.ClientID %>');

                   if (trim(DCDate.value) != "") {
                       if (!isValidDate(DCDate.value)) {
                           alert("Enter the Valid Date");
                           DCDate.focus();
                           return false;
                       }
                   }

                   var now = new Date();
                   if (Date.parse(DCDate.value) <= Date.parse(now)) {
                       alert("Expiry Date should be greater than Current Date");
                       DCDate.focus();
                       return false;
                   }

               }


    </script>
    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="table1" cellspacing="0" cellpadding="0" width="500px" align="center" border="0"
                style="height: 37px">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td style="height: 200px">
                        <fieldset style="padding: 10px;">
                            <legend>Battery Details</legend>
                            <asp:Panel ID="pnlbatterydetails" runat="server">
                                <table id="table2" class="bordergreen" width="91%" align="center">
                                    <tr>
                                        <td>
                                            <table class="logtable" align="center">
                                                <tr>
                                                    <td style="width: 150px" align="left">Battery Item Code <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryItemCode" runat="server" CssClass="textbox180" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px" align="left">Make <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 23px">
                                                        <asp:TextBox ID="txtBatteryMake" runat="server" CssClass="textbox180" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px" align="left">Model <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryModel" runat="server" CssClass="textbox180" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px" align="left">Capacity <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryCapacity" runat="server" CssClass="textbox180" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td>Battery Expiry Date <span style="color: Red" class="labelErr">*</span></td>
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryExpiryDate" runat="server" onkeypress="return false" MaxLength="20" oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                                        <ajaxToolKit:CalendarExtender ID="ccl1" runat="server" TargetControlID="txtBatteryExpiryDate"
                                                            Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarInvoiceDate">
                                                        </ajaxToolKit:CalendarExtender>
                                                    </td>
                                                    <td nowrap="nowrap" style="width: 51px">
                                                        <asp:ImageButton ID="imgBtnCalendarInvoiceDate" runat="server" alt="" src="images/Calendar.gif"
                                                            Style="vertical-align: top" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="columnseparator">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 41px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnBatterySave" runat="server" CssClass="button"
                                                            OnClick="btnBatterySave_Click1"
                                                            OnClientClick="return validationBatteryDetails();" Text="Save" Width="55px" />
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnManufacturerReset" runat="server"
                                                            CausesValidation="false" CssClass="button" OnClick="btnManufacturerReset_Click"
                                                            Text="Reset" Width="55px" />
                                                        <input id="hidBatText" runat="server" type="hidden" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px;">
                            <asp:GridView ID="grvBatteryDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="3" CellSpacing="2" GridLines="None" CssClass="gridviewStyle" OnRowEditing="grvBatteryDetails_RowEditing"
                                PageSize="5" OnPageIndexChanging="grvBatteryDetails_PageIndexChanging">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblbatId" runat="server" Text='<%#Eval("Battery_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BatteryItemCode">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryItemCode" runat="server" Text='<%#Eval("Battery_Item_Code")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Make">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryMake" runat="server" Text='<%#Eval("Make")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Model">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryModel" runat="server" Text='<%#Eval("Model")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Capacity">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryCapacity" runat="server" Text='<%#Eval("CapaCity")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:TemplateField HeaderText="InActive Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInActiveDate" runat="server" Text='<%#Eval("InActive_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Creation_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ExpiryDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExpiryDate" runat="server" Text='<%#Eval("BatteryExpiryDate", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" CommandName="Edit" Text="Edit" />
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
            <br />
            <asp:HiddenField ID="hidManId" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

