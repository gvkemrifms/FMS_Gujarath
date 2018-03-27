<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Inventory.Tyres.TyreIssue, App_Web_fbb3hqmh" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">

        function CheckLength(text, long) {
            var maxlength = new Number(long); // Change number to your max length.
            if (text.value.length > maxlength) {
                text.value = text.value.substring(0, maxlength);

                alert(" Only " + long + " chars");

            }
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

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }



        function validation() {
            var tyreCost = document.getElementById('<%=txtTyreCost.ClientID %>');


       var DcNumPopup = document.getElementById('<%=txtDcNumberPopup.ClientID %>');
       var DcDate = document.getElementById('<%=txtDcDate.ClientID %>');
       var CourierName = document.getElementById('<%=txtCourierName.ClientID %>');
       var Remarks = document.getElementById('<%=txtRemarks.ClientID %>');

       if (!RequiredValidation(tyreCost, "Tyre Cost cannot be Blank"))
           return false;

       if (!RequiredValidation(DcNumPopup, "DC Number cannot be Blank"))
           return false;

       if (!RequiredValidation(DcDate, "DC Date cannot be Blank"))
           return false;


       if (trim(DcDate.value) != "") {
           if (!isValidDate(DcDate.value)) {
               alert("Enter the DC Date");
               DcDate.focus();
               return false;
           }
       }

       var now = new Date();
       if (Date.parse(DcDate.value) > Date.parse(now)) {
           alert("DC Date should not be greater than Current Date");
           DcDate.focus();
           return false;
       }

       if (!RequiredValidation(CourierName, "Courier Name cannot be Blank"))
           return false;

       if (!RequiredValidation(Remarks, "Remarks cannot be Blank"))
           return false;

   }

   function RequiredValidation(ctrl, msg) {
       if (trim(ctrl.value) == '') {
           alert(msg);
           ctrl.focus();
           return false;
       }
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




    </script>

    <script type="text/javascript">


        function ValidateIssueQty(IssQtyID, ReqQty) {
            var objIssQty = document.getElementById(IssQtyID);
            if (parseInt(objIssQty.value) > parseInt(ReqQty)) {
                alert("Issue Quantity Cannot be more than Request Quantity");
                objIssQty.focus();
                return false;
            }
        }
    </script>

  <%--  <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <fieldset style="padding: 10px">
                    <legend>Tyre Issue</legend>
                    <div id="Div2" runat="server" align="center">
                        Vehicle Number<span style="color: Red">*</span>

                        <ajaxToolkit:ComboBox AutoCompleteMode="Append" ID="ddlInventoryTyreIssueVehicles" runat="server" OnSelectedIndexChanged="ddlInventoryTyreIssueVehicles_SelectedIndexChanged"
                            AutoPostBack="True" DropDownStyle="DropDownList">
                        </ajaxToolkit:ComboBox>
                    </div>
                    <br />
                    <div id="Div5" runat="server">
                        Pending for Issue
                    </div>
                    <br />
                    <div id="Div6" runat="server" align="center">
                        <asp:GridView ID="grvTyrePendingForIssue" runat="server" GridLines="None" CssClass="gridviewStyle"
                            EmptyDataText="Details are not available" CellPadding="3" CellSpacing="2" AutoGenerateColumns="False"
                            AllowPaging="True" DataKeyNames="FleetInventoryReqID" PageSize="5" OnPageIndexChanging="grvTyrePendingForIssue_PageIndexChanging"
                            OnRowCommand="grvTyrePendingForIssue_RowCommand">
                            <Columns>
                                <%--<asp:BoundField HeaderText="S.No" DataField="FleetInventoryReqID" />--%>
                                <%--<asp:BoundField HeaderText="District" DataField="DistrictID" />--%>
                                <asp:BoundField HeaderText="Vehicle Number" DataField="VehicleNum" />
                                <asp:BoundField HeaderText="Request Date" DataField="RequestedDate" DataFormatString="{0:MM/dd/yyyy}" />
                                <asp:BoundField HeaderText="Request By" DataField="RequestedBy" />
                                <asp:BoundField HeaderText="No. of Tyres" DataField="RequestedQty" />
                                <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnViewDetails" runat="server" Text="Issue" ToolTip="Click here to Issue the details"
                                            OnClick="BtnViewDetails_Click" RowIndex='<%# Container.DisplayIndex %>' CommandName="Show"
                                            CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FleetInventoryReqID") %>' />
                                    </ItemTemplate>
                                    <ControlStyle Width="50px" />
                                    <HeaderStyle Width="60px" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="rowStyleGrid" />
                            <FooterStyle CssClass="footerStylegrid" />
                            <PagerStyle CssClass="pagerStylegrid" />
                            <SelectedRowStyle CssClass="selectedRowStyle" />
                            <HeaderStyle CssClass="headerStyle" />
                        </asp:GridView>
                    </div>
                    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                    <ajaxToolkit:ModalPopupExtender ID="gv_ModalPopupExtenderTyreIssue" BehaviorID="mdlPopup"
                        runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground" />
                    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPanel" Style="padding: 10px;">
                        <asp:UpdatePanel ID="updPnlReqDetail" runat="server">
                            <ContentTemplate>
                                <fieldset style="padding: 10px">
                                    <legend>Tyre Issue Detail</legend>
                                    <table class="style1" align="center">
                                        <tr>
                                            <td class="rowseparator"></td>
                                        </tr>
                                        <tr>
                                            <td align="left">Vehicle Number
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtTyreIssVehicleNumber" runat="server" ReadOnly="True" MaxLength="20"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">District
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtTyreIssDistrict" runat="server" ReadOnly="True" MaxLength="20"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator"></td>
                                        </tr>
                                        <tr>
                                            <td align="left">Total Tyre Cost
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtTyreCost" runat="server" MaxLength="6" Height="20px"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">DC Number
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDcNumberPopup" runat="server" MaxLength="5"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator"></td>
                                        </tr>
                                        <tr>
                                            <td align="left">DC Date
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDcDate" runat="server" MaxLength="20" onkeypress="return false"
                                                    oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDcDate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ImageButton1">
                                                </ajaxToolkit:CalendarExtender>
                                                <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif" Style="vertical-align: top" />
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">Courier Name
                                            </td>
                                            <td class="columnseparator"></td>
                                            <td align="left">
                                                <asp:TextBox ID="txtCourierName" runat="server" MaxLength="15"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">
                                                <asp:GridView ID="grvTyreIssueDetailsPopup" runat="server" AutoGenerateColumns="False"
                                                    GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" Width="95%"
                                                    OnRowDataBound="grvTyreIssueDetailsPopup_RowDataBound">
                                                    <Columns>
                                                        <%--<asp:BoundField DataField="FleetInventoryReqID" HeaderText="FleetInventoryReqID" />--%>
                                                        <asp:BoundField DataField="TyrePosition" HeaderText="Current Tyre Position" />
                                                        <asp:BoundField DataField="TyreNumber" HeaderText="Current Tyre Number" />
                                                        <asp:BoundField DataField="Make" HeaderText="Make" />
                                                        <asp:BoundField DataField="Model" HeaderText="Model" />
                                                        <asp:BoundField DataField="TotalKmTravelled" HeaderText="Current Total Travel ODO" />
                                                        <asp:TemplateField HeaderText="Tyre Number">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlTyreNumber" runat="server">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle CssClass="rowStyleGrid" />
                                                    <FooterStyle CssClass="footerStylegrid" />
                                                    <PagerStyle CssClass="pagerStylegrid" />
                                                    <SelectedRowStyle CssClass="selectedRowStyle" />
                                                    <HeaderStyle CssClass="headerStyle" />
                                                </asp:GridView>
                                                <div id="Div7" align="center" style="width: 95%; background-color: white">
                                                    Remarks<asp:TextBox ID="txtRemarks" runat="server" onkeypress="return OnlyAlphaNumeric(event)"
                                                        MaxLength="20" TextMode="MultiLine" onKeyUp="CheckLength(this,50)" onChange="CheckLength(this,50)"></asp:TextBox>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btnOk" runat="server" Text="Issue" Width="50px" OnClick="btnOk_Click" />
                                                    &nbsp;&nbsp;
                                                    <asp:Button ID="btnNo" runat="server" Text="Cancel" Width="50px" OnClick="btnNo_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </fieldset>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

