<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.HRDisciplinaryActions, App_Web_m0x5b0wx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .ddlwidth {
            width: 200px;
        }
    </style>
    <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>

    <asp:UpdatePanel ID="updtpnlFinanceReceipt" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>HR Disciplinay Action<br />
                            </legend>
                            <table>
                                <tr>
                                    <td class="columnseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Vehicle No :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehicleno" runat="server"
                                            CssClass="ddlwidth" AutoPostBack="True" />
                                    </td>

                                </tr>
                                <td class="rowseparator"></td>
                                <tr>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Situation of Accident :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlSitIfAction" runat="server"
                                            OnSelectedIndexChanged="ddlSitIfAction_SelectedIndexChanged"
                                            AutoPostBack="True" CssClass="ddlwidth" />
                                    </td>

                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Cause of the Accident/Incident :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlCause" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Minor Accident(<100000rs) :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMinorAcc" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Major Accident(100000-500000rs) :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMajor" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Major loss/Total Loss :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMajorOrtotLoss" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Severe injuries to personnel :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlSevereInj" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"></td>
                                    <td>Fatal Accident :
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlFatalAcc" runat="server" CssClass="ddlwidth" />
                                    </td>
                                    <td class="rowseparator"></td>
                                </tr>
                            </table>
                            <table>

                                <tr>
                                    <td style="width: 250px"></td>
                                    <td>
                                        <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:Button runat="server" ID="btnClear" Text="Reset"
                                            OnClick="btnClear_Click" />
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

