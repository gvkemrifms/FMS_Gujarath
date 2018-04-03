<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleOffroad.aspx.cs" Inherits="GvkFMSAPP.PL.VAS.VehicleOffroad" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
        function addZero(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
        function validation() {

            var fld_District = document.getElementById('<%= ddlDistrict.ClientID %>');

            var id = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
            var fld_Reason = document.getElementById('<%= ddlreasons.ClientID %>');
            var fld_ContactNumber = document.getElementById('<%= txtContactNumber.ClientID %>');
            var fld_Odo = document.getElementById('<%= txtOdo.ClientID %>');
            var fld_EstCost = document.getElementById('<%= txtAllEstimatedCost.ClientID %>');
            var fld_Comments = document.getElementById('<%= txtComment.ClientID %>');
            var fld_EMEId = document.getElementById('<%= txtEMEId.ClientID %>');
            var fld_PilotId = document.getElementById('<%= txtPilotId.ClientID %>');
            var fld_PilotName = document.getElementById('<%= txtPilotName.ClientID %>');
            var fld_Offtime = document.getElementById('<%= txtOfftimeDate.ClientID %>');
            var fld_hrs = document.getElementById('<%= ddlOFFHour.ClientID %>');
            var fld_mins = document.getElementById('<%= ddlOFFMin.ClientID %>');
            var fld_ExpDateOfRecovery = document.getElementById('<%= txtExpDateOfRec.ClientID %>');
            var fld_hrsEDR = document.getElementById('<%= ddlExpDateOfRecHr.ClientID %>');
            var fld_minsEDR = document.getElementById('<%= ddlExpDateOfRecMin.ClientID %>');


            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!

            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            var now = dd + '/' + mm + '/' + yyyy;


            if (fld_District)
                if (fld_District.selectedIndex == 0) {
                    alert("Please Select District");
                    fld_District.focus();
                    return false;
                }

            var inputs = id.getElementsByTagName('input');
            var i;
            for (i = 0; i < inputs.length; i++) {
                if (inputs[i].type == 'text') {
                    if (inputs[i].value != "" && inputs[i].value != null)
                        if (inputs[i].value == "Select") {
                            alert('Select the Vehicle');
                            return false;
                        }

                    break;
                }
            }

            if (fld_Reason)
                if (fld_Reason.selectedIndex == 0) {
                    alert("Please select Reason");
                    fld_Reason.focus();
                    return false;
                }

            if (!RequiredValidation(fld_ContactNumber, "Contact number cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_Odo, "Odometer cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_EstCost, "Estimated Cost cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_Comments, "Comments cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_EMEId, "EMEID cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_PilotId, "PilotId cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_PilotName, "PilotName cannot be left blank"))
                return false;

            if (!RequiredValidation(fld_Offtime, "Uptime cannot be blank"))
                return false;

            if (fld_hrs)
                if (fld_hrs.selectedIndex == 0) {
                    alert("Please select Hrs for Offtime Date");
                    fld_hrs.focus();
                    return false;
                }

            if (fld_mins)
                if (fld_mins.selectedIndex == 0) {
                    alert("Please select Mins for Offtime Date");
                    fld_mins.focus();
                    return false;
                }

            var today = new Date();
            var dd = addZero(today.getDate());
            var mm = addZero(today.getMonth() + 1); //January is 0!
            var h = addZero(today.getHours());
            var m = addZero(today.getMinutes());
            var s = addZero(today.getSeconds());
            var yyyy = today.getFullYear();

            var now = dd + '/' + mm + '/' + yyyy + " " + h + ":" + m + ":" + s;
           // if (Date.parse(fld_Offtime.value + " " + fld_hrs.value + ":" + fld_mins.value) > Date.parse(now)) {
			//alert(fld_Offtime.value + " " + fld_hrs.value + ":" + fld_mins.value);
			//alert(now);
           //      alert(Date.parse(fld_Offtime.value + " " + fld_hrs.value + ":" + fld_mins.value));
           //      alert(Date.parse(now));
           //     alert("Offtime Date should not be greater than Current Date");
           //     fld_Offtime.focus();
           //     return false;
           // }

            if (!RequiredValidation(fld_ExpDateOfRecovery, "Expected Date of Recovery cannot be blank"))
                return false;

            if (fld_hrsEDR)
                if (fld_hrsEDR.selectedIndex == 0) {
                    alert("Please select Hrs for Expected Date of Recovery");
                    fld_hrsEDR.focus();
                    return false;
                }

            if (fld_minsEDR)
                if (fld_minsEDR.selectedIndex == 0) {
                    alert("Please select Mins for Expected Date of Recovery");
                    fld_minsEDR.focus();
                    return false;
                }

            if (Date.parse(fld_Offtime.value + " " + fld_hrs.value + ":" + fld_mins.value) >= Date.parse(fld_ExpDateOfRecovery.value + " " + fld_hrsEDR.value + ":" + fld_minsEDR.value)) {
                alert("Expected Date of Recovery should be greater than Offtime Date");
                fld_ExpDateOfRecovery.focus();
                return false;
            }

            document.getElementById("loaderButton").style.display = '';
            document.all('<%= pnlButton.ClientID %>').style.display = "none"
           }
           function Integersonly(event) {

               var decimalvalidate = ApplyDecimalFilter(document.all(event.target.id).value, event);
               if (decimalvalidate == false) return false;

           }
           function ApplyDecimalFilter(id, event) {
               try {
                   return NewDecimalFilter(id, event);
               } catch (e) {
                   alert(e.message);
               }
           }

           function NewDecimalFilter(o, event) {
               var key;
               var keychar;
               key = event.keyCode || event.which;
               keychar = String.fromCharCode(key);

               if (event.which > 47 && event.which < 58) {
                   return true;
               }

               if (key == 37 || key == 38 || key == 39 || key == 40) {
                   if (("1234567890").indexOf(keychar) > -1)

                       return true;
                   else
                       return false;
               }

               if (event.which == 50 || (event.keyCode == 8 || key == 9
           || event.keyCode == 46) && o.indexOf('.') == -1) {
                   if (navigator.appName == "Microsoft Internet Explorer") {
                       if (("1234567890").indexOf(keychar) > -1)

                           return true;
                       else
                           return false;
                   }
                   else {
                       return true;
                   }
               }
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
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
           function numeric_only(e) {
               var keycode;
               if (window.event) keycode = window.event.keyCode;
               else if (event) keycode = event.keyCode;
               else if (e) keycode = e.which;
               else return true;
               if (keycode >= 48 && keycode <= 57) {
                   return true;
               }
               else {
                   return false;
               }
               return true;
           }

           function onlyAlphabets(e, t) {

               var keycode;
               if (window.event) keycode = window.event.keyCode;
               else if (event) keycode = event.keyCode;
               else if (e) keycode = e.which;
               else return true; if ((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                   return true;
               }
               else {
                   return false;
               }
               return true;

           }
    </script>

    <%--    <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
     <%--   <asp:UpdatePanel ID="Updtepanelvehoffroad" runat="server">
        <ContentTemplate> --%>
            <fieldset style="padding: 10px">
                <legend>Vehicle OffRoad</legend>
                <table style="width: 640px;">
                    <tr>
                        <td colspan="7"></td>
                    </tr>
                    <tr>
                        <td>District<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td colspan="5">
                            <asp:DropDownList ID="ddlDistrict" runat="server" Width="36%" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged"
                                AutoPostBack="True">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="height: 21px">Vehicle Number<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator" style="height: 21px"></td>
                        <td style="height: 21px">
                            <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                        <td class="columnseparator" style="height: 21px"></td>
                        <td style="height: 21px">
                            <asp:Label ID="lblSegment" runat="server" Text="Base Location" Visible="false"></asp:Label>
                        </td>
                        <td class="columnseparator" style="height: 21px"></td>
                        <td style="height: 21px">
                            <asp:Label ID="lblSegmentName" runat="server" Text="" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Reason <span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlreasons" Width="90%" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlreasons_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Contact Number<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtContactNumber" runat="server" onkeypress="return numeric_only(event)"
                                MaxLength="12"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <div id="divAggre" runat="server">
                        <tr>
                            <td>Aggregates<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:DropDownList ID="ddlAggregates" Width="90%" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlAggregates_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td class="columnseparator"></td>
                            <td>Categories<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:DropDownList ID="ddlCategories" Width="90%" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td class="columnseparator"></td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <td>Sub-Categories<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:DropDownList ID="ddlSubCategories" Width="90%" runat="server" OnSelectedIndexChanged="ddlSubCategories_SelectedIndexChanged"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td class="columnseparator"></td>
                            <td>Estimated Cost<span class="labelErr" style="color: Red">*</span>
                            </td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:TextBox ID="txtEstCost" runat="server" Width="90%" onkeypress="return isDecimalNumberKey(event);" />
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class="columnseparator"></td>
                            <td></td>
                            <td class="columnseparator"></td>
                            <td></td>
                            <td class="columnseparator"></td>
                            <td>
                                <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td class="rowseparator"></td>
                        </tr>
                        <tr>
                            <%-- <asp:GridView ID="grdvwBreakdownDetails" runat="server" 
                                AutoGenerateColumns="false" BackColor="#DEBA84" BorderColor="#DEBA84" 
                                ForeColor="#333333"
                                BorderWidth="1px" CellPadding="3" CellSpacing="2" CssClass="gridviewStyle" 
                                DataKeyNames="RowNumber" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="RowNumber" HeaderText="S.No" 
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowno" runat="server" 
                                                Text='<%#DataBinder.Eval(Container.DataItem,"District") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Aggregates">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAggregates" runat="server" 
                                                Text='<%#DataBinder.Eval(Container.DataItem,"District") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Categories">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCategories" runat="server" 
                                                Text='<%#DataBinder.Eval(Container.DataItem,"District") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SubCategories">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSubCategories" runat="server" 
                                                Text='<%#DataBinder.Eval(Container.DataItem,"District") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Estimated Cost">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEstimatedCost" runat="server" 
                                                Text='<%#DataBinder.Eval(Container.DataItem,"District") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid" />
                                <PagerStyle CssClass="pagerStylegrid" />
                                <SelectedRowStyle CssClass="selectedRowStyle" />
                                <HeaderStyle CssClass="headerStyle" />
                            </asp:GridView>--%>
                        </tr>
                        <table>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdvwBreakdownDetails" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84"
                                        BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="5" AutoGenerateDeleteButton="True"
                                        OnRowDeleting="grdvwBreakdownDetails_RowDeleting">
                                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </table>
                <table style="width: 646px">
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Odometer<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtOdo" runat="server" onkeypress="return isNumber(event)" MaxLength="6"></asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>Estimated Cost<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtAllEstimatedCost" runat="server" onkeypress="return onlyNumbers();"
                                Width="90%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Comments<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td colspan="5">
                            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Requested By (EME Name)<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtReqBy" runat="server" onkeypress="return onlyAlphabets(event,this);"
                                Width="90%"></asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                        <td>EME ID<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtEMEId" onkeypress="return numeric_only(event)" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Pilot Name<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtPilotName" onkeypress="return onlyAlphabets(event,this);" runat="server"
                                Width="90%"></asp:TextBox>
                        </td>
                        <td></td>
                        <td>Pilot ID<span class="labelErr" style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:TextBox ID="txtPilotId" onkeypress="return numeric_only(event)" runat="server"></asp:TextBox>
                        </td>
                        <td class="columnseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>OffTime <span style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td nowrap="nowrap" colspan="6">
                            <table style="width: 100%">
                                <tr>
                                    <td nowrap="nowrap" style="width: 20%">
                                        <asp:TextBox ID="txtOfftimeDate" runat="server" Width="120px" onkeypress="return false"></asp:TextBox>
                                        <asp:ImageButton ID="imgBtnUptimeDate" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtOfftimeDate"
                                            PopupButtonID="imgBtnUptimeDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td style="width: 80%">
                                        <asp:DropDownList ID="ddlOFFHour" runat="server" Width="55px">
                                            <asp:ListItem Value="-1">--hh--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlOFFMin" runat="server" Width="60px">
                                            <asp:ListItem Value="-1">--mm--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td>Expected Date of Recovery <span style="color: Red">*</span>
                        </td>
                        <td class="columnseparator"></td>
                        <td nowrap="nowrap" colspan="6">
                            <table style="width: 100%">
                                <tr>
                                   <td nowrap="nowrap" style="width: 20%">
                                        <asp:TextBox ID="txtExpDateOfRec" runat="server" Width="120px" onkeypress="return false"></asp:TextBox>
                                        <asp:ImageButton ID="imgbtnExpDateOfRec" runat="server" Style="vertical-align: top"
                                            alt="" src="images/Calendar.gif" />
                                        <cc1:CalendarExtender ID="calExtndrExpDateOfRec" runat="server" TargetControlID="txtExpDateOfRec"
                                            PopupButtonID="imgbtnExpDateOfRec" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td style="width: 80%">
                                        <asp:DropDownList ID="ddlExpDateOfRecHr" runat="server" Width="55px">
                                            <asp:ListItem Value="-1">--hh--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlExpDateOfRecMin" runat="server" Width="60px">
                                            <asp:ListItem Value="-1">--mm--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblmsg" runat="server" Visible="false" ForeColor="SteelBlue" Text="There are more than one Vehicles in that Segment,then no Segment Down "></asp:Label>
                                        <asp:Panel ID="pnlRadioBtnList" runat="server" Visible="false">
                                            <asp:RadioButtonList ID="rdbtnlstOption" runat="server" AutoPostBack="true" CellSpacing="5"
                                                RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbtnlstOption_SelectedIndexChanged">
                                                <asp:ListItem Text="Map Mandal to Other Segment" Value="rdbothersegment"></asp:ListItem>
                                                <asp:ListItem Text="Place Other Segment Vehicle" Value="rdbothervehicle"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Panel ID="pnlothersegment" runat="server" Style="padding: 10px" Visible="false">
                                            <fieldset style="padding: 10px" visible="false">
                                                <legend>Map Mandal To Other Segment</legend>
                                                <br />
                                                <asp:GridView ID="grdvothersegment" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                    GridLines="None" OnRowDataBound="grdvothersegment_RowDataBound">
                                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                                    <RowStyle ForeColor="#333333" BackColor="#F7F6F3" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <Columns>
                                                        <asp:BoundField DataField="sg_lname" HeaderText="Mandal Name" />
                                                        <asp:TemplateField HeaderText="Segments">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EditRowStyle BackColor="#999999" />
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                </asp:GridView>
                                            </fieldset>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlothervehicle" runat="server" Style="padding: 10px" Visible="false">
                                            <fieldset style="padding: 10px">
                                                <legend>Place Other Segment Vehicle</legend>
                                                <br />
                                                <table width="100%">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="Label3" runat="server" Text="Vehicles"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlothervehicle" runat="server" AutoPostBack="True" Width="200px"
                                                                OnSelectedIndexChanged="ddlothervehicle_SelectedIndexChanged">
                                                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="columnseparator"></td>
                                                        <td align="left">
                                                            <asp:Label ID="lblothercontactno" runat="server" Text="Contact Number"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtothercontactno" runat="server" Width="124px" onkeypress="return false;"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="rowseparator"></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="lblotherbaselocation" runat="server" Text="Base Location"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtotherbaselocation" runat="server" Width="200px" onkeypress="return false;"></asp:TextBox>
                                                        </td>
                                                        <td class="columnseparator"></td>
                                                        <td align="left">
                                                            <asp:Label ID="lblOtherVehSegment" runat="server" Text="Segment" Visible="false"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Label ID="lblOtherVehSegmentName" runat="server" Text="" Visible="false"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="rowseparator"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" align="center">
                                                            <asp:GridView ID="grdvothervehicle" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                                ForeColor="#333333" GridLines="None" OnRowDataBound="grdvothervehicle_RowDataBound">
                                                                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                                                <RowStyle ForeColor="#333333" BackColor="#F7F6F3" />
                                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="sg_lname" HeaderText="Mandal Name" />
                                                                    <asp:TemplateField HeaderText="Segments" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList ID="DropDownlist2" runat="server">
                                                                            </asp:DropDownList>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EditRowStyle BackColor="#999999" />
                                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                            <br />
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <div style="top: 0px; width: 68px;">
                    </tr>
                    <caption>
                        <img id="loaderButton" alt="" src="../images/savingimage.gif" style="display: none" />
                        <tr>
                            <td align="center" colspan="7" style="">
                                <asp:Panel ID="pnlButton" runat="server">
                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset" />
                                </asp:Panel>
                            </td>
                        </tr>
                    </caption>
                </table>
            </fieldset>
     <%--   </ContentTemplate>
    </asp:UpdatePanel> --%>
</asp:Content>

