<%@ Page AutoEventWireup="true" CodeFile="BatteryDetails.aspx.cs" Inherits="BatteryDetails" Language="C#" MasterPageFile="~/temp.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolKit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">

                function validationBatteryDetails() {
                    switch (document.getElementById("<%= txtBatteryItemCode.ClientID %>").value) {
                    case '':
                        alert("Please Enter Battery Item Code");
                        document.getElementById("<%= txtBatteryItemCode.ClientID %>").focus();
                        return false;
                    }
                    switch (document.getElementById("<%= txtBatteryMake.ClientID %>").value) {
                    case '':
                        alert("Please Enter Battery Make");
                        document.getElementById("<%= txtBatteryMake.ClientID %>").focus();
                        return false;
                    }
                    switch (document.getElementById("<%= txtBatteryModel.ClientID %>").value) {
                    case '':
                        alert("Please Enter Battery Model");
                        document.getElementById("<%= txtBatteryModel.ClientID %>").focus();
                        return false;
                    }
                    switch (document.getElementById("<%= txtBatteryCapacity.ClientID %>").value) {
                    case '':
                        alert("Please Enter Battery Capacity");
                        document.getElementById("<%= txtBatteryCapacity.ClientID %>").focus();
                        return false;
                    }

                    switch (document.getElementById("<%= txtBatteryExpiryDate.ClientID %>").value) {
                    case '':
                        alert("Please Enter Battery Expiry Date");
                        document.getElementById("<%= txtBatteryExpiryDate.ClientID %>").focus();
                        return false;
                    }

                    var dcDate = document.getElementById('<%= txtBatteryExpiryDate.ClientID %>');

                    if (trim(dcDate.value) !== "" && !isValidDate(dcDate.value)) {
                        alert("Enter the Valid Date");
                        dcDate.focus();
                        return false;
                    }

                    var now = new Date();
                    if (Date.parse(dcDate.value) <= Date.parse(now)) {
                        alert("Expiry Date should be greater than Current Date");
                        dcDate.focus();
                        return false;
                    }

                    return true;
                }


            </script>

            <table align="center" id="table1">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td style="height: 200px">
                        <fieldset style="padding: 10px;">
                            <legend>Battery Details</legend>
                            <asp:Panel runat="server">
                                <table id="table2" align="center">
                                    <tr>
                                        <td>
                                            <table align="center">
                                                <tr>
                                                    <td style="width: 150px" align="left">
                                                        Battery Item Code <span style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryItemCode" runat="server" CssClass="search_3" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px" align="left">
                                                        Make <span style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 23px">
                                                        <asp:TextBox ID="txtBatteryMake" runat="server" CssClass="search_3" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px" align="left">
                                                        Model <span style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryModel" runat="server" CssClass="search_3" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px">
                                                        Capacity <span style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryCapacity" runat="server" CssClass="search_3" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td>Battery Expiry Date <span style="color: Red">*</span></td>
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="txtBatteryExpiryDate" runat="server" onkeypress="return false" MaxLength="20" oncut="return false;" CssClass="search_3" onpaste="return false;" oncopy="return false;"></asp:TextBox>
                                                        <ajaxToolKit:CalendarExtender runat="server" TargetControlID="txtBatteryExpiryDate"
                                                                                      Format="MM/dd/yyyy" PopupButtonID="imgBtnCalendarInvoiceDate">
                                                        </ajaxToolKit:CalendarExtender>
                                                    </td>
                                                    <td style="width: 51px">
                                                        <asp:ImageButton ID="imgBtnCalendarInvoiceDate" runat="server" CssClass="cal_Theme1" alt="" src="images/Calendar.gif"
                                                                         Style="vertical-align: top"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="columnseparator">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 41px">
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnBatterySave" runat="server" CssClass="form-submit-button"
                                                                    OnClick="btnBatterySave_Click1"
                                                                    OnClientClick="return validationBatteryDetails();" Text="Save" Width="55px"/>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button runat="server"
                                                                    CausesValidation="false" CssClass="form-submit-button" OnClick="btnManufacturerReset_Click"
                                                                    Text="Reset" Width="55px"/>
                                                        <input runat="server" type="hidden"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <br/>
                <tr>
                    <td>
                        <fieldset style="padding: 10px;">
                            <asp:GridView ID="grvBatteryDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                          CellPadding="3" CellSpacing="2" GridLines="None" CssClass="gridviewStyle" OnRowEditing="grvBatteryDetails_RowEditing"
                                          PageSize="5" OnPageIndexChanging="grvBatteryDetails_PageIndexChanging" BorderWidth="1px" BorderStyle="Inset" BorderColor="brown">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblbatId" runat="server" Text='<%#Eval("Battery_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BatteryItemCode">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryItemCode" runat="server" Text='<%#Eval("Battery_Item_Code") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Make">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryMake" runat="server" Text='<%#Eval("Make") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Model">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryModel" runat="server" Text='<%#Eval("Model") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Capacity">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatteryCapacity" runat="server" Text='<%#Eval("CapaCity") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Creation_Date", "{0:d}") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ExpiryDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExpiryDate" runat="server" Text='<%#Eval("BatteryExpiryDate", "{0:d}") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" CommandName="Edit" Text="Edit"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid"/>
                                <PagerStyle CssClass="pagerStylegrid"/>
                                <SelectedRowStyle CssClass="selectedRowStyle"/>
                                <HeaderStyle CssClass="headerStyle"/>
                            </asp:GridView>
                        </fieldset>
                    </td>
                </tr>
            </table>
            <br/>
            <asp:HiddenField ID="hidManId" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>