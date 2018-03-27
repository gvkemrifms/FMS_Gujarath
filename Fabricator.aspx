<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Fabricator, App_Web_m0x5b0wx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">

        function CheckLength(text, long) {
            var maxlength = new Number(long); // Change number to your max length.
            if (text.value.length > maxlength) {
                text.value = text.value.substring(0, maxlength);

                alert(" Only " + long + " chars");

            }
        }


        function remark(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode != 34) && (keycode != 39)) {
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

        function OnlyAlphaNumeric(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true; if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
                return true;
            }
            else {
                return false;
            }
            return true;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }

        function validationFabricator() {
            if (document.getElementById("<%=txtFabricatorName.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator Name");
                   document.getElementById("<%=txtFabricatorName.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=ddlFabricatorType.ClientID %>").selectedIndex == 0) {
                   alert("Please Select Fabricator Type");
                   document.getElementById("<%=ddlFabricatorType.ClientID %>").focus();
                    return false;
                }

                if (document.getElementById("<%=ddlFabricatorState.ClientID %>").selectedIndex == 0) {
                   alert("Please Select Fabricator State");
                   document.getElementById("<%=ddlFabricatorState.ClientID %>").focus();
                    return false;
                }

                if (document.getElementById("<%=txtFabricatorAddress.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator Address");
                   document.getElementById("<%=txtFabricatorAddress.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtFabricatorContactNumber.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator Contact Number");
                   document.getElementById("<%=txtFabricatorContactNumber.ClientID %>").focus();
                    return false;
                }

                var phone = document.getElementById("<%=txtFabricatorContactNumber.ClientID %>");
               if (isNaN(parseInt(phone.value))) {
                   alert("The phone number contains illegal characters");
                   phone.focus();
                   return false;
               }
               else { }
               if (!((phone.value.length >= 10) && (phone.value.length <= 15))) {
                   alert("The phone number is the wrong length");
                   phone.focus();
                   return false;
               }
               else { }

               if (document.getElementById("<%=txtFabricatorContactPerson.ClientID %>").value == 0) {
                                            alert("Please Enter Fabricator Contact Person");
                                            document.getElementById("<%=txtFabricatorContactPerson.ClientID %>").focus();
                        return false;
                    }
                    if (document.getElementById("<%=txtFabricatorPanNo.ClientID %>").value == 0) {
                   alert("Please Enter PAN No.");
                   document.getElementById("<%=txtFabricatorPanNo.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtFabricatorEmailId.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator EmailId");
                   document.getElementById("<%=txtFabricatorEmailId.ClientID %>").focus();
                        return false;
                    }

                    var emailPat = /^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/;
                    var emailid = document.getElementById("<%=txtFabricatorEmailId.ClientID %>").value;
                                    var matchArray = emailid.match(emailPat);
                                    if (matchArray == null) {
                                        alert("Your email address seems incorrect. Please try again.");
                                        document.getElementById("<%=txtFabricatorEmailId.ClientID %>").focus();
                                            return false;
                                        }

                                        if (document.getElementById("<%=txtFabricatorTin.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator Tin");
                   document.getElementById("<%=txtFabricatorTin.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtFabricatorErn.ClientID %>").value == 0) {
                   alert("Please Enter Fabricator Ern");
                   document.getElementById("<%=txtFabricatorErn.ClientID %>").focus();
                    return false;
                }
            }
    </script>

   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7; border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="table1" cellspacing="0" cellpadding="0" width="100%" align="center" border="0"
                style="height: 37px">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td style="height: 281px">
                        <fieldset style="padding: 10px">
                            <legend>Fabricator</legend>
                            <asp:Panel ID="pnlfabricator" runat="server">
                                <table id="table2" class="bordergreen" width="91%" align="center">
                                    <tr>
                                        <td style="height: 294px; width: 518px">
                                            <table>
                                                <tr>
                                                    <td style="width: 140px" align="left">Fabricator Name <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorName" runat="server" CssClass="textbox180" MaxLength="35"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Fabricator Type <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFabricatorType" runat="server" CssClass="textbox180">
                                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                            <asp:ListItem Value="1">Body</asp:ListItem>
                                                            <asp:ListItem Value="2">FRP</asp:ListItem>
                                                            <asp:ListItem Value="3">MS</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px; height: 25px;" align="left">State <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 25px">
                                                        <asp:DropDownList ID="ddlFabricatorState" runat="server" CssClass="textbox180" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFabricatorState_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">District
                                                        <%--<asp:Label ID="lblFabricatorContactPerson" runat="server" 
                    Text="Contact Person" CssClass="textbox180"></asp:Label>--%>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 23px">
                                                        <asp:DropDownList ID="ddlFabricatorDistrict" runat="server" CssClass="textbox180"
                                                            AutoPostBack="True" OnSelectedIndexChanged="ddlFabricatorDistrict_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                    <td class="rowseparator">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">
                                                        Mandal/Taluka
                                                    </td>
                                                    <td class="columnseparator">
                                                    </td>
                                                    <td style="height: 23px">
                                                        <asp:DropDownList ID="ddlFabricatorMandal" runat="server" CssClass="textbox180" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFabricatorMandal_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">
                                                        City/Village
                                                    </td>
                                                    <td class="columnseparator">
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFabricatorCity" runat="server" CssClass="textbox180">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Address <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorAddress" runat="server" TextMode="MultiLine" CssClass="textbox180"
                                                            onKeyUp="CheckLength(this,300)" onChange="CheckLength(this,300)"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Contact Number <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorContactNumber" runat="server" CssClass="textbox180"
                                                            MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Contact Person
                                                        <%--<asp:Label ID="lblFabricatorContactPerson" runat="server" 
                    Text="Contact Person" CssClass="textbox180"></asp:Label>--%>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorContactPerson" runat="server" CssClass="textbox180"
                                                            MaxLength="35"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">PAN No <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorPanNo" runat="server" CssClass="textbox180" MaxLength="10"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="width: 140px">E-mail ID <span class="labelErr" style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorEmailId" runat="server" CssClass="textbox180" MaxLength="50"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="width: 140px">TIN <span class="labelErr" style="color: Red">*</span> &nbsp;
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorTin" runat="server" CssClass="textbox180" MaxLength="11"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="width: 140px">ERN <span class="labelErr" style="color: Red">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFabricatorErn" runat="server" CssClass="textbox180" MaxLength="11"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 41px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnFabricatorSave" runat="server" CssClass="button" OnClick="btnFabricatorSave_Click"
                                                            OnClientClick="return validationFabricator();" Text="Save" Width="55px" />
                                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnFabricatorReset" runat="server" CausesValidation="false" CssClass="button"
                                                            OnClick="btnFabricatorReset_Click" Text="Reset" Width="55px" />
                                                        <input id="hidBatText" runat="server" type="hidden" />
                                                    </td>
                                                </tr>
                                            </table>
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
                            <asp:GridView ID="grvFabricatorDetails" runat="server" AllowPaging="True" PageSize="5"
                                AutoGenerateColumns="False" CellPadding="3" GridLines="None" CssClass="gridviewStyle"
                                CellSpacing="2" OnPageIndexChanging="grvFabricatorDetails_PageIndexChanging"
                                OnRowEditing="grvFabricatorDetails_RowEditing">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("FleetFabricator_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fabricator_Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFabricatorName" runat="server" Text='<%#Eval("FleetFabricator_Name")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PAN No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPanno" runat="server" Text='<%#Eval("FleetFabricator_PAN")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="TIN No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTinno" runat="server" Text='<%#Eval("FleetFabricator_TIN")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Person">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactPerson" runat="server" Text='<%#Eval("FleetFabricator_ContactPerson")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactNumber" runat="server" Text='<%#Eval("FleetFabricator_ContactNo")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="City/Village">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCityVill" runat="server" Text='<%#Eval("City_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField HeaderText="Address">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("FleetFabricator_Address")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Created_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--  <asp:TemplateField HeaderText="InActive Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInActiveDate" runat="server" Text='<%#Eval("InActivated_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%-- <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnStatus" runat="server" Text='<%#Eval("FleetFabricator_Status")%>'
                                                CommandName="Update" />
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
                            <asp:HiddenField ID="hidFabId" runat="server" />
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

