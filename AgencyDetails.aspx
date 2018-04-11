<%@ Page AutoEventWireup="true" CodeFile="AgencyDetails.aspx.cs" Inherits="AgencyDetails" Language="C#" MasterPageFile="~/temp.master" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script src="js/Validation.js"></script>
<script type="text/javascript">
    function validationAgencyDetails() {
        if (document.getElementById("<%= txtAgencyName.ClientID %>").value === 0) {
            alert("Please Enter Agency Name");
            document.getElementById("<%= txtAgencyName.ClientID %>").focus();
            return false;
        }
        if (document.getElementById("<%= ddlState.ClientID %>").selectedIndex === 0) {
            alert("Please Select State");
            document.getElementById("<%= ddlState.ClientID %>").focus();
            return false;
        }
        if (document.getElementById("<%= ddlDistrict.ClientID %>").selectedIndex === 0) {
            alert("Please Select District");
            document.getElementById("<%= ddlDistrict.ClientID %>").focus();
            return false;
        }
        if (document.getElementById("<%= txtAddress.ClientID %>").value === 0) {
            alert("Please Enter Address");
            document.getElementById("<%= txtAddress.ClientID %>").focus();
            return false;
        }
        if (document.getElementById("<%= txtContactNo.ClientID %>").value === 0) {
            alert("Please Enter Contact Number");
            document.getElementById("<%= txtContactNo.ClientID %>").focus();
            return false;
        }

        var phone = document.getElementById("<%= txtContactNo.ClientID %>").value;
        if (isNaN(parseInt(phone))) {
            alert("The Contact number contains illegal characters");
            document.getElementById("<%= txtContactNo.ClientID %>").focus();
            return false;
        }
        if (!((phone.length >= 10) && (phone.length <= 15))) {
            alert("The Contact number is the wrong length");
            document.getElementById("<%= txtContactNo.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtPanNo.ClientID %>").value === 0) {
            alert("Please Enter PAN");
            document.getElementById("<%= txtPanNo.ClientID %>").focus();
            return false;
        }

        if (!isValidPAN(document.getElementById("<%= txtPanNo.ClientID %>").value)) {
            document.getElementById("<%= txtPanNo.ClientID %>").value = "";
            document.getElementById("<%= txtPanNo.ClientID %>").focus();
            return false;
        }


        if (document.getElementById("<%= txtTin.ClientID %>").value === 0) {
            alert("Please Enter TIN");
            document.getElementById("<%= txtTin.ClientID %>").focus();
            return false;
        }
        return true;
    }
</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<table>
    <tr>
        <td class="rowseparator "></td>
    </tr>
    <tr>
        <td>
        <fieldset style="padding: 10px">
        <legend>Agency Details</legend>
        <asp:Panel ID="pnlagencydetails" runat="server">
        <table style="width: 100%; height: 150px;">
        <tr>
            <td align="left" style="width: 141px">
                Agency Name <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 200px">
                <asp:TextBox ID="txtAgencyName" runat="server" MaxLength="35"></asp:TextBox>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 146px">
                State <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left">
                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td align="left" style="width: 200px">
                Contact Number <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 200px">
                <asp:TextBox ID="txtContactNo" runat="server" MaxLength="15"></asp:TextBox>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 146px">
                District<span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left">
                <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td align="left" style="width: 141px">
                PAN No <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 200px">
                <asp:TextBox ID="txtPanNo" runat="server" MaxLength="10"></asp:TextBox>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 146px">
                Address <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left">
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" onKeyUp="CheckLength(this,300)"
                             onChange="CheckLength(this,300)">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td align="left" style="width: 141px">
                TIN <span style="color: Red">*</span>
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 200px">
                <asp:TextBox ID="txtTin" runat="server" MaxLength="11"></asp:TextBox>
            </td>
            <td class="columnseparator"></td>

        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td style="width: 141px">
                &nbsp;
            </td>
            <td class="columnseparator"></td>
            <td style="width: 200px">
                &nbsp;
            </td>
            <td class="columnseparator"></td>

        </tr>
        <tr>
            <td class="rowseparator"></td>
        </tr>
        <tr>
            <td style="width: 141px">
                &nbsp;
            </td>
            <td class="columnseparator"></td>
            <td style="width: 200px">
                &nbsp;
            </td>
            <td class="columnseparator"></td>
            <td align="left" style="width: 146px">
                &nbsp;
            </td>
            <td class="columnseparator"></td>
            <td align="left">
                <asp:TextBox ID="txtEdit" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td class="rowseparator"></td>
        <tr>
            <td align="center" colspan="8">
                <asp:Button ID="btnSaveAgencyDetails" runat="server" Width="55px" Height="20px" OnClick="btnSaveAgencyDetails_Click"
                            Text="Save"/>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnResetAgencyDetails" runat="server" Width="55px" Height="20px"
                            OnClick="btnResetAgencyDetails_Click" Text="Reset"/>
            </td>
        </tr>
    </tr>
</table>
</asp:Panel>
</fieldset>
</td>
</tr>
<tr>
    <td class="rowseparator "></td>
</tr>
<tr>
    <td class="rowseparator "></td>
</tr>
<tr>
    <td>
        <fieldset style="padding: 10px">
            <table style="width: 100%; height: 60px;">
                <caption>
                    <tr>
                        <td class="rowseparator "></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:GridView ID="grvAgencyDetails" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                          CellSpacing="2" CssClass="gridviewStyle" GridLines="None" OnPageIndexChanging="grvAgencyDetails_PageIndexChanging"
                                          OnRowDeleting="grvAgencyDetails_RowDeleting" OnRowEditing="grvAgencyDetails_RowEditing">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="Agency Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("AgencyID") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Agency Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("AgencyName") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCntNum" runat="server" Text='<%#Eval("ContactNum") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Address">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Address") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("CreatedDate", "{0:d}") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                            <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to DELETE"
                                                                       TargetControlID="lnkDelete">
                                            </asp:ConfirmButtonExtender>
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
                    <tr>
                        <td align="center">
                            &nbsp;
                        </td>
                    </tr>
                </caption>
            </table>
        </fieldset>
        <asp:HiddenField ID="hidAgencyId" runat="server"/>
    </td>
</tr>
<tr>
    <td class="rowseparator "></td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>


