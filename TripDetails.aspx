<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="TripDetails.aspx.cs" Inherits="TripDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <div class="center">
                <fieldset style="padding: 10px">
                    <legend>Trip Details Entry</legend>
                    <br/>
                    <table>
                        <tr>
                            <td colspan="4">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>

                            <td style="width: 93px">
                                Trip Date&nbsp;
                            </td>
                            <td style="width: 229px">
                                <asp:TextBox ID="txtTripDate" runat="server"
                                             onKeyPress="javascript: return false;" onPaste="javascript: return false;">
                                </asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server"
                                                      TargetControlID="txtTripDate" PopupButtonID="ImageButton1">
                                </cc1:CalendarExtender><asp:ImageButton ID="ImageButton1" runat="server" alt="" src="images/Calendar.gif" Style="vertical-align: top"/>
                            </td>
                            <td style="width: 127px">
                                Vehicle
                            </td>
                            <td>
                                <cc1:ComboBox AutoCompleteMode="Append" ID="ddlAmbulanceID" runat="server"
                                              AutoPostBack="True" DropDownStyle="DropDownList"
                                              onselectedindexchanged="ddlAmbulanceID_SelectedIndexChanged">
                                    <asp:ListItem>-Select-</asp:ListItem>
                                </cc1:ComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;
                            </td>
                            <td style="width: 229px">
                                &nbsp;
                            </td>
                            <td style="width: 127px">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                Trip Type&nbsp;
                            </td>
                            <td style="width: 229px">
                                <asp:DropDownList ID="ddlTripType" runat="server">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Destination
                            </td>
                            <td>
                                <asp:TextBox ID="txtDestinationLocation" runat="server"
                                             MaxLength="20">
                                </asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;
                            </td>
                            <td style="width: 229px">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                Start Time&nbsp;
                            </td>
                            <td style="width: 229px">
                                <asp:DropDownList ID="ddlHours" runat="server" AutoPostBack="true">
                                    <asp:ListItem Value="-1">--hh--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlMinutes" runat="server" AutoPostBack="true">
                                    <asp:ListItem Value="-1">--mm--</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Start Odo
                            </td>
                            <td>
                                <asp:TextBox ID="txtStartOdo" runat="server" MaxLength="6"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;
                            </td>
                            <td style="width: 229px">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                End Time
                            </td>
                            <td style="width: 229px">
                                <asp:DropDownList ID="ddlHours1" runat="server" AutoPostBack="true">
                                    <asp:ListItem Value="-1">--hh--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlMinutes2" runat="server" AutoPostBack="true">
                                    <asp:ListItem Value="-1">--mm--</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                            <td>
                                End Odo
                            </td>
                            <td>
                                <asp:TextBox ID="txtEndOdo" runat="server" MaxLength="6"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;
                            </td>
                            <td style="width: 229px">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;Remarks&nbsp;
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"
                                             MaxLength="50" onkeypress="return remark(event);" onkeyup="CheckLength(this,50)">
                                </asp:TextBox>

                                <asp:HiddenField ID="maxOdo" runat="server"/>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 93px">
                                &nbsp;
                            </td>
                            <td colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return validationFuelEntry();"/>
                                <asp:Button ID="btnReset" runat="server" Text="Reset"
                                            onclick="btnReset_Click"/>
                                <asp:LinkButton ID="lbtnViewHistory" runat="server"
                                                Text="View History" onclick="lbtnViewHistory_Click" Visible="False">
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
            <script type="text/javascript" language="javascript">

                function OnlyAlphabets(myfield, e, dec) {
                    var key;
                    if (window.event || e)
                        key = window.event.keyCode;
                    else return true;
                    var keychar = String.fromCharCode(key);
                    return ("!@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) <= -1;
                }


                function isNumberKey(evt) {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    return charCode <= 31 || (charCode >= 48 && charCode <= 57);
                }


                function remark(e) {
                    var keycode;
                    if (window.event || event || e) keycode = window.event.keyCode;
                    else return true;
                    return (keycode !== 34) && (keycode !== 39);
                }

                function CheckLength(text, long) {
                    var maxlength = new Number(long); // Change number to your max length.
                    if (text.value.length > maxlength) {
                        text.value = text.value.substring(0, maxlength);
                        alert(" Only " + long + " chars");

                    }
                }


                function RequiredValidation(ctrl, msg) {
                    switch (trim(ctrl.value)) {
                    case '':
                        alert(msg);
                        ctrl.focus();
                        return false;
                    default:
                        return true;
                    }
                }


                function trim(value) {
                    value = value.replace(/^\s+/, '');
                    value = value.replace(/\s+$/, '');
                    return value;

                }

                function isValidDate(subject) {
                    return !!subject.match(
                        /^(?:(0[1-9]|1[012])[\- \/.](0[1-9]|[12][0-9]|3[01])[\- \/.](19|20)[0-9]{2})$/);
                }


                function validationFuelEntry() {


                    var tripDate = document.getElementById('<%= txtTripDate.ClientID %>');
                    var id = document.getElementById('<%= ddlAmbulanceID.ClientID %>');

                    var tripType = document.getElementById('<%= ddlTripType.ClientID %>');

                    var destination = document.getElementById('<%= txtDestinationLocation.ClientID %>');

                    var startHr = document.getElementById('<%= ddlHours.ClientID %>');

                    var startMin = document.getElementById('<%= ddlMinutes.ClientID %>');

                    var startOdo = document.getElementById('<%= txtStartOdo.ClientID %>');

                    var endHr = document.getElementById('<%= ddlHours1.ClientID %>');

                    var endMin = document.getElementById('<%= ddlMinutes2.ClientID %>');

                    var endOdo = document.getElementById('<%= txtEndOdo.ClientID %>');

                    var remarks = document.getElementById('<%= txtRemarks.ClientID %>');

                    if (!RequiredValidation(tripDate, "TripDate Cannot be Blank"))
                        return false;
                    var now = new Date();
                    if (Date.parse(tripDate.value) > Date.parse(now)) {
                        alert("TripDate Date should not be greater than Current Date");
                        tripDate.focus();
                        return false;
                    }

                    var inputs = id.getElementsByTagName('input');
                    var i;
                    for (i = 0; i < inputs.length; i++) {
                        switch (inputs[i].type) {
                        case 'text':
                            if (inputs[i].value !== "" && inputs[i].value != null && inputs[i].value === "--Select--") {
                                alert('Select the Vehicle');
                                return false;
                            }
                            break;
                        }
                    }

                    switch (tripType.selectedIndex) {
                    case 0:
                        alert("Please select the TripType");
                        tripType.focus();
                        return false;
                    }

                    if (!RequiredValidation(destination, "Destination Cannot be Blank"))
                        return false;
                    switch (startHr.selectedIndex) {
                    case 0:
                        alert("Please select the StartHour");
                        startHr.focus();
                        return false;
                    }


                    switch (startMin.selectedIndex) {
                    case 0:
                        alert("Please select the StartMin");
                        startMin.focus();
                        return false;
                    }

                    if (!RequiredValidation(startOdo, "StartOdo Cannot be Blank"))
                        return false;

                    switch (endHr.selectedIndex) {
                    case 0:
                        alert("Please select the EndHr");
                        endHr.focus();
                        return false;
                    }

                    switch (endMin.selectedIndex) {
                    case 0:
                        alert("Please select the EndMin");
                        endMin.focus();
                        return false;
                    }

                    if (parseInt(startHr.value) > parseInt(endHr.value)) {
                        alert("End Time should be greater than the Start Time value");
                        endHr.focus();
                        return false;
                    }
                    switch (parseInt(startHr.value)) {
                    case parseInt(endHr.value):
                        if (parseInt(startMin.value) > parseInt(endMin.value) ||
                            parseInt(startMin.value) === parseInt(endMin.value)) {
                            alert("End Time should be greater than the Start Time value");
                            endHr.focus();
                            return false;
                        }
                        break;
                    }


                    if (!RequiredValidation(endOdo, "EndOdo Cannot be Blank"))
                        return false;

                    if (parseInt(startOdo.value) >= parseInt(endOdo.value)) {
                        alert("End Odometer value should be greater than the Start Odometer value");
                        endOdo.focus();
                        return false;
                    }

                    if (!RequiredValidation(remarks, "Remarks Cannot be Blank"))
                        return false;


                    var maxOdo = document.getElementById("<%= maxOdo.ClientID %>");


                    if (parseInt(maxOdo.value) >= parseInt(startOdo.value)) {
                        alert("Odometer value should be greater than the Previous Odometer value (Pre Odo Reading=" +
                            maxOdo.value +
                            ")");
                        startOdo.focus();
                        return false;
                    }
                    return true;
                }

            </script>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

