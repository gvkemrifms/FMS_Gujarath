<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DistrictVehicleMapping.aspx.cs" Inherits="GvkFMSAPP.PL.Prior_MaintenanceStage.DistrictVehicleMapping" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="js/jquery-1.10.2.min.js"></script>--%>
    <%--<script type="text/javascript" src='http://maps.google.com/maps/api/js?places=Rajasthan&libraries=places&key=d1CkkvZsTH1jgTgvsZvvYRaSDSc='></script>--%>
    <script type="text/javascript" src='http://maps.googleapis.com/maps/api/js?client=gme-gvkemergencymanagement3&places=West+Bengal&libraries=places'></script>
   
     <script src="locationpicker.js"></script>

    <title>:: GVK EMRI ::</title>

    <style>
        .pac-container:after {
            content: none !important;
        }

        .hightmap {
            height: 400px !important;
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            height:100%;
        }
        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
    </style>
    <%--<link href="css/newStyles.css" rel="stylesheet" />--%>
    <script type="text/javascript" language="javascript">

        function valiation() {

            var fld_District = document.getElementById('<%= ddlDistrict.ClientID %>');
            var fld_VehicleNumber = document.getElementById('<%= ddlVehicleNumber.ClientID %>');
          <%--  var fld_Segment = document.getElementById('<%= ddlSegments.ClientID %>');
            var fld_TxtSegment = document.getElementById('<%= txtNewSegment.ClientID %>');--%>
            var fld_Mandals = document.getElementById('<%= ddlMandal.ClientID %>');
            var fld_City = document.getElementById('<%= ddlCity.ClientID %>');
          <%--  var fld_BaseLocation = document.getElementById('<%= ddlBaseLocation.ClientID %>');
            var fld_TxtBaseLoc = document.getElementById('<%= txtBaseLocation.ClientID %>');--%>
            var fld_ContactNumber = document.getElementById('<%= txtContactNumber.ClientID %>');

            var inputs = fld_VehicleNumber.getElementsByTagName('input');
            var i;
            for (i = 0; i < inputs.length; i++) {
                if (inputs[i].type == 'text') {
                    if (inputs[i].value != "" && inputs[i].value != null)
                        if (inputs[i].value == "--Select--") {
                            alert('Please select Vehicle Number');
                            return false;
                        }

                    break;
                }
            }



            if (fld_District)
                if (fld_District.selectedIndex == 0) {
                    alert("Please Select District");
                    fld_District.focus();
                    return false;
                }



            if (fld_Mandals.selectedIndex == 0) {
                alert("Please select Mandal");
                fld_Mandals.focus();
                return false;
            }

            if (fld_City.selectedIndex == 0) {
                alert("Please select City");
                fld_City.focus();
                return false;
            }

            //if (fld_BaseLocation)
            //    if (fld_BaseLocation.selectedIndex == 0) {
            //        alert("Please select Base Location");
            //        fld_BaseLocation.focus();
            //        return false;
            //    }

            //if (fld_TxtBaseLoc)
            //    if (!RequiredValidation(fld_TxtBaseLoc, "Please enter New Base Location"))
            //        return false;

            if (!RequiredValidation(fld_ContactNumber, "Please select Contact Number"))
                return false;

        }

<%--        function ChkDistrict() {
            var fld_District = document.getElementById('<%= ddlDistrict.ClientID %>');
            if (fld_District)
                if (fld_District.selectedIndex == 0) {
                    alert("Please Select District");
                    fld_District.focus();
                    return false;
                }
        }--%>

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

        function OnlyNumPeriod(evt) {
            var bool = false;
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (evt.shiftKey == 1) {
                bool = false;
                alert('Shift Key is not allowed');
            }
            else if ((charCode >= 48 && charCode <= 57) || (charCode > 95 && charCode < 106))
                bool = true;
            else if (charCode == 8 || charCode == 46 || charCode == 190 || charCode == 9)
                bool = true;
            else if (charCode == 110)
                bool = true;
            return bool;
        }
        function isDecimal(control) {
            var input = control.value;
            if (input != '') {
                var arr = input.toString().split('.');
                var id = document.getElementById(control.id);
                if (arr.length != 2) {
                    alert('InCorrect Format');
                    control.value = "";
                    id.focus();
                }
                else if (arr.length == 2 && arr[0].length != 2) {
                    alert('InCorrect Format;ex 12.2345');
                    control.value = "";
                    id.focus();
                }
                else if (arr.length == 2 && arr[1].length < 1) {
                    alert('InCorrect Format;ex 12.2345');
                    control.value = "";
                    id.focus();
                }
                else if (arr.length == 2 && arr[1].length > 5) {
                    alert('InCorrect Format;ex 12.2345');
                    control.value = "";
                    id.focus();
                }
            }
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
                                    <td>Vehicle Number<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlVehicleNumber" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged"><asp:ListItem Value="-1">--Select--</asp:ListItem></asp:DropDownList>
                                        <%--<cc1:ComboBox AutoCompleteMode="Append" ID="ddlVehicleNumber" runat="server" AutoPostBack="true"
                                            DropDownStyle="DropDownList" OnSelectedIndexChanged="ddlVehicleNumber_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        </cc1:ComboBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>District<span class="labelErr" style="color: Red">*</span>
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
                                    <td>Mandal<span class="labelErr" style="color: Red">*</span>
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
                                    <td>City/ Village<span class="labelErr" style="color: Red">*</span>
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
                                    <td>Base Location<span class="labelErr" style="color: Red">*</span>
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
                                                        // google.maps.event.trigger(map, 'resize');

                                                        function abc() {
                                                          //  alert("asdf");
                                                            $('#us2').locationpicker({
                                                                location: { latitude: '22.6754807', longitude: '88.0883874' },
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
                                                                onchanged: function (currentLocation, radius, isMarkerDropped) {
                                                                    $('#us2lon').val(currentLocation.longitude);
                                                                    //alert("Location changed. New location (" + currentLocation.latitude + ", " + currentLocation.longitude + ")");
                                                                }
                                                            });
                                                        }



	                                                </script>
                                                    <asp:LinkButton ID="lnkbtnExtngBaseLoc" runat="server" Visible="false" OnClick="lnkbtnExtngBaseLoc_Click">Existing Base Location</asp:LinkButton>
                                                    <asp:LinkButton ID="lnkbtnNewBaseLoc"  runat="server" OnClick="lnkbtnNewBaseLoc_Click">New Base Location</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>

                                <tr>
                                    <td>Contact Number<span class="labelErr" style="color: Red">*</span>
                                    </td>
                                    <td class="columnseparator"></td>
                                    <td>
                                        <asp:TextBox ID="txtContactNumber" runat="server" onkeypress="return numeric(event)"
                                            MaxLength="10"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowseparator"></td>
                                </tr>
                                <tr>
                                    <td>Vehicle Type
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
                                            onkeydown="return OnlyNumPeriod(event);"></asp:TextBox>
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
                                        <asp:TextBox ID="txtLongitude" Class="txtLongitude"  runat="server" Visible="false" onblur="isDecimal(this);"
                                            onkeydown="return OnlyNumPeriod(event);"></asp:TextBox>
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
                                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                    </td>
                                    <td class="columnseparator" style="width: 50px"></td>
                                    <td align="center">
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
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
                    <input type="text" id="us2lat" value="" /><input type="text" id="us2lon" value="" />
                    <div id="us2" style="width: 100%; height: 100%;" class=''></div>
                </div>
            </div>
            <script>
            function open() {
              //  alert("asf");
                var modal = document.getElementById('myModal');
                var btn = document.getElementsByClassName("lnkbtnNewBaseLoc");
                var span = document.getElementsByClassName("close")[0];
                // return false;
                modal.style.display = "block";
                span.onclick = function () {
                    modal.style.display = "none";
                }
                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
              //  abc();
                //modal.style.display = "block";
            }
        </script>
        </ContentTemplate>
        
    </asp:UpdatePanel>
</asp:Content>

