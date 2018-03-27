<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VasOffroadFleetManager, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <asp:UpdatePanel ID="Updtepanelvehoffroad" runat="server">
        <ContentTemplate>
            
                
                <div>
                    <asp:GridView ID="gvVasOffroad" runat="server" EmptyDataText="No Records Found"
                                        AllowSorting="True" AutoGenerateColumns="False" 
                        CssClass="gridviewStyle" CellSpacing="2"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" 
                        Width="630px" AllowPaging="True"
                                        EnableSortingAndPagingCallbacks="True" 
                        onpageindexchanging="gvVasOffroad_PageIndexChanging" 
                        onrowcommand="gvVasOffroad_RowCommand" 
                        onrowdatabound="gvVasOffroad_RowDataBound">
                       
                                        <RowStyle CssClass="rowStyleGrid" />
                                        <Columns>
                                        <asp:TemplateField HeaderText="Offroad ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOffroadID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VehicleNo">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVehicle_No" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Vechicleno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="District">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDistrict" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"District") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Date of Off Road">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDoOffRoad" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"downtime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            
                                            <asp:TemplateField HeaderText="Reason">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReason" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Reason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Estimated Cost">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEstimatedCost" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"EstimatedCost") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved Cost">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtApprovedCost" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           
                                            
                                         
                                            <asp:TemplateField HeaderText="Approve">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkApprove" runat="server"  CommandName="Approve" CommandArgument=' <%# Container.DataItemIndex %>'
                                                        Text="Approve"></asp:LinkButton>
                                                    <%--CommandArgument='<%#DataBinder.Eval(Container.DataItem,"BillNo") %>'--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reject">
                                                <ItemTemplate>
                                                
                                                    <asp:LinkButton OnClientClick="PressButton()" ID="lnkReject" runat="server" CommandName="Reject" CommandArgument=' <%# Container.DataItemIndex %>'
                                                        Text="Reject"></asp:LinkButton>
                                                    <%--CommandArgument='<%#DataBinder.Eval(Container.DataItem,"BillNo") %>'--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="footerStylegrid" />
                                        <PagerStyle CssClass="pagerStylegrid" />
                                        <SelectedRowStyle CssClass="selectedRowStyle" />
                                        <HeaderStyle CssClass="headerStyle" />
                                    </asp:GridView>
                  </div>
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
                          onclick="btnReason_Click1" OnClientClick="return Validation();"/>
                </div>
                <div style="width:50%;float:right">
                   <asp:Button runat="server" ID="btnCancel" OnClientClick="PressButton2()" Text="Close" />
                </div>
                </div >
                <div>
                    <%--<div>
                    <asp:Button runat="server" ID="btnReason" Text="Submit" onclick="btnReason_Click" 
                         />
                        </div>--%>
                    <%-- <div>
                   <asp:Button runat="server" ID="btnCancel" Text="Cancel" />
                </div>--%>
                </div >
                <div style="display:none">
                <asp:Button runat="server" ID="btnDoWork"  Text="TEMP" onclick="btnDoWork_Click"  /> 
                 <asp:Button runat="server" ID="btnPopUp" /> 
                </div>
                
            </div>
     </div>
     </div>
            <asp:ModalPopupExtender ID="mpeReasonDetails"  runat="server" BackgroundCssClass="modalBackground" DynamicServicePath=""
                                                    Enabled="True" PopupControlID="dvReason" TargetControlID="btnPopUp" OkControlID="btnCancel" >
            </asp:ModalPopupExtender>
                  </ContentTemplate>
                  </asp:UpdatePanel>
                  <script type="text/javascript" language="javascript">
                      function PressButton() {
                          //debugger;
             document.getElementById('<%= btnPopUp.ClientID %>').click();
             //return true;
         }
         function Reason() {
             
             var reason = document.getElementById('<%= txtrejectReason.ClientID %>');
             if (!RequiredValidation(reason, "Please provide reason for Rejection"))
                 return false;

             
         }
         function PressButton2() {
             document.getElementById('<%= btnDoWork.ClientID %>').click();
             return true;
         }
         function Validation() {
             var reason = document.getElementById('<%= txtrejectReason.ClientID %>');

             if (!RequiredValidation(reason, "Please enter reason for rejection"))
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
         </script>
</asp:Content>

