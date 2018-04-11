<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="Equipment.aspx.cs" Inherits="Equipment" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<script language="javascript" type="text/javascript">
    function validation() {
        var vehnum = document.getElementById('<%= ddlistVehicleNumber.ClientID %>');
        if (vehnum.selectedIndex === 0) {
            alert("Please select a Vehicle");
            vehnum.focus();
            return false;
        }
        return true;
    }
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<table>
<tr align="center">
<td>
<fieldset style="padding: 10px;">
<legend>Vehicle Equipment Mapping </legend>
<asp:Panel ID="pnlmedEquipment" runat="server">
<table cellpadding="2" cellspacing="2" width="100%">
<tr align="center">
    <td class="tdlabel">
        Vehicle Number<font color="red">*</font>
    </td>
    <td class="columnseparator"></td>
    <td>
        <asp:DropDownList ID="ddlistVehicleNumber" runat="server" Width="200px" AutoPostBack="True"
                          OnSelectedIndexChanged="ddlistVehicleNumber_SelectedIndexChanged">
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewMedicalEqupment" runat="server" AutoGenerateColumns="False"
                          CellPadding="4" CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkMedicalEquipment" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medical Equipment">
                        <ItemTemplate>
                            <asp:Label ID="LblMedicalEquipmentName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblMedicalEquipmentId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewMedicalDisposables" runat="server" AutoGenerateColumns="False"
                          CellPadding="4" CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkMedicalDisposables" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medical Disposables">
                        <ItemTemplate>
                            <asp:Label ID="LblDisposableName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblDisposableId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewExtricationTools" runat="server" AutoGenerateColumns="False"
                          CellPadding="4" CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkExtricationTools" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Extrication Tools">
                        <ItemTemplate>
                            <asp:Label ID="LblExtricationName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblExtricationId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewCOmmunicationTechnology" runat="server" AutoGenerateColumns="False"
                          CellPadding="4" CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkCommunicationTechnology" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Communication & Technology Equipment">
                        <ItemTemplate>
                            <asp:Label ID="LblCommunicationName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblCommunicationId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewMedicines" runat="server" AutoGenerateColumns="False" CellPadding="4"
                          CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkMedicines" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medicines">
                        <ItemTemplate>
                            <asp:Label ID="LblMedicineName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblMedicineId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3">
        <div style="overflow: auto; height: 120px">
            <asp:GridView ID="grdviewNoMedicalSupplies" runat="server" AutoGenerateColumns="False"
                          CellPadding="4" CellSpacing="4" GridLines="None" Width="380px" EmptyDataText="No Records Found"
                          CssClass="gridviewStyle">
                <RowStyle CssClass="rowStyleGrid"/>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkNoMedicalSupplies" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Non Medical Supplies">
                        <ItemTemplate>
                            <asp:Label ID="LblNoMedicalName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EquipmentName") %>'></asp:Label>
                            <asp:Label ID="LblNoMedicalId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
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
<tr>
    <td class="rowseparator"></td>
</tr>
<tr>
    <td colspan="3" align="center">
        <asp:Button ID="BtnSave" Text="Save" runat="server" OnClick="BtnSave_Click"/>
        <asp:Button ID="Button1" runat="server" Text="Cancel" OnClick="Button1_Click"/>
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
    <td class="rowseparator"></td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
