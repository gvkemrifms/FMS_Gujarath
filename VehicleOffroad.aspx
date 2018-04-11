<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleOffroad.aspx.cs" Inherits="VehicleOffroad" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
<script type="text/javascript" language="javascript">
    function addZero(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

    function validation() {

        var fldDistrict = document.getElementById('<%= ddlDistrict.ClientID %>');
        var id = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
        var fldReason = document.getElementById('<%= ddlreasons.ClientID %>');
        var fldContactNumber = document.getElementById('<%= txtContactNumber.ClientID %>');
        var fldOdo = document.getElementById('<%= txtOdo.ClientID %>');
        var fldEstCost = document.getElementById('<%= txtAllEstimatedCost.ClientID %>');
        var fldComments = document.getElementById('<%= txtComment.ClientID %>');
        var fldEmeId = document.getElementById('<%= txtEMEId.ClientID %>');
        var fldPilotId = document.getElementById('<%= txtPilotId.ClientID %>');
        var fldPilotName = document.getElementById('<%= txtPilotName.ClientID %>');
        var fldOfftime = document.getElementById('<%= txtOfftimeDate.ClientID %>');
        var fldHrs = document.getElementById('<%= ddlOFFHour.ClientID %>');
        var fldMins = document.getElementById('<%= ddlOFFMin.ClientID %>');
        var fldExpDateOfRecovery = document.getElementById('<%= txtExpDateOfRec.ClientID %>');
        var fldHrsEdr = document.getElementById('<%= ddlExpDateOfRecHr.ClientID %>');
        var fldMinsEdr = document.getElementById('<%= ddlExpDateOfRecMin.ClientID %>');
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
        if (fldDistrict && fldDistrict.selectedIndex === 0) {
            alert("Please Select District");
            fldDistrict.focus();
            return false;
        }

        var inputs = id.getElementsByTagName('input');
        var i;
        for (i = 0; i < inputs.length; i++) {
            if (inputs[i].type === 'text') {
                if (inputs[i].value !== "" && inputs[i].value != null)
                    if (inputs[i].value === "Select") {
                        alert('Select the Vehicle');
                        return false;
                    }

                break;
            }
        }

        if (fldReason)
            if (fldReason.selectedIndex === 0) {
                alert("Please select Reason");
                fldReason.focus();
                return false;
            }

        if (!RequiredValidation(fldContactNumber, "Contact number cannot be left blank"))
            return false;

        if (!RequiredValidation(fldOdo, "Odometer cannot be left blank"))
            return false;

        if (!RequiredValidation(fldEstCost, "Estimated Cost cannot be left blank"))
            return false;

        if (!RequiredValidation(fldComments, "Comments cannot be left blank"))
            return false;

        if (!RequiredValidation(fldEmeId, "EMEID cannot be left blank"))
            return false;

        if (!RequiredValidation(fldPilotId, "PilotId cannot be left blank"))
            return false;

        if (!RequiredValidation(fldPilotName, "PilotName cannot be left blank"))
            return false;

        if (!RequiredValidation(fldOfftime, "Uptime cannot be blank"))
            return false;

        if (fldHrs && fldHrs.selectedIndex === 0) {
            alert("Please select Hrs for Offtime Date");
            fldHrs.focus();
            return false;
        }

        if (fldMins && fldMins.selectedIndex === 0) {
            alert("Please select Mins for Offtime Date");
            fldMins.focus();
            return false;
        }

        today = new Date();
        dd = addZero(today.getDate());
        mm = addZero(today.getMonth() + 1); //January is 0!
        var h = addZero(today.getHours());
        var m = addZero(today.getMinutes());
        var s = addZero(today.getSeconds());
        yyyy = today.getFullYear();
        now = dd + '/' + mm + '/' + yyyy + " " + h + ":" + m + ":" + s;
        if (!RequiredValidation(fldExpDateOfRecovery, "Expected Date of Recovery cannot be blank"))
            return false;

        if (fldHrsEdr && fldHrsEdr.selectedIndex === 0) {
            alert("Please select Hrs for Expected Date of Recovery");
            fldHrsEdr.focus();
            return false;
        }

        if (fldMinsEdr && fldMinsEdr.selectedIndex === 0) {
            alert("Please select Mins for Expected Date of Recovery");
            fldMinsEdr.focus();
            return false;
        }

        if (Date.parse(fldOfftime.value + " " + fldHrs.value + ":" + fldMins.value) >=
            Date.parse(fldExpDateOfRecovery.value + " " + fldHrsEdr.value + ":" + fldMinsEdr.value)) {
            alert("Expected Date of Recovery should be greater than Offtime Date");
            fldExpDateOfRecovery.focus();
            return false;
        }

        document.getElementById("loaderButton").style.display = '';
        document.all('<%= pnlButton.ClientID %>').style.display = "none";
        return true;
    }
</script>
<fieldset style="padding: 10px">
<legend>Vehicle OffRoad</legend>
<table style="width: 640px;">
    <tr>
        <td colspan="7"></td>
    </tr>
    <tr>
        <td>
            District<span class="labelErr" style="color: Red">*</span>
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
        <td style="height: 21px">
            Vehicle Number<span class="labelErr" style="color: Red">*</span>
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
        <td>
            Reason <span class="labelErr" style="color: Red">*</span>
        </td>
        <td class="columnseparator"></td>
        <td>
            <asp:DropDownList ID="ddlreasons" Width="90%" runat="server" AutoPostBack="True"
                              OnSelectedIndexChanged="ddlreasons_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
        <td class="columnseparator"></td>
        <td>
            Contact Number<span class="labelErr" style="color: Red">*</span>
        </td>
        <td class="columnseparator"></td>
        <td>
            <asp:TextBox ID="txtContactNumber" runat="server" onkeypress="return numeric_only(event)"
                         MaxLength="12">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="rowseparator"></td>
    </tr>
    <div id="divAggre" runat="server">
        <tr>
            <td>
                Aggregates<span class="labelErr" style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td>
                <asp:DropDownList ID="ddlAggregates" Width="90%" runat="server" AutoPostBack="True"
                                  OnSelectedIndexChanged="ddlAggregates_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="columnseparator"></td>
            <td>
                Categories<span class="labelErr" style="color: Red">*</span>
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
            <td>
                Sub-Categories<span class="labelErr" style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td>
                <asp:DropDownList ID="ddlSubCategories" Width="90%" runat="server" OnSelectedIndexChanged="ddlSubCategories_SelectedIndexChanged"
                                  AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td class="columnseparator"></td>
            <td>
                Estimated Cost<span class="labelErr" style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td>
                <asp:TextBox ID="txtEstCost" runat="server" Width="90%" onkeypress="return isDecimalNumberKey(event);"/>
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
                <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click"/>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
        </tr>
        <table>
            <tr>
                <td>
                    <asp:GridView ID="grdvwBreakdownDetails" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84"
                                  BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="5" AutoGenerateDeleteButton="True"
                                  OnRowDeleting="grdvwBreakdownDetails_RowDeleting">
                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510"/>
                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510"/>
                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center"/>
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White"/>
                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White"/>
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
    <td>
        Odometer<span class="labelErr" style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td>
        <asp:TextBox ID="txtOdo" runat="server" onkeypress="return isNumberKey(event)" MaxLength="6"></asp:TextBox>
    </td>
    <td class="columnseparator"></td>
    <td>
        Estimated Cost<span class="labelErr" style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td>
        <asp:TextBox ID="txtAllEstimatedCost" runat="server" onkeypress="return onlyNumbers();"
                     Width="90%"/>
    </td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td>
        Comments<span class="labelErr" style="color: Red">*</span>
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
    <td>
        Requested By (EME Name)<span class="labelErr" style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td>
        <asp:TextBox ID="txtReqBy" runat="server" onkeypress="return onlyAlphabets(event,this);"
                     Width="90%">
        </asp:TextBox>
    </td>
    <td class="columnseparator"></td>
    <td>
        EME ID<span class="labelErr" style="color: Red">*</span>
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
    <td>
        Pilot Name<span class="labelErr" style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td>
        <asp:TextBox ID="txtPilotName" onkeypress="return onlyAlphabets(event,this);" runat="server"
                     Width="90%">
        </asp:TextBox>
    </td>
    <td></td>
    <td>
        Pilot ID<span class="labelErr" style="color: Red">*</span>
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
    <td>
        OffTime <span style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td nowrap="nowrap" colspan="6">
        <table style="width: 100%">
            <tr>
                <td nowrap="nowrap" style="width: 20%">
                    <asp:TextBox ID="txtOfftimeDate" runat="server" Width="120px" onkeypress="return false"></asp:TextBox>
                    <asp:ImageButton ID="imgBtnUptimeDate" runat="server" Style="vertical-align: top"
                                     alt="" src="images/Calendar.gif"/>
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
    <td>
        Expected Date of Recovery <span style="color: Red">*</span>
    </td>
    <td class="columnseparator"></td>
    <td nowrap="nowrap" colspan="6">
        <table style="width: 100%">
            <tr>
                <td nowrap="nowrap" style="width: 20%">
                    <asp:TextBox ID="txtExpDateOfRec" runat="server" Width="120px" onkeypress="return false"></asp:TextBox>
                    <asp:ImageButton ID="imgbtnExpDateOfRec" runat="server" Style="vertical-align: top"
                                     alt="" src="images/Calendar.gif"/>
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
                            <br/>
                            <asp:GridView ID="grdvothersegment" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                          GridLines="None" OnRowDataBound="grdvothersegment_RowDataBound">
                                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"/>
                                <RowStyle ForeColor="#333333" BackColor="#F7F6F3"/>
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"/>
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center"/>
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"/>
                                <Columns>
                                    <asp:BoundField DataField="sg_lname" HeaderText="Mandal Name"/>
                                    <asp:TemplateField HeaderText="Segments">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList1" runat="server">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EditRowStyle BackColor="#999999"/>
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775"/>
                            </asp:GridView>
                        </fieldset>
                    </asp:Panel>
                    <asp:Panel ID="pnlothervehicle" runat="server" Style="padding: 10px" Visible="false">
                        <fieldset style="padding: 10px">
                            <legend>Place Other Segment Vehicle</legend>
                            <br/>
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
                                            <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True"/>
                                            <RowStyle ForeColor="#333333" BackColor="#F7F6F3"/>
                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"/>
                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center"/>
                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"/>
                                            <Columns>
                                                <asp:BoundField DataField="sg_lname" HeaderText="Mandal Name"/>
                                                <asp:TemplateField HeaderText="Segments" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="DropDownlist2" runat="server">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EditRowStyle BackColor="#999999"/>
                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"/>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br/>
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
    <img id="loaderButton" alt="" src="../images/savingimage.gif" style="display: none"/>
    <tr>
        <td align="center" colspan="7" style="">
            <asp:Panel ID="pnlButton" runat="server">
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"/>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset"/>
            </asp:Panel>
        </td>
    </tr>
</caption>
</table>
</fieldset>
</asp:Content>