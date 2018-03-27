<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.AgencyDetails, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

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
              function OnlyAlphaNumeric(e) 
              {
                var keycode; 
                if (window.event) keycode = window.event.keyCode;
                else if (event) keycode = event.keyCode; 
                else if (e) keycode = e.which;
                else return true;if( (keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) ) 
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
                
                function isValidPAN(PAN) 
        {
            if (PAN.match(/^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$/)) 
            {
                return true;
            }
            else 
            {
                alert("Enter a valid PAN eg - 'BBAPM6454J'");
                return false;
            }
        } 

            function  validationAgencyDetails()
            {  
                 if(document.getElementById("<%=txtAgencyName.ClientID %>").value==0)
                 {
                    alert("Please Enter Agency Name");
                    document.getElementById("<%=txtAgencyName.ClientID %>").focus();
                    return false;
                 }
                 if(document.getElementById("<%=ddlState.ClientID %>").selectedIndex==0)
                 {
                    alert("Please Select State");
                    document.getElementById("<%=ddlState.ClientID %>").focus();
                    return false;
                 }
                 if(document.getElementById("<%=ddlDistrict.ClientID %>").selectedIndex==0)
                 {
                    alert("Please Select District");
                    document.getElementById("<%=ddlDistrict.ClientID %>").focus();
                    return false;
                 }
                 if(document.getElementById("<%=txtAddress.ClientID %>").value==0)
                 {
                    alert("Please Enter Address");
                    document.getElementById("<%=txtAddress.ClientID %>").focus();
                    return false;
                 }
                 if(document.getElementById("<%=txtContactNo.ClientID %>").value==0)
                 {
                    alert("Please Enter Contact Number");
                    document.getElementById("<%=txtContactNo.ClientID %>").focus();
                    return false;
                 }
   
                                       var phone = document.getElementById("<%=txtContactNo.ClientID %>").value;     
                                        if (isNaN(parseInt(phone))) 
                                        {
                                        alert("The Contact number contains illegal characters");
                                         document.getElementById("<%=txtContactNo.ClientID %>").focus();
                                        return false;   
                                        }
                                        else{} 
                                        if (!((phone.length >= 10)&&(phone.length <= 15)))
                                        {
                                        alert("The Contact number is the wrong length");
                                         document.getElementById("<%=txtContactNo.ClientID %>").focus();
                                        return false;        
                                        }
                                        else{} 

                 
                 if(document.getElementById("<%=txtPanNo.ClientID %>").value==0)
                 {
                    alert("Please Enter PAN");
                    document.getElementById("<%=txtPanNo.ClientID %>").focus();
                    return false;
                 }
                 
                 if(!isValidPAN(document.getElementById("<%=txtPanNo.ClientID %>").value))
                {
                    document.getElementById("<%=txtPanNo.ClientID %>").value="";
                    document.getElementById("<%=txtPanNo.ClientID %>").focus();
                    return false;
                }
                
                
                 if(document.getElementById("<%=txtTin.ClientID %>").value==0)
                 {
                    alert("Please Enter TIN");
                    document.getElementById("<%=txtTin.ClientID %>").focus();
                    return false;
                 }
           }
    </script>

   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator ">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Agency Details</legend>
                            <asp:Panel ID="pnlagencydetails" runat="server">
                                <table style="width: 100%; height: 150px;">
                                    <tr>
                                        <td align="left" style="width: 141px">
                                            Agency Name <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 200px">
                                            <asp:TextBox ID="txtAgencyName" runat="server" MaxLength="35"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 146px">
                                            State <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 200px">
                                            Contact Number <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 200px">
                                            <asp:TextBox ID="txtContactNo" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 146px">
                                            District<span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 141px">
                                            PAN No <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 200px">
                                            <asp:TextBox ID="txtPanNo" runat="server" MaxLength="10"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 146px">
                                            Address <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" onKeyUp="CheckLength(this,300)"
                                                onChange="CheckLength(this,300)"></asp:TextBox>
                                        </td>
                                        <%--                                        <td align="left" style="width: 146px">
                                            Mandal/Taluka <span style="color: Red">*</span>
                                        </td>
--%>
                                        <%--<td class="columnseparator">
                                        </td>--%>
                                        <%--                                        <td align="left">
                                            <asp:DropDownList ID="ddlMandal" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMandal_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
--%>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 141px">
                                            TIN <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 200px">
                                            <asp:TextBox ID="txtTin" runat="server" MaxLength="11"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <%--                                        <td align="left" style="width: 146px">
                                            City <span style="color: Red">*</span>
                                        </td>
--%>
                                        <%--<td class="columnseparator">
                                        </td>--%>
                                        <%--                                        <td align="left">
                                            <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
--%>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 141px">
                                            &nbsp;
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td style="width: 200px">
                                            &nbsp;
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <%--<td align="left" style="width: 146px">
                                            Address <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                        </td>--%>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 141px">
                                            &nbsp;
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td style="width: 200px">
                                            &nbsp;
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left" style="width: 146px">
                                            &nbsp;
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtEdit" runat="server" Visible="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                        <tr>
                                            <td align="center" colspan="8">
                                                <asp:Button ID="btnSaveAgencyDetails" runat="server" Width="55px" Height="20px" OnClick="btnSaveAgencyDetails_Click"
                                                    Text="Save" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnResetAgencyDetails" runat="server" Width="55px" Height="20px"
                                                    OnClick="btnResetAgencyDetails_Click" Text="Reset" />
                                            </td>
                                        </tr>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator ">
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator ">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <table style="width: 100%; height: 60px;">
                                <%--Start Agency Sub Type --%>
                                <%--                                    <tr>
                                    <td align="left" style="width: 100px">
                                        AgencyType
                                    </td>
                                    <td align="left" style="width: 120px">
                                        <asp:TextBox ID="txtAgencyType" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="left" style="width: 100px">
                                        SubType
                                    </td>
                                    <td align="left" style="width: 120px">
                                        <asp:TextBox ID="txtSubType" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="left" style="width: 120px">
                                        Manufacturer
                                    </td>
                                    <td align="left" style="width: 120px">
                                        <asp:TextBox ID="txtManufacturer" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                        <td align="center" colspan="6">
                                            <asp:GridView ID="grvAgencyDetailsWithSubtype" runat="server" BackColor="#DEBA84"
                                                BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
                                                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="6">
                                            <asp:Button ID="btnAddAgencyDetailsWithSubType" runat="server" Height="20px" Text="Add" />
                                        </td>
                                    </tr>
--%>
                                <%--End Agency Sub Type --%>
                                </caption> </caption>
                                <caption>
                                    <tr>
                                        <td class="rowseparator ">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:GridView ID="grvAgencyDetails" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                                CellSpacing="2" CssClass="gridviewStyle" GridLines="None" OnPageIndexChanging="grvAgencyDetails_PageIndexChanging"
                                                OnRowDeleting="grvAgencyDetails_RowDeleting" OnRowEditing="grvAgencyDetails_RowEditing">
                                                <RowStyle CssClass="rowStyleGrid" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Agency Id">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("AgencyID")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Agency Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("AgencyName")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Contact Number">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCntNum" runat="server" Text='<%#Eval("ContactNum")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="City">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCity" runat="server" Text='<%#Eval("City")%>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Address">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Address")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Created Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("CreatedDate", "{0:d}")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Edit">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Delete">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                                            <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to DELETE"
                                                                TargetControlID="lnkDelete">
                                                            </asp:ConfirmButtonExtender>
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
                                        <td align="center">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </caption>
                            </table>
                        </fieldset>
                        <asp:HiddenField ID="hidAgencyId" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator ">
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

