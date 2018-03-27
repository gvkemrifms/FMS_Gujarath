<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.TyresDetails, App_Web_fbb3hqmh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function OnlyAlphaNumeric(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode == 32) || (keycode >= 47 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }
        function OnlyAlphabets(myfield, e, dec) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122) || (keycode == 32)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }
        function OnlyNumbers(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }


        function validation() {
            if (document.getElementById("<%=txtTyreItemCode.ClientID %>").value == 0) {
                       alert("Please Enter Tyre Item Code");
                       document.getElementById("<%=txtTyreItemCode.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtTyreNumber.ClientID %>").value == 0) {
                       alert("Please Enter Tyre Number");
                       document.getElementById("<%=txtTyreNumber.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtTyreMake.ClientID %>").value == 0) {
                       alert("Please Enter Tyre Make");
                       document.getElementById("<%=txtTyreMake.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtTyreModel.ClientID %>").value == 0) {
                       alert("Please Enter Tyre Model");
                       document.getElementById("<%=txtTyreModel.ClientID %>").focus();
                    return false;
                }

                if (document.getElementById("<%=txtTyreSize.ClientID %>").value == 0) {
                       alert("Please Enter Tyre Size");
                       document.getElementById("<%=txtTyreSize.ClientID %>").focus();
                    return false;
                }


            }
    </script>
  <%--  <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td class="rowseparator" style="width: 450px"></td>
                </tr>
                <tr>
                    <td align="center" style="width: 450px">
                        <fieldset style="padding: 10px">
                            <legend>Tyres Details </legend>
                            <asp:Panel ID="pnltyredetails" runat="server">
                                <table>
                                    <tr>
                                        <td align="left">Tyre Item Code <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTyreItemCode" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">Tyre Number <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTyreNumber" runat="server" MaxLength="10"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">Make <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTyreMake" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">&nbsp;Model <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTyreModel" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">&nbsp;Size <span style="color: Red">*</span>
                                        </td>
                                        <td class="columnseparator"></td>
                                        <td>
                                            <asp:TextBox ID="txtTyreSize" runat="server" MaxLength="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="rowseparator"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnTyresDetailsSave" runat="server" Text="Save" OnClick="btnTyresDetailsSave_Click"
                                                OnClientClick="return validation();" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnTyresDetailsReset" runat="server" Text="Reset" OnClick="btnTyresDetailsReset_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator" style="width: 450px"></td>
                </tr>
                <tr>
                    <td style="width: 450px">
                        <fieldset style="padding: 10px">
                            <asp:GridView ID="grvTyresDetails" runat="server" align="center" AllowPaging="True"
                                PageSize="5" AutoGenerateColumns="False" GridLines="None" CssClass="gridviewStyle"
                                CellPadding="3" CellSpacing="2" OnPageIndexChanging="grvTyresDetails_PageIndexChanging"
                                OnRowEditing="grvTyresDetails_RowEditing">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Tyre Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("Tyre_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tyre Item Code">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTyreItemCode" runat="server" Text='<%#Eval("Tyre_Item_Code")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tyre Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTyreNumber" runat="server" Text='<%#Eval("TyreNumber")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Make">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMake" runat="server" Text='<%#Eval("Make")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Model">
                                        <ItemTemplate>
                                            <asp:Label ID="lblModel" runat="server" Text='<%#Eval("Model")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Size">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSize" runat="server" Text='<%#Eval("Size")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreationDate" runat="server" Text='<%#Eval("Creation_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%-- <asp:TemplateField HeaderText="InActive Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInActiveDate" runat="server" Text='<%#Eval("InActive_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnStatus" runat="server" Text='<%#Eval("Status")%>' CommandName="Update" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CommandName="Edit" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="footerStylegrid" />
                                <PagerStyle CssClass="pagerStylegrid" />
                                <SelectedRowStyle CssClass="selectedRowStyle" />
                                <HeaderStyle CssClass="headerStyle" />
                            </asp:GridView>
                        </fieldset>
                        <asp:HiddenField ID="hidTyresId" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator" style="width: 450px"></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

