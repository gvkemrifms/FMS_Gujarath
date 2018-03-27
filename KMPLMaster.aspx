<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.KMPLMaster, App_Web_m0x5b0wx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <%--<div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="updtpnlServiceStation" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>KMPL<br />
                            </legend>
                            <table>
                            <tr>
                                    <td>
                                        Vehicle Number
                                    </td>
                                    <td class="columnseparator">
                                    </td>
                                    <td>
                                     <cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehNumber" runat="server" AutoPostBack="true"
                                onselectedindexchanged="ddlVehNumber_SelectedIndexChanged"  DropDownStyle="DropDownList">
                               
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
                                        <asp:TextBox ID="txtKMPL" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <div style="width: 300px; float: left">
                                </div>
                                <div>
                                      <asp:Button runat="server" ID="btnUpdate" Text="Update"  
                                        OnClientClick="return validationFuelEntry();" onclick="btnUpdate_Click" />
                                </div>
                            </div>
                            <div>
                                <div style="width: 200px; float: left">
                                </div>
                                <div style="float: left">
                                    <asp:GridView ID="gvVehKmplDetails" runat="server" EmptyDataText="No records found" PageSize="20"
                                        AllowSorting="true" AutoGenerateColumns="false" CssClass="gridviewStyle" CellSpacing="2"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" Width="630px" AllowPaging="true"
                                        EnableSortingAndPagingCallbacks="true" 
                                        onrowcommand="gvVehKmplDetails_RowCommand" 
                                        onpageindexchanging="gvVehKmplDetails_PageIndexChanging" >
                                        <RowStyle CssClass="rowStyleGrid" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="VehicleNumber">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVehNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VehicleNumber") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KMPL">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblKMPL" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"KMPL") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="MainEdit" CommandArgument=' <%# Container.DataItemIndex %>'
                                                        Text="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                         </Columns>
                                        <FooterStyle CssClass="footerStylegrid" />
                                        <PagerStyle CssClass="pagerStylegrid" />
                                        <SelectedRowStyle CssClass="selectedRowStyle" />
                                        <HeaderStyle CssClass="headerStyle" />
                                    </asp:GridView>
                                </div>
                            </div>
                    </td>
                </tr>
            </table>

            <script type="text/javascript" language="javascript">

                function validationFuelEntry() {

                    if (document.getElementById("<%=txtKMPL.ClientID %>").value == 0) {
                        alert("KMPL Should not be Blank");
                        document.getElementById("<%=txtKMPL.ClientID %>").focus();
                        return false;
                    }

                    var Districts = document.getElementById('<%= ddlVehNumber.ClientID %>')

                    if (Districts.selectedIndex == 0) {
                        alert("Please Select the VehicleNumber");
                        Districts.focus();
                        return false;
                    }

                    function OnlyAlphabets(myfield, e, dec) {
                        var key;
                        var keychar;
                        if (window.event)
                            key = window.event.keyCode;
                        else if (e)
                            key = e.which;
                        else
                            return true;
                        keychar = String.fromCharCode(key);
                        if ((("!@#$%^&*()_+=-';{}[]|?<>:,/\".1234567890").indexOf(keychar) > -1))
                            return false;
                        else
                            return true;
                    }
                    function numeric(event) {
                        var charCode = (event.which) ? event.which : event.keyCode
                        //debugger;
                        if (charCode == 190) {
                            var txtBox = document.getElementById(event.srcElement.id);
                            if (txtBox.value.indexOf('.') == -1)
                                return true;
                            else
                                return false;
                        }
                        else if (charCode > 31 && (charCode < 48 || charCode > 57))
                            return false;
                        else
                            return true;
                    }
                }
            </script>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

