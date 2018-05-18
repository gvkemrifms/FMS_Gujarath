<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/temp.master" CodeFile="VehiclemaintenanceNonoffroad.aspx.cs" Inherits="VehiclemaintenanceNonoffroad" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .WrapStyle TD { word-break: break-all; }
    </style>
    <script src="js/Validation.js"></script>
    <script language="javascript" type="text/javascript">

        function Validation() {
            var vehiclenoddl = document.getElementById('<%= ddlVehicles.ClientID %>');
            if (vehiclenoddl && vehiclenoddl.selectedIndex === 0) {
                alert("Please select Vehicle number");
                vehiclenoddl.focus();
                return false;
            }
            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                function pageLoad() {
                    $('#<%= ddlVehicles.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                    $('#<%= ddlMaintenanceType.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                    $('#<%= ddlVendorName.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                }
            </script>

            <fieldset style="padding: 10px">
                <legend align="center" style="color: brown">Vehicle Non OffRoad</legend>
                <table align="center">
                    <tr>
                        <td >
                            Vehicle Number<span style="color: Red">*</span>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlVehicles" runat="server" AutoPostBack="true" Width="150px" OnSelectedIndexChanged="ddlVehicles_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            District<span style="color: Red">*</span>
                        </td>
                        <td >
                            <asp:TextBox runat="server" ID="txtDistrict" Width="150px" Enabled="False"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Location<span style="color: Red">*</span>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtLocation" Enabled="False"/>
                        </td>
                    </tr>


                </table>
                <asp:Panel runat="server" style="margin-top: 50px">
                    <fieldset style="padding: 0px 0px 0px 0px">
                        <legend align="center">Maintenance Details </legend>

                        <table align="center">
                            <tr>
                                <td>
                                    <asp:Label Text="Maintenance Type" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMaintenanceType" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label Text="Maintenance Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMaintenanceDate" runat="server"
                                                 onkeypress="return false">
                                    </asp:TextBox>
                                    <cc1:CalendarExtender runat="server" Format="dd/MM/yyyy"
                                                          PopupButtonID="imgBtnQuotationDate" TargetControlID="txtMaintenanceDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Vendor Name" runat="server"></asp:Label>
                                </td>

                                <td>
                                    <asp:DropDownList ID="ddlVendorName" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Bill Number" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillNo" runat="server" MaxLength="10"
                                                 onkeypress="return numeric(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Bill Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillDate" runat="server"
                                                 onkeypress="return false">
                                    </asp:TextBox>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                                                          PopupButtonID="imgBtnQuotationDate" TargetControlID="txtBillDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Part Code" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPartCode" runat="server" MaxLength="10"
                                                 onkeypress="return numeric_only(event);">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Item Description" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtItemDesc" runat="server"
                                                 onkeypress="return alpha_only_withspace(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Text="Item Quantity" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtQuant" runat="server" MaxLength="5"
                                                 onkeypress="return numeric(event)">
                                    </asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label Text="Bill Amount" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBillAmount" runat="server" MaxLength="12" onkeypress="return isDecimalNumberKey(event);"></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <asp:Button runat="server" CssClass="form-submit-button" Text="Save" Width="52px"
                                                OnClick="btnSave_Click" OnClientClick="return Validation()"/>
                                </td>
                                <td>
                                    <asp:Button runat="server" CssClass="form-reset-button" Text="Reset"
                                                OnClick="btnSPReset_Click"/>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br/>
                </asp:Panel>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>