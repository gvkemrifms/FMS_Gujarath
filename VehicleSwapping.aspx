<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.VAS.VehicleSwapping, App_Web_fbb3hqmh" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <script type="text/javascript" language="javascript">

        function validation() {
            var District = document.getElementById('<%= ddlDistrict.ClientID %>');
            var SrcVehicle = document.getElementById('<%= ddlSrcVehicle.ClientID %>');
            var DestVehicle = document.getElementById('<%= ddlDestVehicle.ClientID %>');
            var SrcContactNo = document.getElementById('<%= txtSrcContactNo.ClientID %>');
            var DestContactNo = document.getElementById('<%= txtDestContactNo.ClientID %>');

            if (District)
                if (District.selectedIndex == 0) {
                alert("Please Select District");
                District.focus();
                return false;
            }

            if (SrcVehicle)
                if (SrcVehicle.selectedIndex == 0) {
                alert("Please select Source Vehicle");
                SrcVehicle.focus();
                return false;
            }

            if (DestVehicle)
                if (DestVehicle.selectedIndex == 0) {
                alert("Please select Destination Vehicle");
                DestVehicle.focus();
                return false;
            }

            if (!RequiredValidation(SrcContactNo, "Source Contact Number Cannot be Blank"))
                return false;

            if (!RequiredValidation(DestContactNo, "Destination Contact Number Cannot be Blank"))
                return false;

            document.getElementById("loaderButton").style.display = '';
            document.all('<%= pnlButton.ClientID %>').style.display = "none"

        }

        function RequiredValidation(ctrl, msg) {
            if (trim(ctrl.value) == '') {
                alert(msg);
                ctrl.focus();
                return false;
            }
            else
                return true;
        }


        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

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
        
    </script>

   <%-- <div style="height: 150px; margin: 0 0px 15px 0px; padding: 5px; background-color: #f7f7f7;
        border: 1px #E2BBA0 solid;">
        <img src="images/b1.jpg" alt="banner" width="653" height="150" />
    </div>--%>
    <asp:UpdatePanel ID="updtpnlVehSwapping" runat="server">
        <ContentTemplate>
            <fieldset style="padding: 10px">
                <legend>Vehicle Swapping</legend>
                <table style="width: 600px;">
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            District
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="true" Width="155px"
                                OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            Requested By
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox ID="txtRequestedBy" runat="server" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Source Vehicle
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                             <cc1:ComboBox AutoCompleteMode="Append" ID="ddlSrcVehicle" runat="server" AutoPostBack="true"
                                Width="155px" onselectedindexchanged="ddlSrcVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            Destination Vehicle
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                         <cc1:ComboBox AutoCompleteMode="Append" ID="ddlDestVehicle" runat="server" AutoPostBack="true"
                                Width="155px" onselectedindexchanged="ddlDestVehicle_SelectedIndexChanged" DropDownStyle="DropDownList">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </cc1:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Base Location
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox ID="txtSrcBaseLocation" runat="server" Width="150px" BackColor="#CCCCCC"
                                ReadOnly="True"></asp:TextBox>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            Base Location
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox ID="txtDestBaseLocation" runat="server" Width="150px" BackColor="#CCCCCC"
                                ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Contact Number
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox ID="txtSrcContactNo" runat="server" Width="150px" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            Contact Number
                        </td>
                        <td class="columnseparator">
                        </td>
                        <td>
                            <asp:TextBox ID="txtDestContactNo" runat="server" Width="150px" MaxLength="10" onkeypress="return numeric(event)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowseparator">
                        </td>
                    </tr>
                    <tr>
                         <div style="top: 0px; width: 68px;">
                            </tr>
                    <caption>
                        <img ID="loaderButton" alt="" src="../images/savingimage.gif" 
                            style="display: none" />
                        <tr>
                            <td align="center" colspan="7" style="">
                                <asp:Panel ID="pnlButton" runat="server">
                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" 
                                        Text="Submit" />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" 
                                        Text="Reset" />
                                </asp:Panel>
                            </td>
                        </tr>
                    </caption>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

