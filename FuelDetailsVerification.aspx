<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.FuelDetailsVerification, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript" language="javascript">
//    var isRecordChecked = false;

//var expCollArr = new Array();

//function restoreExpCollStateAll()
//{

//    if(idArr)
//    {
//        for(var i=0;i<idArr.length;i++)
//        {
//            restoreExpCollState(idArr[i]);
//        }
//    }
//}

//function saveExpCollState(obj,state)
//{

//    if(expCollArr[obj])
//        expCollArr[obj][0] = state;
//    else
//    {
//        expCollArr[obj] = new Array();
//        idArr[idArr.length] = obj;
//        expCollArr[obj][0] = state;
//    }
//}

    function ConfirmApprove(btnID,remarkID)
    {
        var btnApprove = document.getElementById(btnID);
        if(remarkID)
        {
            alert('Please enter remarks!');
            (document.getElementById(remarkID)).focus();
        }
        else if(confirm('Are you sure You want to APPROVE'))
        {
            btnApprove.click();
        }
    }
    
    function ConfirmReject(btnID,remarkID)
    {
        var btnReject = document.getElementById(btnID);
        if(remarkID)
        {
            alert('Please enter remarks!');
            (document.getElementById(remarkID)).focus();
        }
        else if(confirm('Are you sure You want to REJECT'))
        {
            btnReject.click();
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
	            var key;
	            var keychar;
	            if (window.event)
		            key = window.event.keyCode;
	            else if ( e )
		            key = e.which;
	            else
		            return true;
	            keychar = String.fromCharCode(key);
	            if (((" !@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) > -1))
		        return false;
	            else
		        return true;
              }
    </script>

    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <table>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="padding: 10px">
                    <legend>Fuel Detail Verification</legend>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td align="right">
                                       
                                        <asp:Label ID="Label1" runat="server" Text="Select Vehicle"></asp:Label>
                                        <span style="color: Red">*</span>
                                       
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlVehicleNumber" runat="server" AutoPostBack="True" 
                                            onselectedindexchanged="ddlVehicleNumber_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="rowseparator">
                                    <td align="right">
                                        &nbsp;</td>
                                    <td align="left">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="gvVerification" runat="server" AutoGenerateEditButton="False" AutoGenerateColumns="false"
                                            GridLines="None" CssClass="gridviewStyle" Width="434px" CellPadding="3" CellSpacing="2"
                                            OnRowEditing="gvVerification_RowEditing" 
                                            EmptyDataText="No Records to Approve/Reject" AllowPaging="True" 
                                            onpageindexchanging="gvVerification_PageIndexChanging1" Caption="Fuel Entry Details" CaptionAlign="Top">
                                            <RowStyle CssClass="rowStyleGrid" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Check">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="checkSelect" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                                <asp:BoundField DataField="vehno" HeaderText="Vehicle" />
                                                <asp:BoundField DataField="EntryDate" HeaderText="Date" />
                                                <asp:BoundField DataField="Qty" HeaderText="Quaantity" />
                                                <%--  <asp:BoundField DataField="mode" HeaderText="Mode" />
                                                <asp:BoundField DataField="agency" HeaderText="Agency" />
                                                <asp:BoundField DataField="Cardno" HeaderText="CardNo." />
                                                <asp:BoundField DataField="BillNo" HeaderText="BillNo." />
                                                <asp:BoundField DataField="Bunk" HeaderText="Bunk" />
                                                <asp:BoundField DataField="Qty" HeaderText="Qty" />--%>
                                                <asp:BoundField DataField="Price" HeaderText="UnitPrice" />
                                                <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                                <asp:BoundField DataField="KMPL" HeaderText="KMPL" />
                                                <asp:TemplateField HeaderText="Remarks">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="30" onkeypress="return remark(event);"></asp:TextBox>
                                     <asp:Label ID="lblId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FuelEntryID") %>' Visible="false"></asp:Label>
                                                       
                                                    </ItemTemplate>
                                                    
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid" />
                                            <PagerStyle CssClass="pagerStylegrid" />
                                            <SelectedRowStyle CssClass="selectedRowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                        </asp:GridView>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <asp:GridView ID="gvReconcilation" runat="server" AutoGenerateEditButton="False" AutoGenerateColumns="false"
                                            GridLines="None" CssClass="gridviewStyle" Width="434px" CellPadding="3" CellSpacing="2"
                                            OnRowEditing="gvReconcilation_RowEditing" 
                                            EmptyDataText="No Records to Approve/Reject" AllowPaging="True" 
                                            onpageindexchanging="gvReconcilation_PageIndexChanging1" Caption="Reconciliation Details" CaptionAlign="Top">
                                            <RowStyle CssClass="rowStyleGrid" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Check">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="checkSelect" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                                <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle" />
                                                <asp:BoundField DataField="AccountID" HeaderText="Account" />
                                                <asp:BoundField DataField="Dealer" HeaderText="Dealer" />
                                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                                <asp:BoundField DataField="TransactionDate" HeaderText="Date" />
                                                <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                                <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="Rblid" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TransactionID") %>' Visible="false"></asp:Label> 
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid" />
                                            <PagerStyle CssClass="pagerStylegrid" />
                                            <SelectedRowStyle CssClass="selectedRowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                        </asp:GridView>
                                        <br />
                                        <br />
                                        <table align="left" style="width: 66%">
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="Approve" runat="server" Text="Approve" OnClick="Approve_Click" />
                                                    <asp:Button ID="btnHdnApprove" runat="server" onclick="btnHdnApprove_Click" style="display:none;" />
                                                    <%--<asp:ConfirmButtonExtender
                                                        ID="ConfirmButtonExtender1" runat="server" TargetControlID="Approve" ConfirmText="Are you sure You want to APPROVE">
                                                    </asp:ConfirmButtonExtender>--%>
                                                    
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="Reject" runat="server" Text="Reject" OnClick="Reject_Click" />
                                                    <asp:Button ID="btnHdnReject" runat="server" onclick="btnHdnReject_Click" style="display:none;" />
                                                    
                                                    
                                                    
                                                    <%--<asp:ConfirmButtonExtender                               
                                                        ID="ConfirmButtonExtender2" runat="server" TargetControlID="Reject" ConfirmText="Are you sure You want to REJECT">
                                                    </asp:ConfirmButtonExtender>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td class="rowseparator">
            </td>
        </tr>
    </table>

    <script type="text/javascript" language="javascript">
        
        function EnableRemarks() 
        {
            document.getElementById("<%= gvVerification.ClientID %>");
            return true;
        }
    </script>

</asp:Content>

