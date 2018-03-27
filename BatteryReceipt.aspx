<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Inventory.Battery.BatteryReceipt, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type="text/javascript">
     function CheckLength(text,long) 
{
	var maxlength = new Number(long); // Change number to your max length.
	if (text.value.length > maxlength)
       {
		text.value = text.value.substring(0,maxlength);

		alert(" Only " + long + " chars");

	}
}
    function remark(e) 
             {
                var keycode; 
                if (window.event) keycode = window.event.keyCode;
                else if (event) keycode = event.keyCode; 
                else if (e) keycode = e.which;
                else return true;if((keycode != 34) && (keycode != 39) ) 
                {
                    return true; 
                }
                else
                {
                    return false; 
                }
                 return true; 
            }
    
            function isNumberKey(evt)
              {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                else
                    return true;
                }
    
   function validation() {
            var RecInvoiceNo = document.getElementById('<%=txtBatRecInvoiceNo.ClientID %>');
            var RecInvoiceDate = document.getElementById('<%=txtBatRecInvoiceDate.ClientID %>');
            var RecDate = document.getElementById('<%=txtBatRecDate.ClientID %>');
            var Remarks = document.getElementById('<%=txtRemarks.ClientID %>');
            var PODate = document.getElementById('<%=txtBatRecPODate.ClientID %>');
          
            if (!RequiredValidation(RecInvoiceNo, "Invoice Number cannot be Blank"))
                return false;

              if (!RequiredValidation(RecInvoiceDate, "Invoice Date cannot be Blank"))
                return false;
                


            if (trim(RecInvoiceDate.value) != "") {
                if (!isValidDate(RecInvoiceDate.value)) {
                    alert("Enter the Invoice Date");
                    RecInvoiceDate.focus();
                    return false;
                }
            }
            
            if(Date.parse(RecInvoiceDate.value) < Date.parse(PODate.value))
            {
                alert("Invoice Date should be greater than PODate Date");
                RecInvoiceDate.focus();
                return false;
            }
            
            
            var now = new Date();
            if(Date.parse(RecInvoiceDate.value) > Date.parse(now))
            {
                alert("Invoice Date should not be greater than Current Date");
                RecInvoiceDate.focus();
                return false;
            }
            
            
            if(Date.parse(RecDate.value) < Date.parse(RecInvoiceDate.value))
            {
                alert("Receipt Date should be greater than Invoice Date");
                RecDate.focus();
                return false;
            }
            
            
             if (!RequiredValidation(RecDate, "Receipt Date cannot be Blank"))
                return false;


            if (trim(RecDate.value) != "") {
                if (!isValidDate(RecDate.value)) {
                    alert("Enter the Receipt Date");
                    RecDate.focus();
                    return false;
                }
            }
            
            var now = new Date();
            if(Date.parse(RecDate.value) > Date.parse(now))
            {
                alert("Battery Receipt Date should not be greater than Current Date");
                RecDate.focus();
                return false;
            }
            
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

  <%--  <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Battery Receipt</legend>
                <div id="Div2" runat="server" align="center">
                    Vehicle Number<span style="color: Red">*</span>
                    <ajaxToolkit:ComboBox AutoCompleteMode="Append" ID="ddlInventoryBatteryReceiptVehicles" runat="server" AutoPostBack="True" DropDownStyle="DropDownList"
                        OnSelectedIndexChanged="ddlInventoryBatteryReceiptVehicles_SelectedIndexChanged">
                    </ajaxToolkit:ComboBox>
                </div>
                <br />
                <div id="Div5" runat="server">
                    Battery Details
                </div>
                <br />
                <div id="Div6" runat="server" align="center">
                    <table>
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grvBatteryDetailsForReceipt" runat="server" CellPadding="3" CellSpacing="2"
                                    EmptyDataText="Details are not available" GridLines="None" CssClass="gridviewStyle"
                                    AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="FleetInventoryReqID"
                                    PageSize="5" OnPageIndexChanging="grvBatteryDetailsForReceipt_PageIndexChanging"
                                    OnRowCommand="grvBatteryDetailsForReceipt_RowCommand">
                                    <Columns>
                                        <%-- <asp:BoundField HeaderText="Item Issue ID" DataField="InventoryItemIssueID" />--%>
                                        <%-- <asp:BoundField HeaderText="Requisition ID" DataField="FleetInventoryReqID" />--%>
                                        <asp:BoundField HeaderText="Vehicle Number" DataField="VehicleNum" />
                                        <asp:BoundField HeaderText="District" DataField="ds_lname" />
                                        <asp:BoundField HeaderText="No. of Batteries" DataField="RequestedQty" />
                                        <asp:BoundField HeaderText="Request Date" DataField="RequestedDate" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField HeaderText="Issued Quantity" DataField="IssuedQty" />
                                        <asp:BoundField HeaderText="Issued Date" DataField="IssueDate" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnViewDetails" runat="server" Text="Receipt" ToolTip="Click here to Receipt the details"
                                                    OnClick="BtnViewDetails_Click" CssClass="button2" RowIndex='<%# Container.DisplayIndex %>'
                                                    CommandName="Show" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"InventoryItemIssueID") %>' />
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
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator">
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                <ajaxToolkit:ModalPopupExtender ID="gv_ModalPopupExtenderBatteryReceipt" BehaviorID="mdlPopup"
                    runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground" />
                <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPanel" Style="padding: 10px;
                    display: none;">
                    <fieldset>
                        <legend>Battery Receipt Details</legend>
                        <table class="style1" align="center">
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Vehicle Number
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecVehicleNo" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    District
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecDistrict" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    PO Number
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecPONumber" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    PO Date
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecPODate" runat="server" ReadOnly="True" oncut="return false;"
                                        onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Courier Name
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecCourierName" runat="server" ReadOnly="True" MaxLength="20"></asp:TextBox>
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    HO Remarks
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecHORemarks" runat="server" ReadOnly="True" MaxLength="20"
                                        TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Invoice No
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecInvoiceNo" runat="server" MaxLength="5"></asp:TextBox>
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    Invoice Date
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtBatRecInvoiceDate" runat="server" MaxLength="20" onkeypress="return false" oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtBatRecInvoiceDate"
                                        Format="MM/dd/yyyy" PopupButtonID="ImageButton1">
                                    </ajaxToolkit:CalendarExtender><asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif" Style="vertical-align: top" />
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Receipt Date
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td align="left" colspan="3">
                                    <asp:TextBox ID="txtBatRecDate" runat="server" MaxLength="20" onkeypress="return false" oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtBatRecDate"
                                        Format="MM/dd/yyyy" PopupButtonID="ImageButton2">
                                    </ajaxToolkit:CalendarExtender><asp:ImageButton ID="ImageButton2" runat="server" alt="" src="images/Calendar.gif" Style="vertical-align: top" />
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:GridView ID="grvBatteryReceiptDetailsPopup" runat="server" AutoGenerateColumns="False"
                                        GridLines="None" CssClass="gridviewStyle" CellPadding="3" CellSpacing="2" BackColor="#DEBA84"
                                        Width="95%" OnRowDataBound="grvBatteryReceiptDetailsPopup_RowDataBound">
                                        <Columns>
                                            <%--<asp:BoundField HeaderText="Item Issue Id" DataField="InventoryItemIssueID" />
                                            <asp:BoundField HeaderText="Requisition ID" DataField="FleetInventoryReqID" />
                                            <asp:BoundField HeaderText="Battery Issue DetID" DataField="BatteryIssueDetailsID" />--%>
                                            <asp:BoundField HeaderText="Battery Number" DataField="BatteryNumber" />
                                            <asp:BoundField HeaderText="Make" DataField="Make" />
                                            <asp:BoundField HeaderText="Model" DataField="Model" />
                                            <asp:BoundField HeaderText="Capacity" DataField="Capacity" />
                                            <asp:TemplateField HeaderText="ReceivedQty">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtBatteryReceivedQty" runat="server" Text="1"></asp:Label>
                                                    <asp:Label ID="LbIssueID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"InventoryItemIssueID") %>'
                                                        Visible="false"></asp:Label>
                                                    <asp:Label ID="LbReqID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FleetInventoryReqID") %>'
                                                        Visible="false"></asp:Label>
                                                    <asp:Label ID="LbBatteryID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"BatteryIssueDetailsID") %>'
                                                        Visible="false"></asp:Label>
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
                                        Remarks<asp:TextBox ID="txtRemarks" runat="server" onKeyUp="CheckLength(this,50)"
                                            onChange="CheckLength(this,50)"></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnOk" runat="server" Text="Issue" Width="50px" OnClick="btnOk_Click" />
                                        &nbsp;&nbsp;
                                        <asp:Button ID="btnNo" runat="server" Text="Cancel" Width="50px" OnClick="btnNo_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

