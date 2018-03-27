<%@ Page Title="" Language="C#"  Debug="true" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelEntry.aspx.cs" Inherits="GvkFMSAPP.PL.FuelEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
  <asp:UpdatePanel ID="updPanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Fuel Entry</legend>
                <table>
                    <tr>
                        <td class="rowseparator" colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Vehicle Number<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="True"
                                DropDownStyle="DropDownList" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
                            </cc1:ComboBox>
                        </td>
                        <td align="left" style="width: 112px">
                            Borrowed Vehicle
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:DropDownList AutoCompleteMode="Append" ID="ddlDistrict" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator" colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: auto">
                            District
                        </td>
                        <td>
                            <asp:Label ID="lblDistrict" runat="server" />
                        </td>
                        <td>
                            Base Location
                        </td>
                        <td>
                            <asp:Label ID="lblLocation" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator" colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Date<span style="color: Red">*</span>
                        </td>
                        <td align="left" nowrap="nowrap" style="width: 100px">
                            <asp:TextBox ID="txtFuelEntryDate" runat="server" MaxLength="15" oncut="return false;"
                                onkeypress="return false" onpaste="return false;"></asp:TextBox>
                            <cc1:CalendarExtender ID="entDate" runat="server" Format="MM/dd/yyyy" PopupButtonID="ImageButton1"
                                TargetControlID="txtFuelEntryDate">
                            </cc1:CalendarExtender>
                            <asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif"
                                Style="vertical-align: top" />
                        </td>
                        <td align="left" style="width: 112px">
                            Bill Number<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtBillNumber" runat="server" MaxLength="16"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="left" nowrap="nowrap" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px; height: 19px">
                            Odometer(km)<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px; height: 19px">
                            <asp:TextBox ID="txtOdometer" runat="server" MaxLength="6"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 112px; height: 19px">
                            Bunk Name<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px; height: 19px">
                            <div>
                                <asp:DropDownList Style="float: left" ID="ddlBunkName" runat="server">
                                </asp:DropDownList>
                                <asp:TextBox Style="float: left" ID="txtBunkName" runat="server" MaxLength="20" Enabled="false"></asp:TextBox>
                            </div>
                            <div>
                                <asp:LinkButton ID="linkExisting" runat="server" Style="float: right" OnClick="linkExisting_Click"
                                    Text="Add Existing"></asp:LinkButton>
                                <asp:LinkButton ID="lnkNew" runat="server" Style="float: right" OnClick="lnkNew_Click"
                                    Text="Add New"></asp:LinkButton>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px; height: 19px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px; height: 19px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 112px; height: 19px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px; height: 19px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Paymode<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:DropDownList ID="ddlPaymode" runat="server" AutoCompleteMode="Append" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlPaymode_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 112px">
                            Quantity(Litres)<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtQuantity" runat="server" MaxLength="6" OnChange="onKeyPressBlockNumbers1(this.value);"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Petro Card Number<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:DropDownList ID="ddlPetroCardNumber" runat="server" AutoCompleteMode="Append"
                                AutoPostBack="True" OnSelectedIndexChanged="ddlPetroCardNumber_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 112px">
                            Unit Price(Rs)<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtUnitPrice" runat="server" MaxLength="6" onchange="onKeyPressBlockNumbers(this.value);"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px; height: 22px">
                            Agency<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px; height: 22px">
                            <asp:DropDownList ID="ddlAgency" runat="server" AutoCompleteMode="Append">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 112px; height: 22px">
                            Amount(Rs)<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px; height: 22px">
                            <asp:TextBox ID="txtAmount" runat="server" Enabled="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px; height: 22px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px; height: 22px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 112px; height: 22px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px; height: 22px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Location<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtLocation" runat="server" MaxLength="20"></asp:TextBox>
                        </td>
                        <td align="right" style="width: 112px; text-align: left;">
                            Pilot ID<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtPilotID" runat="server" MaxLength="6"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="right" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            Pilot Name<span style="color: Red">*</span>
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtPilotName" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 112px">
                            Card Swiped
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:DropDownList ID="ddlCardSwiped" runat="server">
                                <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="right" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 119px">
                            <asp:TextBox ID="txtSegmentID" runat="server" Visible="False"></asp:TextBox>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Button ID="Save" runat="server" OnClick="Save_Click" OnClientClick="return validationFuelEntry();"
                                Text="Save" />
                        </td>
                        <td align="right" style="width: 112px">
                            <asp:Button ID="Reset" runat="server" OnClick="Reset_Click" Text="Reset" />
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:TextBox ID="txtEdit" runat="server" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 119px">
                            &nbsp;
                        </td>
                        <td align="center" style="width: 100px">
                            &nbsp;
                        </td>
                        <td align="right" style="width: 112px">
                            &nbsp;
                        </td>
                        <td align="left" style="width: 100px">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="padding: 10px">
                <table align="center" style="width: 615px">
                    <tr>
                        <td style="width: 100px">
                            <asp:GridView ID="gvFuelEntry" runat="server" AllowPaging="true" AutoGenerateColumns="False"
                                CellPadding="3" CellSpacing="2"  EmptyDataText="No Records Found"
                                GridLines="None" OnPageIndexChanging="gvFuelEntry_PageIndexChanging" OnRowCommand="gvFuelEntry_RowCommand"
                                PageSize="5" Width="609px"  class="table table-striped table-bordered table-hover" >
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:BoundField DataField="vehno" HeaderText="Vehicle" />
                                    <asp:BoundField DataField="EntryDate" HeaderText="Date" />
                                    <asp:BoundField DataField="odo" HeaderText="Odometer" />
                                    <asp:BoundField DataField="mode" HeaderText="mode" />
                                    <asp:BoundField DataField="agency" HeaderText="agency" />
                                    <asp:BoundField DataField="Cardno" HeaderText="Cardno" />
                                    <asp:BoundField DataField="BillNo" HeaderText="BillNo" />
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" />
                                    <%--<asp:BoundField HeaderText="KMPL" DataField="KMPL" />--%>
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                    <asp:BoundField DataField="StatusDesc" HeaderText="Status" />
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FuelEntryID") %>'
                                                CommandName="EditFuel" Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"FuelEntryID") %>'
                                                CommandName="DeleteFuel" Text="Delete"></asp:LinkButton>
                                            <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to DELETE"
                                                TargetControlID="lnkDelete">
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
                    <tr>
                        <td style="width: 100px">
                            <asp:GridView ID="gvLastTransactions" runat="server" AutoGenerateColumns="False"
                                Caption="Last Five Transactions" CaptionAlign="Top" CellPadding="3" CellSpacing="2"
                                CssClass="gridviewStyle" EmptyDataText="No Records Found" GridLines="None" PageSize="5"
                                Width="609px">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:BoundField DataField="vehno" HeaderText="Vehicle" />
                                    <asp:BoundField DataField="EntryDate" HeaderText="Date" />
                                    <asp:BoundField DataField="odo" HeaderText="Odometer" />
                                    <asp:BoundField DataField="mode" HeaderText="mode" />
                                    <asp:BoundField DataField="agency" HeaderText="agency" />
                                    <asp:BoundField DataField="Cardno" HeaderText="Cardno" />
                                    <asp:BoundField DataField="BillNo" HeaderText="BillNo" />
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                    <asp:BoundField DataField="StatusDesc" HeaderText="Status" />
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
            <asp:HiddenField ID="maxOdo" runat="server" />

            <script type="text/javascript" language="javascript">
            document.getElementById('<%= ddlVehicleNumber.ClientID %>').focus();
            
        function sum() 
        {
            var text1 = parseFloat(document.getElementById("<%= txtQuantity.ClientID %>").value);
            var text2 = parseFloat(document.getElementById("<%= txtUnitPrice.ClientID %>").value);
            var text3 = text1 * text2;
            document.getElementById("<%= txtAmount.ClientID %>").value = text3.toFixed(2);
        }
        
        
         function  validationFuelEntry()
         { 
            
          
           
            
            
            var id = document.getElementById('<%=ddlVehicleNumber.ClientID %>');
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
            
             var FuelEntryDate=document.getElementById('<%= txtFuelEntryDate.ClientID %>')
                 
                 if (!RequiredValidation(FuelEntryDate, "FuelEntryDate Cannot be Blank"))
                return false;
                 
               if (trim(FuelEntryDate.value) != "") 
            {
                if (!isValidDate(FuelEntryDate.value)) 
                {
                    alert("Enter the Valid Date");
                    FuelEntryDate.focus();
                    return false;
                }
            }
            
            var now = new Date();
            if(Date.parse(FuelEntryDate.value) > Date.parse(now))
            {
                alert("Fuel Entry Date should not be greater than Current Date");
                FuelEntryDate.focus();
                return false;
            }
            
            if(document.getElementById("<%=txtBillNumber.ClientID %>").value==0)
                 {
                    alert("Please Enter BillNumber value");
                    document.getElementById("<%=txtBillNumber.ClientID %>").focus();
                    return false;
                 }
            
            
                 if(document.getElementById("<%=txtOdometer.ClientID %>").value==0)
                 {
                    alert("Please Enter Odometer value");
                    document.getElementById("<%=txtOdometer.ClientID %>").focus();
                    return false;
                 }

//                 var BunkName = document.getElementById('<%= ddlBunkName.ClientID %>')
//                 if (BunkName.selectedIndex == 0) {
//                     alert("Please select the BunkName");
//                     BunkName.focus();
//                     return false;
//                 }

//                 if (document.getElementById("<%=txtBunkName.ClientID %>").value == 0) {
//                     alert("Please select the BunkName");
//                     document.getElementById("<%=txtBunkName.ClientID %>").focus();
//                     return false;
//                 }
            
            var Paymode=document.getElementById('<%= ddlPaymode.ClientID %>')
           
            if (Paymode.selectedIndex == 0) 
            {
                alert("Please select the Paymode");
                Paymode.focus();
                return false;
            }
            
          if(Paymode.options[Paymode.selectedIndex].text=="Card")
          {
            var Agency=document.getElementById('<%= ddlAgency.ClientID %>')
           
            if (Agency.selectedIndex == 0) 
            {
                alert("Please select the Agency");
                Agency.focus();
                return false;
            }
            
            var PetroCardNumber=document.getElementById('<%= ddlPetroCardNumber.ClientID %>')
           
            if (PetroCardNumber.selectedIndex == 0) 
            {
                alert("Please select the PetroCardNumber");
                PetroCardNumber.focus();
                return false;
            }
          }
         
            
            
           
             if(document.getElementById("<%=txtQuantity.ClientID %>").value==0)
                 {
                    alert("Please Enter quantity value");
                    document.getElementById("<%=txtQuantity.ClientID %>").focus();
                    return false;
                 }       
                

   
                                   
                
   
                
                     if(document.getElementById("<%=txtUnitPrice.ClientID %>").value==0)
                 {
                    alert("Please Enter UnitPrice value");
                    document.getElementById("<%=txtUnitPrice.ClientID %>").focus();
                    return false;
                 }
                 
                 
                 
                     if(document.getElementById("<%=txtLocation.ClientID %>").value==0)
                 {
                    alert("Please Enter Location value");
                    document.getElementById("<%=txtLocation.ClientID %>").focus();
                    return false;
                 }
                 
                 
                     if(document.getElementById("<%=txtPilotID.ClientID %>").value==0)
                 {
                    alert("Please Enter Pilot ID");
                    document.getElementById("<%=txtPilotID.ClientID %>").focus();
                    return false;
                 }
                 
                 
                     if(document.getElementById("<%=txtPilotName.ClientID %>").value==0)
                 {
                    alert("Please Enter Pilot Name");
                    document.getElementById("<%=txtPilotName.ClientID %>").focus();
                    return false;
                 }
                 
                 
                 var CardSwiped=document.getElementById('<%= ddlCardSwiped.ClientID %>')
           
                 if (CardSwiped.selectedIndex == 0) 
                 {
                alert("Please select the CardSwipedStatus");
                CardSwiped.focus();
                return false;
                  }
                      
                 var maxOdo=document.getElementById("<%=maxOdo.ClientID %>");
                 var givenOdo=document.getElementById("<%=txtOdometer.ClientID %>");
                 
                 if(parseInt(maxOdo.value)>=parseInt(givenOdo.value))
                 {
                 alert("Odometer value should be greater than the Previous Odometer value (Pre Odo Reading="+maxOdo.value+")");
                 givenOdo.focus();
                 return false;
                 }
                
       
          } 
          
          function DecimalValidate(control)
        {
            // regular expression
            var rgexp = new RegExp("^\d*([.]\d{2})?$");
            var input = document.getElementById(control).value;

            if (input.match(rgexp))
               return true;
            else
                return false;
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
        
        function onKeyPressBlockNumbers(value)
    {
        reg = /^\-?([1-9]\d*|0)(\.\d?[1-9])?$/;
	 //  reg = /^(10|\d)(\.\d{1,2})?$/;
        if(!reg.test(value))
        {
            alert("please enter numeric values only");
            document.getElementById("<%= txtUnitPrice.ClientID %>").value="";
            return false;
        }
        
        var text5 = parseFloat(document.getElementById("<%= txtUnitPrice.ClientID %>").value);
        if(text5>75)
        {
            alert("Unit Price Cant be greater than 75");
            document.getElementById("<%= txtUnitPrice.ClientID %>").value="";
            return false;
        }
      
       sum();
        return reg.test(value);
    }
    
       
        function onKeyPressBlockNumbers1(value)
    {
        reg = /^\-?([1-9]\d*|0)(\.\d?[1-9])?$/;
	//	  reg = /^(10|\d)(\.\d{1,2})?$/;
        if(!reg.test(value))
        {
            alert("please enter numeric values only");
            document.getElementById("<%= txtQuantity.ClientID %>").value="";
            return false;
        }
        
        var text5 = parseFloat(document.getElementById("<%= txtQuantity.ClientID %>").value);
        if(text5>65)
        {
            alert("Quantity Cant be greater than 65");
            document.getElementById("<%= txtQuantity.ClientID %>").value="";
            return false;
        }
      
       sum();
        return reg.test(value);
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
	            if ((("!@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) > -1))
		        return false;
	            else
		        return true;
              }

              function isNumberKey(e) {
                  var charCode = (e.charCode) ? e.which : event.keyCode
                  if (charCode != 46 && charCode > 31
            && (charCode < 48 || charCode > 57))
                      return false;

                  return true;
              }
            </script>

      </ContentTemplate>
    </asp:UpdatePanel> 
</asp:Content>
