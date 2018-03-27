<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VehicleTypes, App_Web_m0x5b0wx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type="text/javascript">
    
    function CheckLength(text,long) 
{
	var maxlength = new Number(long); //Change number to your max length.
	if (text.value.length > maxlength)
       {
		text.value = text.value.substring(0,maxlength);

		alert(" Only " + long + " chars");

	}
}
    
    function alpha_only_withspace(e) 
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
    
            function validation()
            {
           if(document.getElementById("<%=txtVehicleType.ClientID %>").value==0)
                 {
                    alert("Please EnterVehicle Type");
                    document.getElementById("<%=txtVehicleType.ClientID %>").focus();
                    return false;
                 }
                 if(document.getElementById("<%=txtVehicleDescription.ClientID %>").value==0)
                 {
                    alert("Please Enter Vehicle Description");
                    document.getElementById("<%=txtVehicleDescription.ClientID %>").focus();
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
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Vehicle Types</legend>
                            <asp:Panel ID="pnlvehicletypes" runat="server">
                                <table style="width: 500px;" title="Vehicle Types" align="center">
                                    <tr>
                                        <td align="left">
                                            Vehicle Type <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleType" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; Vehicle Type Description <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator">
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtVehicleDescription" runat="server" TextMode="MultiLine" Rows="3"
                                                onKeyUp="CheckLength(this,300)" onChange="CheckLength(this,300)" onkeypress="return alphanumeric_withspace_only(event);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnvehicleTypeSave" runat="server" Text="Save" OnClientClick="return validation();"
                                                OnClick="vehicleTypeSave_Click" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="vehicleTypeReset" runat="server" Text="Reset" OnClick="vehicleTypeReset_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px;">
                            <asp:GridView ID="grvVehicleTypes" runat="server" align="center" AllowPaging="True"
                                PageSize="5" AutoGenerateColumns="False" CellPadding="3" CellSpacing="2" OnPageIndexChanging="grvVehicleTypes_PageIndexChanging"
                                GridLines="None" CssClass="gridviewStyle" OnRowEditing="grvVehicleTypes_RowEditing"
                                Width="600px">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Vehicle Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVehicleTypeId" runat="server" Text='<%#Eval("VehicleType_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle Type">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVehicleType" runat="server" Text='<%#Eval("Vehicle_Type")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="VehicleType Description">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_type" runat="server" Text='<%#Eval("Vehicle_TypeDesc")%>' TextMode="MultiLine"
                                                Width="400px" ReadOnly="true" Rows="5"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnStatus" runat="server" Text="Active" CommandName="Update" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Edit" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid" />
                                <PagerStyle CssClass="pagerStylegrid" />
                                <SelectedRowStyle CssClass="selectedRowStyle" />
                                <HeaderStyle CssClass="headerStyle" />
                            </asp:GridView>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator">
                    </td>
                </tr>
            </table>
            <br />
            <asp:HiddenField ID="hidVehicleType" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

