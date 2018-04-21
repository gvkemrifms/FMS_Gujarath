<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="KmplMaster.aspx.cs" Inherits="KmplMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>
    <script src="js/Validation.js"></script>
    <asp:UpdatePanel ID="updtpnlServiceStation" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                        <legend>
                            KMPL<br/>
                        </legend>
                        <table>
                            <tr>
                                <td>
                                    Vehicle Number
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td>
                                    <cc1:ComboBox AutoCompleteMode="Append" name="vehicleNumber" ID="ddlVehNumber" runat="server" AutoPostBack="true"
                                                  onselectedindexchanged="ddlVehNumber_SelectedIndexChanged" DropDownStyle="DropDownList">

                                    </cc1:ComboBox>

                                </td>
                            </tr>

                            <tr>
                                <td class="rowseparator">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    KMPL
                                </td>
                                <td class="columnseparator">
                                </td>
                                <td>
                                    <asp:TextBox ID="txtKMPL" runat="server"/>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <div style="float: left; width: 300px;">
                            </div>
                            <div>
                                <asp:Button runat="server" ID="btnUpdate" Text="Update"
                                            OnClientClick="if(!validationFuelEntry()) return false;" onclick="btnUpdate_Click"/>
                            </div>
                        </div>
                        <div>
                            <div style="float: left; width: 200px;">
                            </div>
                            <div style="float: left">
                                <asp:GridView ID="gvVehKmplDetails" runat="server" EmptyDataText="No records found" PageSize="20"
                                              AllowSorting="true" AutoGenerateColumns="false" CssClass="gridviewStyle" CellSpacing="2"
                                              CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="true"
                                              EnableSortingAndPagingCallbacks="true"
                                              onrowcommand="gvVehKmplDetails_RowCommand"
                                              onpageindexchanging="gvVehKmplDetails_PageIndexChanging">
                                    <RowStyle CssClass="rowStyleGrid"/>
                                    <Columns>
                                        <asp:TemplateField HeaderText="VehicleNumber">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVehNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="KMPL">
                                            <ItemTemplate>
                                                <asp:Label ID="lblKMPL" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "KMPL") %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="MainEdit" CommandArgument=" <%# Container.DataItemIndex %>"
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
                    </td>
                </tr>
            </table>

            <script type="text/javascript" language="javascript">

                function validationFuelEntry() {
                    var districts = document.getElementById("<%= ddlVehNumber.ClientID %>").control._textBoxControl.value;
                    switch (districts) {
                    case '--Select--':
                      return  alert("Please Select the VehicleNumber");
                      
                    }
                    switch (document.getElementById("<%= txtKMPL.ClientID %>").value) {
                        case '':
                            document.getElementById("<%= txtKMPL.ClientID %>").focus();
                        return alert("KMPL Should not be Blank");
                    }

                  
                    return true;
                }
            </script>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>