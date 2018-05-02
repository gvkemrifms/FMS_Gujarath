<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleCardTypeReport.aspx.cs" Inherits="VehicleCardTypeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script  type="text/javascript">
      
        function validationFuelEntry() {

            var district = document.getElementById('<%= ddlDistrict.ClientID %>');
            switch (district.selectedIndex) {
            case 0:
                alert("Please select the District");
                window.Districts.focus();
                return false;
            }

            var ssn = document.getElementById('<%= ddlSSN.ClientID %>');
            switch (ssn.selectedIndex) {
            case 0:
                alert("Please select the Service Station Name");
                ssn.focus();
                return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel ID="updtpanlVehcardtypereport" runat="server">
        <ContentTemplate>
            <script>
                function pageLoad()
                {
                     $('#<%= ddlDistrict.ClientID %>').select2({
                disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
            $('#<%= ddlSSN.ClientID %>').select2({
                disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
                }
            </script>
            <legend align="center" style="color:brown">Vehicle Card Type Report</legend>
            <br />
            <table align="center">
                <tr>
                    <td>
                        Select District <span style="color:red">*</span>
                        </td>

                        <td>
                        <asp:DropDownList ID="ddlDistrict" CssClass="search_3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    </tr>
                <tr>
                    <td>
                        Service Station Name<span style="color:red">*</span>
                        </td>
                    <td>
                        <asp:DropDownList ID="ddlSSN" CssClass="search_3" runat="server" AutoPostBack="True"
                                          OnSelectedIndexChanged="ddlSSN_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnExportToExcel" CssClass="form-submit-button" runat="server" Text="Export To Excel" Width="142px"
                                    OnClick="btnExportToExcel_Click"/>
                    </td>
                </tr>
            </table>
            <br />
            <table align="center" style="margin-top:30px">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleCardTypeReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

