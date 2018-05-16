<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="RoadTax.aspx.cs" Inherits="RoadTax" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function validation() {
            var roadTaxValidityStartDate = document.getElementById('<%= txtRoadTaxValidityStartDate.ClientID %>');
            var roadTaxValidityPeriod = document.getElementById('<%= ddlRoadTaxValidityPeriod.ClientID %>');
            var vehicleRtaCircle = document.getElementById('<%= txtVehicleRTACircle.ClientID %>');
            var roadTaxReceiptNo = document.getElementById('<%= txtRoadTaxReceiptNo.ClientID %>');
            var roadTaxFee = document.getElementById('<%= txtRoadTaxFee.ClientID %>');
            var vehicleRegistrationDate = document.getElementById('<%= vehicleRegistrationDate.ClientID %>');
            var now = new Date();
            var ddlVehicle = $('#<%= ddlVehicleNumber.ClientID %> option:selected').text().toLowerCase();
            if (ddlVehicle === '--select--') {
                alert("Please select Vehicle");
                return false;
            }


            if (!RequiredValidation(roadTaxValidityStartDate, "RoadTax Validity Start Date Cannot be Blank"))
                return false;

            if (!isValidDate(roadTaxValidityStartDate.value)) {
                alert("Enter Valid Road Tax Validity Start Date");
                roadTaxValidityStartDate.focus();
                return false;
            }

            if (Date.parse(roadTaxValidityStartDate.value) > Date.parse(now)) {
                alert("Road Tax Validity Start Date should not be greater than Current Date");
                roadTaxValidityStartDate.focus();
                return false;
            }

            if (Date.parse(roadTaxValidityStartDate.value) < Date.parse(vehicleRegistrationDate.value)) {
                alert("Road Tax Validity Start Date should be greater than Registration Date.(Registration Date-" +
                    vehicleRegistrationDate.value +
                    ")");
                roadTaxValidityStartDate.focus();
                return false;
            }

            switch (roadTaxValidityPeriod.selectedIndex) {
            case 0:
                alert("Please select Road Tax Validity Period");
                roadTaxValidityPeriod.focus();
                return false;
            }

            if (vehicleRtaCircle)
                if (!RequiredValidation(vehicleRtaCircle, "Vehicle RTA Circle Cannot be Blank"))
                    return false;

            if (roadTaxReceiptNo)
                if (!RequiredValidation(roadTaxReceiptNo, "RoadTax Receipt No Cannot be Blank"))
                    return false;

            if (roadTaxFee)
                if (!RequiredValidation(roadTaxFee, "RoadTax Fee Cannot be Blank"))
                    return false;
            return true;
        }

    </script>
    <asp:UpdatePanel ID="upPanel" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                function pageLoad() {
                    $('#<%= ddlVehicleNumber.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });

                }
            </script>
            <table align="center">
                <tr>
                    <td>
                        <asp:Panel ID="pnlRoadtax" runat="server">
                            <table align="center">

                                <tr>
                                    <td>
                                        Vehicle Number<span style="color: Red">*</span>
                                    </td>
                                    <td >
                                        <asp:DropDownList ID="ddlVehicleNumber" class="text1" runat="server" Width="150px" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged"
                                                          AutoPostBack="True">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="0">Dummy</asp:ListItem>

                                        </asp:DropDownList>

                                        <asp:TextBox ID="txtVehicleNumber" class="text1" runat="server" ReadOnly="True" Visible="False"
                                                     Width="145px">
                                        </asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        Road Tax Validity Start Date<span style="color: Red">*</span>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtRoadTaxValidityStartDate" CssClass="search_3" class="text1" AutoPostBack="true" runat="server"
                                                     Width="145px" OnTextChanged="txtRoadTaxValidityStartDate_TextChanged" onkeypress="return false"
                                                     oncut="return false;" onpaste="return false;">
                                        </asp:TextBox>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="imgBtnRoadTaxValidityStartDate" runat="server" Style="vertical-align: top"
                                                         alt="" src="images/Calendar.gif"/>
                                        <cc1:CalendarExtender runat="server" TargetControlID="txtRoadTaxValidityStartDate"
                                                              PopupButtonID="imgBtnRoadTaxValidityStartDate" Format="MM/dd/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>

                                    <td >
                                        Road Tax Validity Period<span style="color: Red">*</span>
                                    </td>
                                    <td >
                                        <asp:DropDownList ID="ddlRoadTaxValidityPeriod" CssClass="search_3" class="text1" runat="server" Width="150px" OnSelectedIndexChanged="ddlRoadTaxValidityPeriod_SelectedIndexChanged"
                                                          AutoPostBack="True">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                            <asp:ListItem Value="3">3 Month</asp:ListItem>
                                            <asp:ListItem Value="6">6 Month</asp:ListItem>
                                            <asp:ListItem Value="9">9 Month</asp:ListItem>
                                            <asp:ListItem Value="12">1 Year</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Road Tax Validity End Date<span style="color: Red">*</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRoadTaxValidityEndDate" class="text1" CssClass="search_3" runat="server" Width="145px" BackColor="DarkGray"
                                                     ReadOnly="True">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <asp:CheckBox ID="chkbxTaxExempted" class="text1" runat="server" Text="Tax Exempted" AutoPostBack="True"
                                                      OnCheckedChanged="chkbxTaxExempted_CheckedChanged"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <asp:Label ID="lblVehicleRTACircle" runat="server" Text="Vehicle RTA Circle"></asp:Label>
                                        <asp:Label ID="lblVehRTACirStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtVehicleRTACircle" CssClass="search_3" class="text1" runat="server" Width="145px" MaxLength="35"
                                                     onkeypress="return alphanumeric_only(event);">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <asp:Label ID="lblRoadTaxReceiptNo" runat="server" Text="Road Tax Receipt No."></asp:Label>
                                        <asp:Label ID="lblRoadTaxReceiptNoStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtRoadTaxReceiptNo" CssClass="search_3" class="text1" runat="server" Width="145px" MaxLength="15"
                                                     onkeypress="return alphanumeric_only(event);">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>

                                    <td >
                                        <asp:Label ID="lblRoadTaxFee" runat="server" Text="Road Tax Fee"></asp:Label>
                                        <asp:Label ID="lblRoadTaxFeeStar" runat="server" ForeColor="Red" Text="*"></asp:Label>
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtRoadTaxFee" CssClass="search_3" class="text1" runat="server" Width="145px" onkeypress="return numericOnly(event);"
                                                     MaxLength="9">
                                        </asp:TextBox>
                                    </td>
                                </tr>

                                <tr>

                                    <td >
                                        <asp:Button ID="btSave" runat="server" CssClass="form-submit-button" Text="Save" OnClick="btSave_Click" OnClientClick="if (!validation()) return false;"/>
                                    </td>
                                    <td >
                                        <asp:Button ID="btReset" runat="server" Text="Reset" CssClass="form-reset-button" OnClick="btReset_Click"/>
                                    </td>
                                    <td >
                                        <asp:LinkButton runat="server" Visible="False">View History</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <br/>
                <tr align="center">
                    <td>
                        <asp:GridView ID="gvRoadTax" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                      Width="630px" style="margin-top: 20px" ForeColor="#333333" GridLines="None" OnRowCommand="gvRoadTax_RowCommand"
                                      OnRowDataBound="gvRoadTax_RowDataBound" AllowPaging="True" EmptyDataText="No Records Found"
                                      OnPageIndexChanging="gvRoadTax_PageIndexChanging" CssClass="table table-striped table-bordered table-hover" PagerStyle-CssClass="pager"
                                      HeaderStyle-ForeColor="#337ab7" CellSpacing="2">
                            <RowStyle CssClass="rows"/>
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleNumber") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="RTValidityStartDate" HeaderText="RTValidity StartDate"
                                                DataFormatString="{0:d}"/>
                                <asp:TemplateField HeaderText="RTValidity Period">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTValidityPeriod" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem, "RTValidityPeriod") %>'></asp:Label>
                                        <asp:Label ID="lblRTValidityPeriodText" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="RTValidityEndDate" HeaderText="RTValidity EndDate" DataFormatString="{0:d}"/>
                                <asp:TemplateField HeaderText="Vehicle RTA Circle">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleRTACircle" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VehicleRTACircle") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RT Receipt No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTReceiptNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RTReceiptNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Road Tax Fee">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRTFee" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RTFee") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="roadTaxEdit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "RoadTaxID") %>'
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
                    </td>
                </tr>
                <asp:HiddenField ID="vehicleRegistrationDate" runat="server"/>
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>