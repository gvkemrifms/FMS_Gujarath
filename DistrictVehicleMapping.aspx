<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DistrictVehicleMapping.aspx.cs" Inherits="DistrictVehicleMapping" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?client=gme-gvkemergencymanagement3&places=West+Bengal&libraries=places"></script>
    <script src="locationpicker.js"></script>
    <title>:: GVK EMRI ::</title>

    <style>
        .pac-container:after { content: none !important; }

        .hightmap { height: 400px !important; }

        .modal {
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
            display: none; /* Hidden by default */
            height: 100%; /* Full height */
            left: 0;
            overflow: auto; /* Enable scroll if needed */
            padding-top: 100px; /* Location of the box */
            position: fixed; /* Stay in place */
            top: 0;
            width: 100%; /* Full width */
            z-index: 1; /* Sit on top */
        }

        .modal-content {
            background-color: #fefefe;
            border: 1px solid #888;
            height: 100%;
            margin: auto;
            padding: 20px;
            width: 80%;
        }

        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
    </style>
    <script src="js/Validation.js"></script>
    <script type="text/javascript" language="javascript">

        function validation() {

            var fldDistrict = document.getElementById('<%= ddlDistrict.ClientID %>');
            var fldVehicleNumber = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
            var fldMandals = document.getElementById('<%= ddlMandal.ClientID %>');
            var fldCity = document.getElementById('<%= ddlCity.ClientID %>');
            var fldContactNumber = document.getElementById('<%= txtContactNumber.ClientID %>');
            var inputs = fldVehicleNumber.getElementsByTagName('input');
            var i;
            for (i = 0; i < inputs.length; i++) {
                switch (inputs[i].type) {
                case 'text':
                    if (inputs[i].value !== "" && inputs[i].value != null && inputs[i].value === "--Select--") {
                        alert('Please select Vehicle Number');
                        return false;
                    }
                    break;
                }
            }
            if (fldDistrict && fldDistrict.selectedIndex === 0) {
                alert("Please Select District");
                fldDistrict.focus();
                return false;
            }
            switch (fldMandals.selectedIndex) {
            case 0:
                alert("Please select Mandal");
                fldMandals.focus();
                return false;
            }
            switch (fldCity.selectedIndex) {
            case 0:
                alert("Please select City");
                fldCity.focus();
                return false;
            }

            if (!RequiredValidation(fldContactNumber, "Please select Contact Number"))
                return false;
            return true;
        }

        function open() {
            var modal = document.getElementById('myModal');
            var span = document.getElementsByClassName("close")[0];
            modal.style.display = "block";
            span.onclick = function() {
                modal.style.display = "none";
            };
            window.onclick = function(event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
        }

    </script>


    <asp:UpdatePanel ID="updtpnlVehMapping" runat="server">
        <ContentTemplate>
            <div style="width: 50%; float: left">

                <table align="center">
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td>
                                        Vehicle Number<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehicleNumber" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        District<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>

                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Mandal<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlMandal" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMandal_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        City/ Village<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Base Location<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td style="width: 20%">
                                                    <asp:DropDownList ID="ddlBaseLocation" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBaseLocation_SelectedIndexChanged">
                                                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtBaseLocation" runat="server" Width="200px" Visible="false"></asp:TextBox>
                                                </td>
                                                <td style="margin: 5px">
                                                    <script>
                                                        function abc() {
                                                            $('#us2').locationpicker({
                                                                location: {
                                                                    latitude: '22.6754807',
                                                                    longitude: '88.0883874'
                                                                },
                                                                radius: 20,
                                                                zoom: 7,
                                                                inputBinding: {
                                                                    latitudeInput: $('#us2lat'),
                                                                    latitudeInput: $('.txtLatitude'),
                                                                    longitudeInput: $('#us2lon'),
                                                                    longitudeInput: $('.txtLongitude'),
                                                                    radiusInput: $('#us2radius'),
                                                                    locationNameInput: $('#address')
                                                                },
                                                                enableAutocomplete: true,
                                                                onchanged: function(currentLocation,
                                                                    radius,
                                                                    isMarkerDropped) {
                                                                    $('#us2lon').val(currentLocation.longitude);

                                                                }
                                                            });
                                                        }


                                                    </script>
                                                    <asp:LinkButton ID="lnkbtnExtngBaseLoc" runat="server" Visible="false" OnClick="lnkbtnExtngBaseLoc_Click">Existing Base Location</asp:LinkButton>
                                                    <asp:LinkButton ID="lnkbtnNewBaseLoc" runat="server" OnClick="lnkbtnNewBaseLoc_Click">New Base Location</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>

                                <tr>
                                    <td>
                                        Contact Number<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtContactNumber" runat="server" onkeypress="return numeric(event)"
                                                     MaxLength="10">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        Vehicle Type
                                    </td>
                                    <td></td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehType" class="text1" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLatitude" runat="server" Text="Latitude" Visible="false"></asp:Label>
                                        <asp:Label ID="lblMandatory1" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtLatitude" Class="txtLatitude" runat="server" Visible="false" onblur="isDecimal(this);"
                                                     onkeydown="return OnlyNumPeriod(event);">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLongitude" runat="server" Text="Longitude" Visible="false"></asp:Label>
                                        <asp:Label ID="lblMandatory2" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtLongitude" Class="txtLongitude" runat="server" Visible="false" onblur="isDecimal(this);"
                                                     onkeydown="return OnlyNumPeriod(event);">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table align="center">
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"/>
                                    </td>
                                    <td class="columnseparator" style="width: 50px"></td>
                                    <td align="center">
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>


                <div>
                </div>
            </div>
            <div style="width: 50%; float: right">
                <div>
                    <asp:Label ID="lblVeh" runat="server"></asp:Label>
                </div>
                <asp:GridView ID="grdVehicleData" runat="server"></asp:GridView>
            </div>
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">×</span>

                    <input type="text" name="address" id="address" style="width: 40%">
                    <input type="text" id="us2lat" value=""/><input type="text" id="us2lon" value=""/>
                    <div id="us2" style="width: 100%; height: 100%;" class=""></div>
                </div>
            </div>

        </ContentTemplate>

    </asp:UpdatePanel>
</asp:Content>

