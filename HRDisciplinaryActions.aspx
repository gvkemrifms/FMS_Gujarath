<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="HrDisciplinaryActions.aspx.cs" Inherits="HrDisciplinaryActions" %>
<%@ Reference Page="~/AccidentReport.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                              CssClass="ddlwidth" AutoPostBack="True"/>
                        </td>

                    </tr>
                    <tr>
                    <td class="rowseparator"></td>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Situation of Accident : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlSitIfAction" runat="server" AutoPostBack="True" CssClass="ddlwidth" OnSelectedIndexChanged="ddlSitIfAction_SelectedIndexChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td>Cause of the Accident/Incident : </td>
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
                        <td>Minor Accident(&lt;100000rs) : </td>
                        <td class="columnseparator"></td>
                        <td>
                            <asp:DropDownList ID="ddlMinorAcc" runat="server" CssClass="ddlwidth"/>
                        </td>
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
                            <asp:DropDownList ID="ddlMajor" runat="server" CssClass="ddlwidth"/>
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
                        <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click"/>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>