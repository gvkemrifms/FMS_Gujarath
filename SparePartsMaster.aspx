﻿<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="SparePartsMaster.aspx.cs" Inherits="SparePartsMaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function validation() {
            var fldSparePartName = document.getElementById('<%= txtSparePartName.ClientID %>');
            var fldManufacturerSpareId = document.getElementById('<%= txtManufacturerSpareID.ClientID %>');
            var fldManufacturerId = document.getElementById('<%= ddlManufacturerID.ClientID %>');
            var fldSparePartGroupId = document.getElementById('<%= txtSparePartGroupID.ClientID %>');
            var fldGroupName = document.getElementById('<%= txtGroupName.ClientID %>');
            var fldCost = document.getElementById('<%= txtCost.ClientID %>');

            if (fldSparePartName)
                if (!RequiredValidation(fldSparePartName, "Please enter Spare Part Name"))
                    return false;
            if (fldManufacturerSpareId)
                if (!RequiredValidation(fldManufacturerSpareId, "Please enter ManufacturerId"))
                    return false;

            if (fldManufacturerId && fldManufacturerId.selectedIndex === 0) {
                alert("Please select Manufacturer");
                fldManufacturerId.focus();
                return false;
            }

            if (fldSparePartGroupId)
                if (!RequiredValidation(fldSparePartGroupId, "Please enter Spare Part GroupId"))
                    return false;
            if (fldGroupName)
                if (!RequiredValidation(fldGroupName, "Please enter Spare Part Group Name"))
                    return false;
            if (fldCost)
                if (!RequiredValidation(fldCost, "Please enter Cost"))
                    return false;
            return true;
        }


        function OnlyAlphabets(myfield, e, dec) {
            var keycode;
            if (window.event || event || e) keycode = window.event.keyCode;
            else return true;
            return (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32);
        }

        function onKeyPressBlockNumbers(value) {
            var reg = /^\-?([1-9]\d*|0)(\.\d?[1-9])?$/;
            if (!reg.test(value)) {
                alert("please enter numeric values only");
                document.getElementById("<%= txtCost.ClientID %>").value = "";
                return false;
            }

            return reg.test(value);
        }

        function RequiredValidation(ctrl, msg) {
            switch (trim(ctrl.value)) {
            case '':
                alert(msg);
                ctrl.focus();
                return false;
            default:
                return true;
            }
        }


        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function numeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode === 190 || charCode > 31 && (charCode < 48 || charCode > 57)) {
                var txtBox = document.getElementById(event.srcElement.id);
                return txtBox.value.indexOf('.') === -1;
            } else return true;
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
                            <legend>Spare Parts Details</legend>
                            <asp:Panel ID="pnlsparepart" runat="server">
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lbSparePartName" runat="server" Text="Spare Part Name"></asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtSparePartName" runat="server" MaxLength="22"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:Label ID="lbManufacturerSpareID" runat="server" Text="Manufacturer Spare ID"
                                                       onkeypress="return numeric(event)">
                                            </asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtManufacturerSpareID" runat="server" MaxLength="16" onkeypress="return numeric(event)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lbManufacturerID" runat="server" Text="Manufacturer Name"></asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlManufacturerID" runat="server" Width="120px"/>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:Label ID="lbSparePartGroupID" runat="server" Text="Spare Part Group ID"></asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtSparePartGroupID" runat="server" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lbGroupName" runat="server" Text="Group Name"></asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtGroupName" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:Label ID="lbCost" runat="server" Text="Cost"></asp:Label>
                                            <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td align="left">
                                            <asp:TextBox ID="txtCost" runat="server" MaxLength="6" onchange="onKeyPressBlockNumbers(this.value);" onkeypress="return numeric(event)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtSparePartID" runat="server" Visible="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center">
                                            <asp:Button ID="btSave" runat="server" OnClick="btSave_Click" Text="Save" OnClientClick="return validation();"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btReset" runat="server" OnClick="btReset_Click" Text="Reset"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
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
                            <asp:GridView ID="gvSpareParts" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                          CellSpacing="2" GridLines="None" CssClass="gridviewStyle" OnPageIndexChanging="gvSpareParts_PageIndexChanging"
                                          OnRowDeleting="gvSpareParts_RowDeleting" OnRowEditing="gvSpareParts_RowEditing">
                                <RowStyle CssClass="rowStyleGrid"/>
                                <Columns>
                                    <asp:TemplateField HeaderText="SparePart Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("SparePart_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SparePart Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSparePartName" runat="server" Text='<%#Eval("SparePart_Name") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manufacturer SpareId">
                                        <ItemTemplate>
                                            <asp:Label ID="lblManSprId" runat="server" Text='<%#Eval("ManufacturerSpare_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manufacturer Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblManId" runat="server" Text='<%#Eval("Manufacturer_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblGroupId" runat="server" Text='<%#Eval("SparePart_Group_Id") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("Group_Name") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cost">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCost" runat="server" Text='<%#Eval("Cost") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Deactivate"></asp:LinkButton>
                                            <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are You sure you want to DEACTIVATE"
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
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
            <asp:HiddenField ID="hidSpareId" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

