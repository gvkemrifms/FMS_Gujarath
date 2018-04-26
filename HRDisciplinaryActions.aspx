<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="HrDisciplinaryActions.aspx.cs" Inherits="HrDisciplinaryActions" %>
<%@ Reference Page="~/AccidentReport.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="Scripts/jquery.validate.min.js"></script>
    <script src="js/js/JqueryWrapper.js"></script>
    <style type="text/css">
        .ddlwidth { width: 200px; }
    </style>
    <asp:UpdatePanel ID="updtpnlFinanceReceipt" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                    <fieldset style="padding: 10px">
                    <legend>
                        HR Disciplinay Action<br/>
                    </legend>
                    <table>
                    <tr>
                        <td class="columnseparator"></td>
                    </tr>                   
                    <tr>
                        <td style="width: 100px"></td>
                        <td>
                            Vehicle No :
                        </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlVehicleno" runat="server"
                                              CssClass="ddlwidth"/>
                        </td>

                    </tr> 
                    <tr>
                    <td class="rowseparator"></td>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Situation of Accident : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlSitIfAction" runat="server"  CssClass="ddlwidth" AutoPostBack="True" OnSelectedIndexChanged="ddlSitIfAction_SelectedIndexChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Cause Of Accident </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlCause" runat="server" CssClass="ddlwidth"/>
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Minor Accident(0-100000rs): </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlMinor" runat="server" CssClass="ddlwidth" onChange="javascript:MinorfilterChanged()" />
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>                    
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Major Accident(100000-500000rs) : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlMajor" runat="server" CssClass="ddlwidth" onChange="javascript:MajorfilterChanged()" />
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Major loss/Total Loss : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlMajorOrtotLoss" runat="server" CssClass="ddlwidth"/>
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Severe injuries to personnel : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlSevereInj" runat="server" CssClass="ddlwidth"/>
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Fatal Accident : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlFatalAcc" runat="server" CssClass="ddlwidth"/>
                        </td>
                        <td class="rowseparator"></td>
                    </tr>
                </tr>
            </table>
            <table>

                <tr>
                    <td style="width: 250px"></td>
                    <td>
                        <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" OnClientClick="if(!ValidatePage()) {return false;}"/>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <asp:Button runat="server" ID="btnClear" Text="Reset"
                                    OnClick="btnClear_Click"/>
                    </td>
                </tr>
            </table>
        </fieldset>
        </td>
        </tr>
        </table>
            <script type="text/javascript">
                function commonMajor() {
                    var ddlMajorAccident = $('#<%= ddlMajor.ClientID %> option:selected').text().toLowerCase();
                    if (ddlMajorAccident !== '-- select --') {
                        return alert("Selected Accident Type(Minor)");
                    }
                    return true;
                }
                function commonMinor() {
                    var ddlMinorAccident = $('#<%= ddlMinor.ClientID %> option:selected').text().toLowerCase();
                    if (ddlMinorAccident !== '-- select --') {
                        return alert("Selected Accident Type(Major)");
                    }
                    return true;
                }
                function MajorfilterChanged() {
                    if ($('#<%= ddlMajor.ClientID %> option:selected').text().toLowerCase() !== '-- select --')
                        $('#<%= ddlMinor.ClientID %>').attr("disabled", true);
                    else                               
                        $('#<%= ddlMinor.ClientID %>').prop("disabled", false);

                    commonMinor();
                }
                function MinorfilterChanged() 

                {
                    if ($('#<%= ddlMinor.ClientID %> option:selected').text().toLowerCase() !== '-- select --')
                        $('#<%= ddlMajor.ClientID %>').attr("disabled", true);
                    else
                        $('#<%= ddlMajor.ClientID %>').prop("disabled", false);
                    commonMajor();
                }
                
               
                function ValidatePage() {
                    var ddlVehicle = $('#<%= ddlVehicleno.ClientID %> option:selected').text().toLowerCase();
                    if (ddlVehicle === '--select--') {
                        return alert("Please select Vehicle");
                    }
                    var ddlSituation = $('#<%= ddlSitIfAction.ClientID %> option:selected').text().toLowerCase();
                    if (ddlSituation === '-- select --') {
                        return alert("Please select situation of Accident");

                    }
                    var ddlCauseofAccident = $('#<%= ddlCause.ClientID %> option:selected').text().toLowerCase();
                    if (ddlCauseofAccident === '--select--') {
                        return alert("Please select Cause of Accident");
                    }
                    var ddlMajorLoss = $('#<%= ddlMajorOrtotLoss.ClientID %> option:selected').text().toLowerCase();
                    if (ddlMajorLoss === '-- select --') {
                        return alert("Please select MajorLoss Field");
                    }
                    if ($('#<%= ddlMinor.ClientID %> option:selected').text().toLowerCase() === "-- select --" &&
                        $('#<%= ddlMajor.ClientID %> option:selected').text().toLowerCase() === "-- select --")
                        return (alert("Please select Type Of Accident"));
                    else

                    return true;
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>