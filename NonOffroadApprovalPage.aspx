<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.NonOffroadApprovalPage, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script type="text/javascript">
    function PressButton() {
        document.getElementById('<%= btnPopUp.ClientID %>').click();
        return true;
    }
    function validation() {
        
        var ApprovalDate = document.getElementById('<%= txtApprovalDate.ClientID %>')
        var now = new Date();
        if (Date.parse(ApprovalDate.value) > Date.parse(now)) {
            alert("Approval Date should not be greater than Current Date");
            ApprovalDate.focus();
            return false;
        }
        if (!RequiredValidation(ApprovalDate, "Approval Date cannot be left blank"))
            return false;
    }

    function Rejection(lnk) {
        debugger;
        var row = lnk.parentNode.parentNode;
        var rowIndex = row.rowIndex - 1;
        
    }
    
    function trim(value) {
        value = value.replace(/^\s+/, '');
        value = value.replace(/\s+$/, '');
        return value;

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
</script>
         <asp:UpdatePanel ID="updtpnlApprPage" runat="server">
        <ContentTemplate>
              <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Non Offroad Approval<br />
                            </legend>
                            <table>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Approval Date
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                    <asp:TextBox ID="txtApprovalDate" runat="server" />
                                    <cc1:CalendarExtender ID="calExtApprovalDate" runat="server" TargetControlID="txtApprovalDate"
                                            PopupButtonID="imgBtnCalendarApprovalDate" Format="MM/dd/yyyy">
                                            </cc1:CalendarExtender>
                                    </td>
                                    <td class="columnseparator">
  </td>
     <td>
        <asp:LinkButton runat="server" ID="lnkChangeDate" Text="Change Date" 
             onclick="lnkChangeDate_Click" />
       </td>
                                </tr>
                                <tr>
                                    <td class="columnseparator">
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <asp:GridView ID="gvNonOffroadApprovalPage" runat="server" EmptyDataText="No Records Found"
                                            AllowSorting="True" AutoGenerateColumns="False" 
                                            CssClass="gridviewStyle" CellSpacing="2"
                                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="True"
                                            EnableSortingAndPagingCallbacks="True" 
                                    onrowcommand="gvNonOffroadApprovalPage_RowCommand" 
                                    onpageindexchanging="gvNonOffroadApprovalPage_PageIndexChanging" 
                                    onrowdatabound="gvNonOffroadApprovalPage_RowDataBound"> 
                                            
                                            <RowStyle CssClass="rowStyleGrid" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="District">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"District_ID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Break DownID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBrkDwn" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                
                                                <asp:TemplateField HeaderText="Vehicle No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Vechicleno") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField HeaderText="Bill No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBillNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Billno") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bill Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBillDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ReceiptDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Down Time" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDownTime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"downtime") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Up Time" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUpTime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Uptime") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bill Amount" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Amount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rejection Reason">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRejReason" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Rejection") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Vendor Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVendorName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VenName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Approve">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkApprove" runat="server" CommandName="VehApprove" CommandArgument=' <%# Container.DataItemIndex %>' 
                                                            Text="Approve" OnClientClick="return validation();"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Reject">
                                                    <ItemTemplate>
                                                    
                                                        
                                                        <asp:LinkButton ID="lnkReject" runat="server" CommandName="VehReject" CommandArgument=' <%# Container.DataItemIndex %>'
                                                            Text="Reject" OnClientClick="PressButton()"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid" />
                                            <PagerStyle CssClass="pagerStylegrid" />
                                            <SelectedRowStyle CssClass="selectedRowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                        </asp:GridView>
                            </div>
                        </td>
                     </tr>
                     
                  </table>
               <div style="width:300px;padding:5px;display:block" id="dvReason">
        <div style="border-bottom:none;background-color:Maroon">
            <asp:Label ID="Label1" runat="server" Text="Reason for Rejection" Font-Bold="True" 
                Font-Size="Small" ForeColor="#FFFFCC" />
        </div>
     <div style="background-color:White">
           <div style="width:100%">
                <div style="width:20%;float:left">
                </div>
                <div style="float:right;width:80%">
                    <asp:TextBox runat="server" ID="txtrejectReason" TextMode="MultiLine" />
                </div>
            </div>
         <div style="width:100%">
               <div style="width:40%;float:left">
                </div>
                <div style="width:60%;float:right">
                <div style="width:50%;float:left">
                    <asp:Button runat="server" ID="btnReason" Text="Submit" 
                         OnClientClick="return Reason();" onclick="btnReason_Click"  />
                </div>
                <div style="width:50%;float:right">
                   <asp:Button runat="server" ID="btnCancel" Text="Close" 
                        onclick="btnCancel_Click" />
                </div>
                </div >
                <%--<div>
                    <asp:Button runat="server" ID="btnReason" Text="Submit" 
                         OnClientClick="myClickMethod()" />
                     
                </div >--%>
                <div style="display:none">
                <asp:Button runat="server" ID="btnDoWork" onclick="btnDoWork_Click" Text="TEMP"  />  
                <asp:Button runat="server" ID="btnPopUp" />
                </div>
                <%--<div>
                   <asp:Button runat="server" ID="btnCancel" Text="Cancel" />
                </div>--%>
            </div>
     </div>
     </div>  
     <cc1:ModalPopupExtender ID="mpeReasonDetails"  runat="server" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                                    Enabled="True" PopupControlID="dvReason" TargetControlID="btnPopUp" OkControlID="btnCancel" CancelControlID="btnCancel">
                                                        </cc1:ModalPopupExtender>    
            </ContentTemplate>
         </asp:UpdatePanel>
          <script type="text/javascript" language="javascript">
              function Reason() {
                  var reason = document.getElementById('<%= txtrejectReason.ClientID %>');
                  if (!RequiredValidation(reason, "Please provide reason for Rejection"))
                      return false;
              }
//              function myClickMethod() {
//                  //debugger;
//                  if (document.getElementById('<%= txtrejectReason.ClientID %>').value == "") {
//                      alert('Please enter reason for rejection');
//                      document.getElementById('<%= txtrejectReason.ClientID %>').focus();
//                      return false;
//                  }
//                  document.getElementById('<%= btnDoWork.ClientID %>').click();
//                  return true;
//              }
     </script>
</asp:Content>

