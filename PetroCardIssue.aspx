<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.PetroCardIssue, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type="text/javascript">
    
           function isNumberKey(evt)
              {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                else
                    return true;
                }
                
                
          function isMandatory()
          {
         
           if(document.getElementById("<%=txtPetroCardNumber.ClientID %>").value==0)
                 {
                    alert("Please enter PetroCardNumber");
                    document.getElementById("<%=txtPetroCardNumber.ClientID %>").focus();
                    return false;
                 }  
            
            var Agency = document.getElementById('<%= ddlAgency.ClientID %>');
            if (Agency.selectedIndex == 0) 
            {
                alert("Please select the Agency");
                Agency.focus();
                return false;
            }
            
            var CardType = document.getElementById('<%=ddlCardType.ClientID %>');
             if (CardType.selectedIndex == 0) 
            {
                alert("Please select the CardType");
                CardType.focus();
                return false;
            } 
            
            
             if(document.getElementById("<%=txtValidityEndDate.ClientID %>").value==0)
                 {
                    alert("Please Select ValidityEndDate");
                    document.getElementById("<%=txtValidityEndDate.ClientID %>").focus();
                    return false;
                 }   
           if(document.getElementById("<%=txtIssuedDate.ClientID %>").value==0)
                 {
                    alert("Please Select IssuedDate");
                    document.getElementById("<%=txtIssuedDate.ClientID %>").focus();
                    return false;
                 }   
            var listFe = document.getElementById('<%=dd_listFe.ClientID %>');
             if (listFe.selectedIndex == 0) 
            {
                alert("Please select the FE");
                listFe.focus();
                return false;
            }
                 
                 
            var ValidityEndDate=document.getElementById('<%=txtValidityEndDate.ClientID %>');
            
            var IssuedDate=document.getElementById('<%=txtIssuedDate.ClientID %>');

            if (trim(ValidityEndDate.value) != "") 
            {
                if (!isValidDate(ValidityEndDate.value)) 
                {
                    alert("Enter the Valid Date");
                    ValidityEndDate.focus();
                    return false;
                }
            }
            
            
            if (trim(IssuedDate.value) != "") 
            {
                if (!isValidDate(IssuedDate.value)) 
                {
                    alert("Enter the Valid Date");
                    IssuedDate.focus();
                    return false;
                }
            }
             var now = new Date();
            if(Date.parse(ValidityEndDate.value) < Date.parse(now))
            {
                alert("ValidityEndDate should be greater than Current Date");
                ValidityEndDate.focus();
                return false;
            }
            
            var now = new Date();
            if(Date.parse(IssuedDate.value) > Date.parse(now))
            {
                alert("Issued Date should not be greater than Current Date");
                IssuedDate.focus();
                return false;
            }
            
            var id =document.getElementById('<%=ddlVehicles.ClientID %>');
            
          var inputs = id.getElementsByTagName('input');
            var i;
            for (i = 0; i < inputs.length; i++) {
                if (inputs[i].type == 'text') {
                    if (inputs[i].value != "" && inputs[i].value != null)
                        if (inputs[i].value == "--Select--") {
                            alert('Select the Vehicle');
                            return false;
                    }
                   
                    break;
                }
            }
            
               

        }
        
        function RequiredValidation(ctrl, msg) 
        {
            if (trim(ctrl.value) == '') 
            {
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

        function isValidDate(subject) 
        {
            if (subject.match(/^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/)) 
            {
                return true;
            } else 
            {
                return false;
            }
        }
        
        function isDecimalNumberKey(event) 
        {
            var charCode = (event.which) ? event.which : event.keyCode
            
            if (charCode == 190 || charCode == 46) 
            {
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

   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdPanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Petro Card Issue</legend>
                            <table align="center">
                                <tr>
                                    <td class="rowseparator">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px; height: 19px">
                                    </td>
                                    <td style="width: 101px; height: 19px">
                                        <asp:DropDownList ID="ddlDistricts" runat="server" Width="153px" AutoPostBack="True"
                                            Visible="false" OnSelectedIndexChanged="ddlDistricts_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 135px; height: 19px">
                                        <asp:TextBox ID="txtEdit" runat="server" Visible="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px; height: 19px;">
                                        PetroCardNumber<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px; height: 19px;">
                                        <asp:TextBox ID="txtPetroCardNumber" runat="server" MaxLength="16"></asp:TextBox>
                                    </td>
                                    <td style="width: 135px; height: 19px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px">
                                        Agency<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px">
                                        <asp:DropDownList ID="ddlAgency" runat="server" Width="153px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlAgency_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 135px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px">
                                        Card Type<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px">
                                        <asp:DropDownList ID="ddlCardType" runat="server" Width="153px" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 135px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px">
                                        ValidityEndDate<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px">
                                        <asp:TextBox ID="txtValidityEndDate" runat="server" oncut="return false;" onpaste="return false;"
                                            oncopy="return false;" onkeypress="return false"></asp:TextBox>
                                        <cc1:CalendarExtender ID="calValEndDate" runat="server" TargetControlID="txtValidityEndDate"
                                            Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarInvoiceDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td nowrap="nowrap" style="width: 51px">
                                                    <asp:ImageButton ID="imgBtnCalendarInvoiceDate" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px">
                                        Issued To FE<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px">
                                        <asp:DropDownList ID="dd_listFe" runat="server" AutoPostBack="True" 
                                            onselectedindexchanged="dd_listFe_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <%-- <asp:TextBox ID="txtIssuedToFE" runat="server" onkeydown="return isNumberKey(event);" MaxLength="15"></asp:TextBox>--%>
                                    </td>
                                    <td style="width: 135px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 121px; height: 19px;">
                                        Issued Date<span style="color: Red">*</span>
                                    </td>
                                    <td style="width: 101px; height: 19px;">
                                        <asp:TextBox ID="txtIssuedDate" runat="server" MaxLength="15" onkeypress="return false"
                                            oncut="return false;" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                        <cc1:CalendarExtender ID="calIssuedDate" runat="server" TargetControlID="txtIssuedDate"
                                            Format="MM/dd/yyyy" PopupButtonID="ImageButton1">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td nowrap="nowrap" style="width: 51px">
                                                    <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                                                Style="vertical-align: top" />
                                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 121px; height: 19px; text-align: left;">
                                        Issued To Vehicle<span style="color: Red">*</span></td>
                                    <td style="width: 101px; height: 19px">
                                       <cc1:ComboBox AutoCompleteMode="Append" DropDownStyle="DropDownList" ID="ddlVehicles" runat="server" AutoPostBack="True" 
                                            Enabled="False">
                                        </cc1:ComboBox>
                                        
                                        
                                    </td>
                                    <td style="width: 135px; height: 19px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 121px; height: 19px; text-align: left;">
                                        Issued To District<span style="color: Red">*</span></td>
                                    <td style="width: 101px; height: 19px">
                                        <asp:DropDownList ID="ddlFeuserDistrict" runat="server" AutoPostBack="True" 
                                            Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 135px; height: 19px">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 121px; height: 19px">
                                        <asp:Button ID="btSave" runat="server" Text="Save" OnClick="btSave_Click" />
                                        <td style="width: 135px; height: 19px" align="center">
                                            <asp:Button ID="btReset" runat="server" Text="Reset" OnClick="btReset_Click" />
                                        </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <table style="width: 102px; height: 99px" align="center">
                                <tr>
                                    <td style="width: 102px; height: 99px">
                                        <asp:GridView ID="gvPetroCardIssue" runat="server" Width="102px" AllowPaging="True"
                                            OnPageIndexChanging="gvPetroCardIssue_PageIndexChanging" PageSize="50" CellPadding="3"
                                            CellSpacing="2" GridLines="None" class="table table-striped table-bordered table-hover" HorizontalAlign="Justify"
                                            OnRowEditing="gvPetroCardIssue_RowEditing" OnRowDeleting="gvPetroCardIssue_RowDeleting"
                                            AutoGenerateColumns="False" OnRowCommand="gvPetroCardIssue_RowCommand" EmptyDataText="No Records Found">
                                            <RowStyle CssClass="rowStyleGrid" />
                                            <Columns>
                                                <asp:BoundField HeaderText="District" DataField="District" />
                                                <asp:BoundField HeaderText="Card" DataField="CardNum" />
                                                <asp:BoundField HeaderText="Vehicle" DataField="Vehicle" />
                                                <asp:BoundField HeaderText="CardType" DataField="CardType" />
                                                <asp:BoundField HeaderText="Validity" DataField="Validity" />
                                                <asp:BoundField HeaderText="IssuedFE" DataField="IssueToFE" />
                                                <asp:BoundField HeaderText="Date" DataField="IssuedDate" />
                                                <asp:BoundField HeaderText="IssuedDistrict" DataField="IssuedToDistrict" />
                     <asp:BoundField HeaderText="IssuedVehicle" DataField="IssuedToVehicle" />
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"IssueID") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Deactivate">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnDeactivate" runat="server" Text="Deactivate" CommandName="Delete"
                                                            CommandArgument='<%#DataBinder.Eval(Container.DataItem,"IssueID") %>'></asp:LinkButton>
                                                        <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnDeactivate"
                                                            ConfirmText="Are you sure you want to Deactivate?">
                                                        </cc1:ConfirmButtonExtender>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="footerStylegrid" />
                                            <PagerStyle CssClass="pagerStylegrid" />
                                            <SelectedRowStyle CssClass="selectedRowStyle" />
                                            <HeaderStyle CssClass="headerStyle" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

