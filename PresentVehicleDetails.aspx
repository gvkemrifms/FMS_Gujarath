<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.history.PresentVehicleDetails, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Wise Record</legend>
                <table>
                    <tr>
                        <td class="rowseparator">
                            <div style="overflow: scroll; height: 500px;">
                                <asp:Accordion ID="Accordion_VehicleNumber" runat="server" Width="650px" HeaderCssClass="accordionHeader"
                                    ContentCssClass="accordionContent" AutoSize="Fill" FadeTransitions="true" TransitionDuration="50">
                                    <HeaderTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <table cellpadding="2" cellspacing="2" width="600px">
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    District:
                                                </td>
                                                <td class="columnseparator">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblVehicleID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleID") %>'
                                                        Visible="false"></asp:Label>
                                                    <asp:Label ID="lblDistrict" runat="server"><%#DataBinder.Eval(Container.DataItem, "District")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblRoadTaxStart" runat="server">RoadTax StartDate: <%#DataBinder.Eval(Container.DataItem, "RT Start Date")%></asp:Label>
                                                </td>
                                                <td class="columnseparator">
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblRoadTaxEnd" runat="server">RoadTax End Date: <%#DataBinder.Eval(Container.DataItem, "RT End Date")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPucStartDate" runat="server">Pollution Under Control Start Date: <%#DataBinder.Eval(Container.DataItem, "PUC Start Date")%></asp:Label>
                                                </td>
                                                <td class="columnseparator">
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPucEndDate" runat="server">Pollution Under Control End Date: <%#DataBinder.Eval(Container.DataItem, "PUC End Date")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Label1" runat="server">FitnessRenewal Start Date: <%#DataBinder.Eval(Container.DataItem, "FR Start Date")%></asp:Label>
                                                </td>
                                                <td class="columnseparator">
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Label2" runat="server">FitnessRenewal End Date: <%#DataBinder.Eval(Container.DataItem, "FR End Date")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Label3" runat="server">Vehicle Insurance Start Date: <%#DataBinder.Eval(Container.DataItem, "VI Start Date")%></asp:Label>
                                                </td>
                                                <td class="columnseparator">
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="Label4" runat="server">Vehicle Insurance End Date: <%#DataBinder.Eval(Container.DataItem, "VI End Date")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap" colspan="3">
                                                    <asp:Label ID="Label5" runat="server">Latest Fuel Entry Date: <%#DataBinder.Eval(Container.DataItem, "Fuel Entry Date")%></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="rowseparator" colspan="5">
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:Accordion>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

