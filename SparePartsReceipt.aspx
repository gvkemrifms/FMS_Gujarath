<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.SparePartsReceipt, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolKit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
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
            var VehicleID = document.getElementById('<%= ddlVehicles.ClientID %>');
            
            var ReceiptDate = document.getElementById('<%= txtReceiptDate.ClientID %>');
            
            var ReceiptRemarks = document.getElementById('<%= txtReceiptRemarks.ClientID %>');
            
            var InvoiceNo = document.getElementById('<%= txtInvoiceNo.ClientID %>');
            
            var InvoiceDate = document.getElementById('<%= txtInvoiceDate.ClientID %>');
            
            var DCDate = document.getElementById('<%= txtDCDate.ClientID %>');
            
            var txtReceivedQuantity = document.getElementById(ReceivedQuantity);
            
                    if (VehicleID.selectedIndex == 0) {
                alert("Please select Vehicle");
                VehicleID.focus();
                return false;
            }


            if (!RequiredValidation(ReceiptDate, "ReceiptDate cannot be Blank"))
                return false;
                
            if (!RequiredValidation(ReceiptRemarks,"ReceiptRemarks cannot be blank"))
                return false; 
                
            if (!RequiredValidation(InvoiceNo,"InvoiceNo cannot be blank"))
                return false; 
               
            if (!RequiredValidation(InvoiceDate,"InvoiceDate cannot be blank"))
                return false;
                
           if (!RequiredValidation(txtReceivedQuantity,"ReceivedQuantity cannot be blank"))
                return false;                


            if (trim(ReceiptDate.value) != "") 
            {
                if (!isValidDate(ReceiptDate.value)) 
                
                {
                    alert("Enter the Valid Date");
                    ReceiptDate.focus();
                    return false;
                }
            }
            
            var now = new Date();
            if(Date.parse(ReceiptDate.value) > Date.parse(now))
            {
                alert("Receipt Date should not be greater than Current Date");
                ReceiptDate.focus();
                return false;
            }
            
            if(Date.parse(ReceiptDate.value) < Date.parse(InvoiceDate.value))
            {
                alert("Receipt Date should be greater than Invoice Date");
                ReceiptDate.focus();
                return false;
            }
            
            if(Date.parse(DCDate.value) > Date.parse(InvoiceDate.value))
            {
                alert("Invoice Date should be greater than DC Date");
                InvoiceDate.focus();
                return false;
            }
            
            if (trim(InvoiceDate.value) != "") {
                if (!isValidDate(InvoiceDate.value)) {
                    alert("Enter the Valid Date");
                    InvoiceDate.focus();
                    return false;
                }
            }
            var now = new Date();
            if(Date.parse(InvoiceDate.value) > Date.parse(now))
            {
                alert("Invoice Date should not be greater than Current Date");
                InvoiceDate.focus();
                return false;
            }
          

           
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

        
        
        function ValidateIssueQty(IssQtyID, ReqQty)
        {
            var objIssQty = document.getElementById(IssQtyID);
            if (parseInt(objIssQty.value) > parseInt(ReqQty))
            {
                alert("Receive Quantity Cannot be more than Issue Quantity");
                objIssQty.focus();
                return false;
            }
        }

        
        
    </script>

  <%--  <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdPanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Spare Part Receipt</legend>
                <table style="width: 100%">
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lbVehicles" runat="server" Text="Vehicles"></asp:Label><span style="color: Red">
                                *</span>
                            <ajaxToolKit:ComboBox AutoCompleteMode="Append" ID="ddlVehicles" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlVehicles_SelectedIndexChanged" DropDownStyle="DropDownList">
                            </ajaxToolKit:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:GridView ID="gvIssueDetails" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                EmptyDataText="Details are not available" CellSpacing="2" GridLines="None" CssClass="gridviewStyle"
                                OnPageIndexChanging="gvIssueDetails_PageIndexChanging" OnRowCommand="gvIssueDetails_RowCommand">
                                <Columns>
                                    <%--<asp:BoundField HeaderText="IssID" DataField="InventoryItemIssueID" />
                                    <asp:BoundField HeaderText="ReqID" DataField="FleetInventoryReqID" />--%>
                                    <asp:BoundField HeaderText="VehicleNum" DataField="VehicleNum" />
                                    <asp:BoundField HeaderText="District" DataField="ds_lname" />
                                    <asp:BoundField HeaderText="ReqQty" DataField="RequestedQty" />
                                    <asp:BoundField HeaderText="ReqDate" DataField="RequestedDate" />
                                    <asp:BoundField HeaderText="IssQty" DataField="IssuedQty" />
                                    <asp:BoundField HeaderText="IssDate" DataField="IssueDate" />
                                    <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnViewDetails" runat="server" Text="Receipt" ToolTip="Click here to Receipt the details"
                                                OnClick="btnViewDetails_Click" CssClass="button2" RowIndex='<%# Container.DisplayIndex %>'
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
                    <tr>
                        <td>
                            <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <ajaxToolKit:ModalPopupExtender ID="gv_ModalPopupExtender1" BehaviorID="mdlPopup"
                            runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground" />
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPanel" Style="padding: 10px;
                                display: none;">
                                <fieldset style="padding: 10px;">
                                    <legend>Receipt Details </legend>
                                    <table>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbVehicleID" runat="server" Text="VehicleID"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtVehicleID" runat="server" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbVehicleNo" runat="server" Text="VehicleNo"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtVehicleNo" runat="server" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbDistrict" runat="server" Text="District"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDistrict" runat="server" ReadOnly="true"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbInventoryReqID" runat="server" Text="InvIssID"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtInvReqID" runat="server" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbDCnumber" runat="server" Text="DC No"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDCNumber" runat="server" ReadOnly="true" MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbDcDate" runat="server" Text="DC Date"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDCDate" runat="server" ReadOnly="true" oncut="return false;"
                                                    onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbCourierName" runat="server" Text="CourierName"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCourierName" runat="server" ReadOnly="true" MaxLength="20"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbRemarks" runat="server" Text="HO Remarks"></asp:Label>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" ReadOnly="true" MaxLength="20"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbReceptdate" runat="server" Text="ReceiptDate"></asp:Label><span
                                                    style="color: Red"> *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtReceiptDate" runat="server" onkeypress="return false" MaxLength="15"
                                                    oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox><ajaxToolKit:CalendarExtender
                                                        ID="ccl2" runat="server" TargetControlID="txtReceiptDate" Format="MM/dd/yyyy"
                                                        PopupButtonID="ImageButton1">
                                                    </ajaxToolKit:CalendarExtender>
                                                <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                                                    Style="vertical-align: top" />
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbReceiptRemarks" runat="server" Text="Remarks"></asp:Label><span
                                                    style="color: Red"> *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtReceiptRemarks" runat="server" MaxLength="50" TextMode="MultiLine"
                                                    onKeyUp="CheckLength(this,50)" onChange="CheckLength(this,50)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbInvoiceNo" runat="server" Text="InvoiceNo"></asp:Label><span style="color: Red">
                                                    *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtInvoiceNo" runat="server" MaxLength="5"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbInvoiceDate" runat="server" Text="InvoiceDate"></asp:Label><span
                                                    style="color: Red"> *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtInvoiceDate" runat="server" MaxLength="15" onkeypress="return false"
                                                    oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox><ajaxToolKit:CalendarExtender
                                                        ID="ccl3" runat="server" TargetControlID="txtInvoiceDate" Format="MM/dd/yyyy"
                                                        PopupButtonID="ImageButton2">
                                                    </ajaxToolKit:CalendarExtender>
                                                <asp:ImageButton ID="ImageButton2" runat="server" alt="" src="images/Calendar.gif"
                                                    Style="vertical-align: top" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="7">
                                                <asp:GridView ID="gvReceiptDetails" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84"
                                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AutoGenerateColumns="false"
                                                    OnRowDataBound="gvReceiptDetails_RowDataBound">
                                                    <RowStyle CssClass="rowStyleGrid" />
                                                    <FooterStyle CssClass="footerStylegrid" />
                                                    <Columns>
                                                        <%--<asp:BoundField HeaderText="SparePartIssueID" DataField="SparePartIssueDetID" />--%>
                                                        <asp:BoundField HeaderText="SparePartName" DataField="SparePart_Name" />
                                                        <asp:BoundField HeaderText="RequestedQty" DataField="RequestedQty" />
                                                        <asp:BoundField HeaderText="IssuedQty" DataField="IssuedQty" />
                                                        <asp:TemplateField HeaderText="ReceivedQty">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtReceivedQty" runat="server" onkeypress="return isNumberKey(event);"
                                                                    MaxLength="4"></asp:TextBox>
                                                                <asp:Label ID="LbDetID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SparePartIssueDetID") %>'
                                                                    Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
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
                                        <tr>
                                            <td align="center" colspan="7">
                                                <asp:Button ID="btReceive" runat="server" Text="Received" OnClick="btReceive_Click" />
                                                <asp:Button ID="btCancel" runat="server" Text="Cancel" OnClick="btCancel_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

