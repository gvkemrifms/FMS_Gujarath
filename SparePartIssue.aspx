<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.SparePartIssue, App_Web_m0x5b0wx" %>
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

function OnlyAlphabets(myfield, e, dec) 
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
            
            var DCNumber = document.getElementById('<%= txtDCNumber.ClientID %>');
            
            var DCDate = document.getElementById('<%= txtDCDate.ClientID %>');
            
            var CourierName = document.getElementById('<%= txtCourierName.ClientID %>');
            
            var Remarks = document.getElementById('<%= txtRemarks.ClientID %>');
                                 
            if (!RequiredValidation(DCNumber, "DC Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(DCDate, "DC Date cannot be Blank"))
                return false;
                
            if (VehicleID.selectedIndex == 0) {
                alert("Please select Vehicle");
                VehicleID.focus();
                return false;
            }  
                


            if (trim(DCDate.value) != "") {
                if (!isValidDate(DCDate.value)) {
                    alert("Enter the Valid Date");
                    DCDate.focus();
                    return false;
                }
            }
            
            var now = new Date();
            if(Date.parse(DCDate.value) > Date.parse(now))
            {
                alert("DCDate should not be greater than Current Date");
                DCDate.focus();
                return false;
            }

            if (!RequiredValidation(CourierName, "Courier Name cannot be Blank"))
                return false;

            if (!RequiredValidation(Remarks, "Remarks cannot be Blank"))
                return false;
   
            var txtIssuedQuantity = document.getElementById(IssuedQuantity);
            if (!RequiredValidation(txtIssuedQuantity, "Issue Qty cannot be Blank"))
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



            function trim(value) 
            {
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
                alert("Issue Quantity Cannot be more than Request Qunatity");
                objIssQty.focus();
                return false;
            }
        }

        
        
    </script>

    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdPanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Spare Parts Issue</legend>
                <table style="width: 100%">
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lb_Vehicles" runat="server" Text="Vehicles"></asp:Label><span style="color: Red">
                                *</span> &nbsp;<ajaxToolKit:ComboBox AutoCompleteMode="Append" ID="ddlVehicles" runat="server"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlVehicles_SelectedIndexChanged"
                                    DropDownStyle="DropDownList">
                                </ajaxToolKit:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:GridView ID="gvApprovedRequisition" runat="server" CellPadding="3" CellSpacing="2"
                                EmptyDataText="Details are not available" GridLines="None" CssClass="gridviewStyle"
                                OnPageIndexChanging="gvApprovedRequisition_PageIndexChanging" AutoGenerateColumns="false"
                                OnRowCommand="gvApprovedRequisition_RowCommand">
                                <Columns>
                                    <%-- <asp:BoundField HeaderText="ReqID" DataField="FleetInventoryReqID" />--%>
                                    <asp:BoundField HeaderText="VehicleNo" DataField="VehicleNum" />
                                    <asp:BoundField HeaderText="DistrictID" DataField="DistrictID" />
                                    <asp:BoundField HeaderText="No. of Spare Parts" DataField="RequestedQty" />
                                    <asp:BoundField HeaderText="Requested By" DataField="RequestedBy" />
                                    <asp:TemplateField ControlStyle-Width="50px" HeaderStyle-Width="60px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnViewDetails" runat="server" Text="Issue" ToolTip="Click here to Issue the details"
                                                RowIndex='<%# Container.DisplayIndex %>' CommandName="Show" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FleetInventoryReqID") %>' />
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
                            <ajaxToolKit:ModalPopupExtender ID="gv_ModalPopupExtender1" BehaviorID="mdlPopup"
                                runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlPopup" BackgroundCssClass="modalBackground" />
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
                                    <legend>Issue Details</legend>
                                    <table>
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
                                                <asp:Label ID="lbInventoryReqID" runat="server" Text="InvReqID"></asp:Label>
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
                                                <asp:Label ID="lbDCnumber" runat="server" Text="DC No"></asp:Label><span style="color: Red">
                                                    *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDCNumber" runat="server" MaxLength="5"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbDcDate" runat="server" Text="DC Date"></asp:Label><span style="color: Red">
                                                    *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDCDate" runat="server" onkeypress="return false" MaxLength="20"
                                                    oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                                <ajaxToolKit:CalendarExtender ID="ccl1" runat="server" TargetControlID="txtDCDate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ImageButton1">
                                                </ajaxToolKit:CalendarExtender>
                                                <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                                                    Style="vertical-align: top" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rowseparator">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbCourierName" runat="server" Text="CourierName"></asp:Label><span
                                                    style="color: Red">*</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCourierName" runat="server" MaxLength="20"></asp:TextBox>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:Label ID="lbRemarks" runat="server" Text="Remarks"></asp:Label><span style="color: Red">
                                                    *</span>
                                            </td>
                                            <td class="columnseparator">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="20" TextMode="MultiLine" onKeyUp="CheckLength(this,50)"
                                                    onChange="CheckLength(this,50)"></asp:TextBox>
                                            </td>
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
                                            <td align="center" colspan="7">
                                                <asp:GridView ID="gvIssueDetails" runat="server" GridLines="None" CssClass="gridviewStyle"
                                                    CellPadding="3" CellSpacing="2" AutoGenerateColumns="false" OnRowDataBound="gvIssueDetails_RowDataBound">
                                                    <Columns>
                                                        <%--<asp:BoundField HeaderText="ReqID" DataField="FleetInventoryReqID" />--%>
                                                        <asp:BoundField HeaderText="SparePartName" DataField="SparePart_Name" />
                                                        <asp:BoundField HeaderText="RequestedQty" DataField="RequestedQty" />
                                                        <asp:TemplateField HeaderText="IssuedQty">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtIssuedQty" runat="server" onkeypress="return isNumberKey(event);"
                                                                    MaxLength="4"></asp:TextBox>
                                                            </ItemTemplate>
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
                                            <td colspan="7" align="center">
                                                <asp:Button ID="btIssue" runat="server" Text="Issue" OnClick="btIssue_Click" />
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
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

