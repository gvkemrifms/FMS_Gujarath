<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.FleetManufacturers, App_Web_m0x5b0wx" %>

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

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else
                return true;
        }

        function validationFleetManufacturers() {
            if (document.getElementById("<%=txtManufacturerName.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer Name");
                document.getElementById("<%=txtManufacturerName.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=ddlManufacturerType.ClientID %>").selectedIndex == 0) {
                alert("Please Select Manufacturer Type");
                document.getElementById("<%=ddlManufacturerType.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtManufacturerModel.ClientID %>").value == 0) {
                alert("Please Select Manufacturer Model");
                document.getElementById("<%=txtManufacturerModel.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=ddlManufacturerState.ClientID %>").selectedIndex == 0) {
                alert("Please Select Manufacturer State");
                document.getElementById("<%=ddlManufacturerState.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtManufacturerAddress.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer Address");
                document.getElementById("<%=txtManufacturerAddress.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtManufacturerContactNumber.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer Contact Number");
                document.getElementById("<%=txtManufacturerContactNumber.ClientID %>").focus();
                    return false;
                }

                var phone = document.getElementById("<%=txtManufacturerContactNumber.ClientID %>");
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

            if (document.getElementById("<%=txtManufacturerContactPerson.ClientID %>").value == 0) {
                    alert("Please Enter Manufacturer Contact Person");
                    document.getElementById("<%=txtManufacturerContactPerson.ClientID %>").focus();
                                            return false;
                                        }
                                        if (document.getElementById("<%=txtManufacturerEmailId.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer EmailId");
                document.getElementById("<%=txtManufacturerEmailId.ClientID %>").focus();
                    return false;
                }

                var emailPat = /^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/;
                var emailid = document.getElementById("<%=txtManufacturerEmailId.ClientID %>").value;
                    var matchArray = emailid.match(emailPat);
                    if (matchArray == null) {
                        alert("Your email address seems incorrect. Please try again.");
                        document.getElementById("<%=txtManufacturerEmailId.ClientID %>").focus();
                                        return false;
                                    }

                                    if (document.getElementById("<%=txtManufacturerTin.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer Tin");
                document.getElementById("<%=txtManufacturerTin.ClientID %>").focus();
                    return false;
                }
                if (document.getElementById("<%=txtManufacturerErn.ClientID %>").value == 0) {
                alert("Please Enter Manufacturer Ern");
                document.getElementById("<%=txtManufacturerErn.ClientID %>").focus();
                    return false;
                }
            }
    </script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="table1" cellspacing="0" cellpadding="0" width="100%" align="center" border="0" class="table table-striped table-bordered table-hover"
                style="height: 37px">
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 10px">
                            <legend>Fleet Manufacturers Details</legend>
                            <asp:Panel ID="pnlFleetManufacturers" runat="server">
                                <table id="table2" class="bordergreen" width="91%" align="center">
                                    <tr>
                                        <td>
                                            <table class="logtable" align="center">
                                                <tr>
                                                    <td style="width: 140px" align="left">Manufacturer Name <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerName" runat="server" CssClass="textbox180" MaxLength="35"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Manufacturer Type <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlManufacturerType" runat="server" CssClass="textbox180">
                                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                            <asp:ListItem Value="1">Battery</asp:ListItem>
                                                            <asp:ListItem Value="2">Body</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Model <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 23px">
                                                        <asp:TextBox ID="txtManufacturerModel" runat="server" CssClass="textbox180" MaxLength="15"></asp:TextBox>
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
                                                        <asp:DropDownList ID="ddlManufacturerState" runat="server" CssClass="textbox180"
                                                            OnSelectedIndexChanged="ddlManufacturerState_SelectedIndexChanged" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">District
                                                        <%--<asp:Label ID="lblManufacturerContactPerson" runat="server" 
                    Text="Contact Person" CssClass="textbox180"></asp:Label>--%>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td style="height: 23px">
                                                        <asp:DropDownList ID="ddlFleetManufacturerDistrict" runat="server" OnSelectedIndexChanged="ddlFleetManufacturerDistrict_SelectedIndexChanged"
                                                            AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                    <td class="rowseparator">
                                                    </td>
                                                </tr>--%>
                                                <%--                                                <tr>
                                                    <td style="width: 140px" align="left">
                                                        Mandal/Taluka
                                                    </td>
                                                    <td class="columnseparator">
                                                    </td>
                                                    <td style="height: 23px">
                                                        <asp:DropDownList ID="ddlFleetManufacturerMandal" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFleetManufacturerMandal_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                --%>
                                                <%--<tr>
                                                    <td class="rowseparator">
                                                    </td>
                                                </tr>--%>
                                                <%--                                                <tr>
                                                    <td style="width: 140px" align="left">
                                                        City/Village
                                                    </td>
                                                    <td class="columnseparator">
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFleetManufacturerCity" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                --%>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Address <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerAddress" runat="server" TextMode="MultiLine" CssClass="textbox180"
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
                                                        <asp:TextBox ID="txtManufacturerContactNumber" runat="server" CssClass="textbox180"
                                                            MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">Contact Person
                                                        <%--<asp:Label ID="lblManufacturerContactPerson" runat="server" 
                    Text="Contact Person" CssClass="textbox180"></asp:Label>--%>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerContactPerson" runat="server" CssClass="textbox180"
                                                            MaxLength="35"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">E-mail ID <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerEmailId" runat="server" CssClass="textbox180" MaxLength="50"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">TIN <span style="color: Red" class="labelErr">*</span> &nbsp;
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerTin" runat="server" CssClass="textbox180" MaxLength="11"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 140px" align="left">ERN <span style="color: Red" class="labelErr">*</span>
                                                    </td>
                                                    <td class="columnseparator"></td>
                                                    <td>
                                                        <asp:TextBox ID="txtManufacturerErn" runat="server" CssClass="textbox180" MaxLength="11"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 41px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnManufacturerSave" Width="55px" runat="server" CssClass="button"
                                                            Text="Save" OnClick="btnManufacturerSave_Click"></asp:Button>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Button ID="btnManufacturerReset" Width="55px" runat="server" CssClass="button"
                                                            Text="Reset" CausesValidation="false" OnClick="btnManufacturerReset_Click"></asp:Button>
                                                        <input type="hidden" id="hidBatText" runat="server" />
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowseparator"></td>
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
                            <asp:GridView ID="grvManufacturerDetails" runat="server" AllowPaging="True" PageSize="5"
                                AutoGenerateColumns="False" CellPadding="3" CellSpacing="2" GridLines="None" class="table table-striped table-bordered table-hover"
                                OnRowEditing="grvManufacturerDetails_RowEditing" OnPageIndexChanging="grvManufacturerDetails_PageIndexChanging">
                                <RowStyle CssClass="rowStyleGrid" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%#Eval("FleetManufacturer_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manufacturer_Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblManufacturerName" runat="server" Text='<%#Eval("FleetManufacturer_Name")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactNumber" runat="server" Text='<%#Eval("FleetManufacturer_ContactNo")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Person">
                                        <ItemTemplate>
                                            <asp:Label ID="lblContactPerson" runat="server" Text='<%#Eval("FleetManufacturer_ContactPerson")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--                                    <asp:TemplateField HeaderText="City/Village">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCityVill" runat="server" Text='<%#Eval("City_Id")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    --%>
                                    <%--<asp:TemplateField HeaderText="Address">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("FleetManufacturer_Address")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Creation Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreateDate" runat="server" Text='<%#Eval("Created_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:TemplateField HeaderText="InActive Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInActiveDate" runat="server" Text='<%#Eval("InActivated_Date", "{0:d}")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%-- <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkbtnStatus" runat="server" Text='<%#Eval("FleetManufacturer_Status")%>'
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
                            <br />
                            <asp:HiddenField ID="hidManId" runat="server" />
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

