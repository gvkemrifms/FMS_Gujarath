<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="ScheduleServiceMaster.aspx.cs" Inherits="ScheduleServiceMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="updtpnlVehMaintDet" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>
                                Schedule Service Master<br/>
                            </legend>
                            <div style="height: 246px; width: 150px; float: left"></div>
                            <table>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Manufacturer Name :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlManufactName" runat="server"
                                                          onselectedindexchanged="ddlManufactName_SelectedIndexChanged"
                                                          AutoPostBack="True"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        General Service :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtGeneralService" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Schedule Service Alert1 :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSSAlert1" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Schedule Service Alert2 :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSSAlert2" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Schedule Service Alert3 :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSSAlert3" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Schedule Service Alert4 :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSSAlert4" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                        Schedule Service Alert5 :
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSSAlert5" runat="server"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator" style="width: 176px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 176px">
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click"/>
                                    </td>

                                    <td>
                                        <asp:Button ID="btnUpdate" runat="server" text="Update" onclick="btnUpdate_Click"/>
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <div style="width: 200px; float: left">
                                </div>
                                <div style="float: left">
                                    <asp:GridView ID="gvScheduleServiceMaster" runat="server" EmptyDataText="No Records Found"
                                                  AllowSorting="True" AutoGenerateColumns="False" CssClass="gridviewStyle" CellSpacing="2"
                                                  CellPadding="4" ForeColor="#333333" GridLines="None" Width="650px" AllowPaging="True"
                                                  EnableSortingAndPagingCallbacks="True" onrowcommand="gvScheduleServiceMaster_RowCommand">
                                        <RowStyle CssClass="rowStyleGrid"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Manufacturer Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblManufacturerName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FleetManufacturer_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GSAlert">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGSAlert" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "GSAlert") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Alert 1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlert1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Alert_KMS1") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Alert 2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlert2" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Alert_KMS2") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Alert 3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlert3" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Alert_KMS3") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Alert 4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlert4" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Alert_KMS4") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Alert 5">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAlert5" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Alert_KMS5") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditService" CommandArgument=" <%# Container.DataItemIndex %>"
                                                                    Text="Edit">
                                                    </asp:LinkButton>

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="footerStylegrid"/>
                                        <PagerStyle CssClass="pagerStylegrid"/>
                                        <SelectedRowStyle CssClass="selectedRowStyle"/>
                                        <HeaderStyle CssClass="headerStyle"/>
                                    </asp:GridView>
                                </div>
                            </div>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

