﻿<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="DetailedWithVehicleModelReport.aspx.cs" Inherits="DetailedWithVehicleModelReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#<%= ddldistrict.ClientID %>').select2({
                disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 2,
                placeholder: "Select an option"
            });
        });
        function Validations() {
            var ddlDistrict = $('#<%= ddldistrict.ClientID %> option:selected').text().toLowerCase();
            if (ddlDistrict === '--select--') {
                return alert("Please select District");
            }
            return true;
        }
    </script>
    <table align="center">
        <tr>
            <td>
                <asp:Label style="font-size: 20px; color: brown" runat="server" Text="DetailedWithVehicleModel&nbsp;Report"></asp:Label>
            </td>
        </tr>
    </table>
    <br/>
    <table align="center">
        <tr>

            <td>
               Select District <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District" style="color: red">*</asp:Label>
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
            </tr>
        <tr>
            <td>
                <asp:Button runat="server" Text="ShowReport" CssClass="form-submit-button" OnClick="btnsubmit_Click"  ClientIDMode="static" EnableViewState="True" OnClientClick="if(!Validations()) return false;"></asp:Button>
            </td>
            <td>
                <asp:Button runat="server" Text="ExportExcel" onclick="btntoExcel_Click" CssClass="form-reset-button"></asp:Button>
            </td>
        </tr>

    </table>
    <br/>
    <br/>
    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grdvehmodel" runat="server" BorderColor="brown" BorderWidth="1px"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>


