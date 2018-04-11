<%@ Page Language="C#" masterpagefile="~/temp.master" AutoEventWireup="true" CodeFile="MaintenanceWorksMaster.aspx.cs" Inherits="MaintenanceWorksMaster" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script src="js/Validation.js"></script>
<script language="javascript" type="text/javascript">
    function validationMaintenanceWorksMaster() {
        switch (document.getElementById("<%= ddlServiceGroupName.ClientID %>").selectedIndex) {
        case 0:
            alert("Please Select Service Group Name");
            document.getElementById("<%= ddlServiceGroupName.ClientID %>").focus();
            return false;
        }

        switch (document.getElementById("<%= ddlMaintenanceManufacturerName.ClientID %>").selectedIndex) {
        case 0:
            alert("Please Enter Manufacturer Name");
            document.getElementById("<%= ddlMaintenanceManufacturerName.ClientID %>").focus();
            return false;
        }
        switch (document.getElementById("<%= txtServiceName.ClientID %>").value) {
        case 0:
            alert("Please Enter Service Name");
            document.getElementById("<%= txtServiceName.ClientID %>").focus();
            return false;
        }
        switch (document.getElementById("<%= txtCostGrade.ClientID %>").value) {
        case 0:
            alert("Please Enter Cost For A Grade");
            document.getElementById("<%= txtCostGrade.ClientID %>").focus();
            return false;
        }
        switch (document.getElementById("<%= txtCostOtherGrade.ClientID %>").value) {
        case 0:
            alert("Please Enter Cost For Other Grade");
            document.getElementById("<%= txtCostOtherGrade.ClientID %>").focus();
            return false;
        }
        return true;
    }
</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table>
            <tr>
                <td class="rowseparator"></td>
            </tr>
            <tr>
                <td>
                    <fieldset style="padding: 10px">
                        <legend>Maintenance Works Master</legend>
                        <asp:Panel ID="pnlMaintenanceWorksMaster" runat="server">
                            <table align="center">
                                <tr>
                                    <td align="left">
                                        Aggregates <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlServiceGroupName" runat="server" Height="20px" Width="127px"
                                                          AutoPostBack="True" OnSelectedIndexChanged="ddlServiceGroupName_SelectedIndexChanged">
                                            <asp:ListItem></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Manufacturer Name <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMaintenanceManufacturerName" runat="server" AutoPostBack="true"
                                                          Height="18px" Width="120px"
                                                          OnSelectedIndexChanged="ddlMaintenanceManufacturerName_SelectedIndexChanged"/>
                                        &nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Categories <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtSSName" runat="server" Height="18px" onkeypress="return OnlyAlphabets(event)"></asp:TextBox>
                                        &nbsp;&nbsp;
                                        <asp:DropDownList ID="ddlSSName" runat="server" Visible="false" Height="20px" Width="127px"/>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:LinkButton runat="server" ID="linkCat" Text="Add existing"
                                                        OnClick="linkCat_Click"/>
                                        <asp:LinkButton runat="server" ID="linkNew" Text="Add New" OnClick="linkNew_Click"
                                                        Visible="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>

                                <tr>
                                    <td align="left">
                                        Sub Categories <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtServiceName" runat="server" Height="18px" onkeypress="return OnlyAlphabets(e)"></asp:TextBox>
                                        &nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Cost For A Grade <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtCostGrade" runat="server" Height="18px" MaxLength="10" onkeypress="return isDecimalNumberKey(event)"></asp:TextBox>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Cost Other Than A Grade <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtCostOtherGrade" runat="server" Height="18px" MaxLength="10" onkeypress="return isDecimalNumberKey(event)"></asp:TextBox>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Time Taken(In Mins) <span style="color: Red">*</span> &nbsp;
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtTimeTaken" runat="server" Height="18px" MaxLength="5" onkeypress="return isDecimalNumberKey(event) "></asp:TextBox>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="3">
                                        <asp:Button ID="btnSaveMaintenanceWorksMaster" runat="server" Text="Save" OnClick="btnSaveMaintenanceWorksMaster_Click"/>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnResetMaintenanceWorksMaster" runat="server" Text="Reset" OnClick="btnResetMaintenanceWorksMaster_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td class="rowseparator"></td>
            </tr>
            <tr>
                <td>
                    <fieldset style="padding: 10px">
                        <asp:GridView ID="grvMaintenanceWorksMasterDetails" runat="server" AllowPaging="True"
                                      PageSize="5" AutoGenerateColumns="False" CellPadding="3" CellSpacing="2" GridLines="None"
                                      CssClass="gridviewStyle" OnRowEditing="grvMaintenanceWorksMasterDetails_RowEditing"
                                      OnPageIndexChanging="grvMaintenanceWorksMasterDetails_PageIndexChanging">
                            <RowStyle CssClass="rowStyleGrid"/>
                            <Columns>
                                <asp:TemplateField HeaderText="Aggregates">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceGroupName" runat="server" Text='<%#Eval("Aggregates") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Id">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceId" runat="server" Text='<%#Eval("Service_Id") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Categories">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubServiceName" runat="server" Text='<%#Eval("Categories") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub Categories">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubCategories" runat="server" Text='<%#Eval("Sub Categories") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cost">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServiceName" runat="server" Text='<%#Eval("Cost") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Time Taken(In Mins)">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTimeTaken" runat="server" Text='<%#Eval("Time_Taken") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Creation Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Creation_Date", "{0:d}") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Edit"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="footerStylegrid"/>
                            <PagerStyle CssClass="pagerStylegrid"/>
                            <SelectedRowStyle CssClass="selectedRowStyle"/>
                            <HeaderStyle CssClass="headerStyle"/>
                        </asp:GridView>
                    </fieldset>
                    <asp:HiddenField ID="hidWorksMasterId" runat="server"/>
                </td>
            </tr>
            <tr>
                <td class="rowseparator"></td>
            </tr>
            <tr>
                <td class="rowseparator"></td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>