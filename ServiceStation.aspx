<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="ServiceStation.aspx.cs" Inherits="ServiceStation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <legend align="center">
                Service Station
            </legend>
            <table align="center">
                <tr>
                    <td>
                        Vehicle Number<span style="color: Red">*</span>
                    </td>
                    <td>
                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="True"
                                      DropDownStyle="DropDownList"
                                      OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
                        </cc1:ComboBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Service Station Name<span style="color: Red">*</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtServiceSrationName" CssClass="search_3" runat="server"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        District<span style="color: Red">*</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDistricts" CssClass="search_3" runat="server" Enabled="false"/>
                    </td>
                </tr>
            </table>
            <div align="center">
                <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="form-submit-button" OnClick="btnSave_Click" OnClientClick="return validationFuelEntry();"/>
                <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="form-reset-button" OnClientClick="return validationFuelEntry();"
                            OnClick="btnUpdate_Click"/>
            </div>
            <br/>
            <div align="center">
                <asp:GridView ID="gvServiceStationDetails" Visible="false" runat="server" EmptyDataText="No records found"
                              AllowSorting="true" AutoGenerateColumns="false" CssClass="gridviewStyle" CellSpacing="2"
                              CellPadding="4" ForeColor="#333333" GridLines="Both" Width="630px" AllowPaging="true"
                              EnableSortingAndPagingCallbacks="true"
                              OnRowCommand="gvServiceStationDetails_RowCommand"
                              OnPageIndexChanging="gvServiceStationDetails_PageIndexChanging">
                    <RowStyle CssClass="rowStyleGrid"/>
                    <Columns>
                        <asp:TemplateField HeaderText="Station">
                            <ItemTemplate>
                                <asp:Label ID="lblServiceStation" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ServiceStation_Name") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="District">
                            <ItemTemplate>
                                <asp:Label ID="lblDistricts" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ds_lname") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VehicleNumber">
                            <ItemTemplate>
                                <asp:Label ID="lblVehNum" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'>
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
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="MainDelete" CommandArgument=" <%# Container.DataItemIndex %>"
                                                Text="Delete">
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
        </td>
        </tr>
        </table>

        <script type="text/javascript" language="javascript">

            function validationFuelEntry() {

                var vehicleNumber = document.getElementById('<%= ddlVehicleNumber.ClientID %>').control
                    ._textBoxControl.value;
                if (vehicleNumber === '--Select--') {
                    alert("Please select the Vehicle");
                    return false;
                }

                if (document.getElementById("<%= txtServiceSrationName.ClientID %>").value == 0) {
                    alert("Service Station Cannot be Blank");
                    document.getElementById("<%= txtServiceSrationName.ClientID %>").focus();
                    return false;
                }


                var districts = document.getElementById('<%= ddlDistricts.ClientID %>');

                if (districts.selectedIndex === 0) {
                    alert("Please select the District");
                    districts.focus();
                    return false;
                }
                return true;
            }

            function OnlyAlphabets(myfield, e, dec) {
                var key;
                if (window.event)
                    key = window.event.keyCode;
                else if (e)
                    key = e.which;
                else
                    return true;
                var keychar = String.fromCharCode(key);
                if ((("!@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) > -1))
                    return false;
                else
                    return true;
            }

        </script>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>