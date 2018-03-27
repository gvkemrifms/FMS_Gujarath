<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.HandOvertoOperations, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script src="../JavaValidations/RequiredFieldValidations.js" type="text/javascript">

    </script>
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script language="javascript" type="text/javascript">
        function validation() {

          
            var HandOverto = document.getElementById('<%= txtHandOverto.ClientID %>');
            var HandoverDate = document.getElementById('<%= txtHandoverDate.ClientID %>');
            var HandOverBy = document.getElementById('<%= txtHandOverBy.ClientID %>');
            var QualityInspectionNo = document.getElementById('<%= txtQualityInspectionNo.ClientID %>');
            var InspectionDate = document.getElementById('<%= txtInspectionDate.ClientID %>');
            var InspectedBy = document.getElementById('<%= txtInspectedBy.ClientID %>');
            var Remarks = document.getElementById('<%= txtRemarks.ClientID %>');
            var vehicleRegistrationDate= document.getElementById('<%= vehicleRegistrationDate.ClientID %>');
            var vehiclePurchaseDate = document.getElementById('<%= vehiclePurchaseDate.ClientID %>');
            var now = new Date();

           var id = document.getElementById('<%= ddlVehicleNo.ClientID %>');
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

            if (!RequiredValidation(HandOverto, "Handover To Cannot be Blank"))
                return false;
            
            if (!RequiredValidation(HandoverDate, "Handover Date Cannot be Blank"))
                return false;

            if (!isValidDate(HandoverDate.value)) {
                alert("Enter Valid Date");
                HandoverDate.focus();
                return false;
            }
            
            if(Date.parse(HandoverDate.value) > Date.parse(now))
            {
                alert("Handover Date should not be greater than Current Date");
                HandoverDate.focus();
                return false;
            }
            
            if(Date.parse(HandoverDate.value) < Date.parse(vehicleRegistrationDate.value))
            {
                alert("Handover Date should not be greater than Registration Date.(Registration Date-" + vehicleRegistrationDate.value + ")");
                HandoverDate.focus();
                return false;
            }

            if (!RequiredValidation(HandOverBy, "HandOver By Cannot be Blank"))
                return false;

            if (!RequiredValidation(QualityInspectionNo, "Quality Inspection Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(InspectionDate, "Inspection Date Cannot be Blank"))
                return false;

            if (!isValidDate(InspectionDate.value)) {
                alert("Enter Valid Date");
                InspectionDate.focus();
                return false;
            }
            
            if(Date.parse(InspectionDate.value) > Date.parse(now))
            {
                alert("Inspection Date should not be greater than Current Date");
                InspectionDate.focus();
                return false;
            }
            
            if(Date.parse(InspectionDate.value) > Date.parse(HandoverDate.value))
            {
                alert("Inspection Date should not be greater than Handover Date");
                InspectionDate.focus();
                return false;
            }
            if (Date.parse(InspectionDate.value) < Date.parse(vehiclePurchaseDate.value)) {
                alert("Inspection Date should be greater than Purchase Date(Purchase Date-" + vehiclePurchaseDate.value + ")");
                InspectionDate.focus();
                return false;
            }


            if (!RequiredValidation(InspectedBy, "Inspected By Cannot be Blank"))
                return false;

            if (!RequiredValidation(Remarks, "Remarks Cannot be Blank"))
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
        
        function alphanumeric_only(e) 
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

        function alpha_only(e) 
        {
            var keycode; 
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode; 
            else if (e) keycode = e.which;
            else return true;if((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) 
            {
                return true; 
            }
            else
            {
                return false; 
            }
            return true; 
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
        
    </script>

   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlHandOverToOperation" runat="server">
                
                    <table style="width: 100%">
                        <tr>
                            <td align="center" style="font-size: small; font-weight: bold" colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Vehicle No.<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNo" runat="server" Width="150px" 
                                    onselectedindexchanged="ddlVehicleNo_SelectedIndexChanged" 
                                    AutoPostBack="True" DropDownStyle="DropDownList">
                                </cc1:ComboBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                HandOver To<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <%--<asp:DropDownList ID="ddlHandOverto" runat="server" Width="150px">
                                    <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    <asp:ListItem Value="0">Dummy</asp:ListItem>
                                </asp:DropDownList>--%>
                                <asp:TextBox ID="txtHandOverto" runat="server" MaxLength="35" Width="145px" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Handover Date<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:TextBox ID="txtHandoverDate" runat="server" Width="145px" onkeypress="return false" oncut="return false;" onpaste="return false;">
                                </asp:TextBox><asp:ImageButton ID="imgBtnCalendarHandoverDate" runat="server" Style="vertical-align: top"
                                    alt="" src="images/Calendar.gif" />
                                <cc1:CalendarExtender ID="calExtHandoverDate" runat="server" TargetControlID="txtHandoverDate"
                                    PopupButtonID="imgBtnCalendarHandoverDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                            </td>
                            <td rowspan="4">
                                <asp:CheckBoxList ID="chkBoxTools" runat="server" Visible="False">
                                    <asp:ListItem Value="1">Select</asp:ListItem>
                                    <asp:ListItem Value="0">Dummy</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Handover By<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <%--<asp:DropDownList ID="ddlHandOverBy" runat="server" Width="150px">
                                    <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    <asp:ListItem Value="0">Dummy</asp:ListItem>
                                </asp:DropDownList>--%>
                                <asp:TextBox ID="txtHandOverBy" runat="server" MaxLength="35" Width="145px" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Quality Inspection No<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:TextBox ID="txtQualityInspectionNo" runat="server" Width="145px" MaxLength="15" onkeypress="return alphanumeric_only(event);"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Inspection Date<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:TextBox ID="txtInspectionDate" runat="server" Width="145px" onkeypress="return false" oncut="return false;" onpaste="return false;">
                                </asp:TextBox><asp:ImageButton ID="imBtnInspectionDate" runat="server" Style="vertical-align: top"
                                    alt="" src="images/Calendar.gif" />
                                <cc1:CalendarExtender ID="calExtInspectionDate" runat="server" TargetControlID="txtInspectionDate"
                                    PopupButtonID="imBtnInspectionDate" Format="MM/dd/yyyy">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Inspected By<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:TextBox ID="txtInspectedBy" runat="server" Width="145px" MaxLength="35" onkeypress="return alpha_only_withspace(event);"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                            </td>
                            <td align="left" style="width: 300px">
                                Remarks<span style="color: Red">*</span>
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:TextBox ID="txtRemarks" runat="server" Width="145px" TextMode="MultiLine" 
                                    MaxLength="200" onkeypress="return remark(event);"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 440px">
                                &nbsp;
                            </td>
                            <td align="center" style="width: 300px">
                                <asp:Button ID="btHandover" Text="Handover" runat="server" OnClick="btHandover_Click" />
                            </td>
                            <td align="left" style="width: 288px">
                                <asp:Button ID="btReset" Text="Reset" runat="server" OnClick="btReset_Click" />
                            </td>
                            <td width="300px">
                                <asp:LinkButton ID="lbtnAttachInspectionReport" runat="server" Visible="False">Attach 
                                Inspection Report</asp:LinkButton>
                            </td>
                        </tr>
                        <asp:HiddenField ID="vehiclePurchaseDate" runat="server" />
                         <asp:HiddenField ID="vehicleRegistrationDate" runat="server" />
                    </table>
                </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

