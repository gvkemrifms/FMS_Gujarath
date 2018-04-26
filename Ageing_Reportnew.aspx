﻿<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="Ageing_Reportnew.aspx.cs" Inherits="AgeingReportnew" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type ="text/javascript">
        $(function () {
            $('#<%= ddldistrict.ClientID %>').select2({
                disable_search_threshold: 5, search_contains: true, minimumResultsForSearch: 20,
                placeholder: "Select an option"
            });
        });
        function Validations() 
            {
                var ddlDistrict = $('#<%=ddldistrict.ClientID%> option:selected').text().toLowerCase();
                if (ddlDistrict === '--select--') {
                   return alert("Please select District");
                }
            return true;
        };
      
    </script>  
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblcardtypereport" style="font-size: 20px; color: brown" runat="server" Text="Ageing&nbsp;Details Report"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>

            </td>
        </tr>
    </table>
    <br/>
    <table align="center">
        <tr>

            <td >            
                Select  District<span style="color: Red; width: 150px; ">*</span>             
            </td>

            <td>
                <asp:DropDownList ID="ddldistrict" runat="server" style="width: 150px"></asp:DropDownList>
            </td>
            </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btnSubmit" CssClass="form-submit-button" Text="ShowReport" OnClick="btnsubmit_Click" OnClientClick="if(!Validations()) return false;"></asp:Button>
                </td>
                <td>
                    <asp:Button runat="server" Text="ExportExcel" CssClass="form-reset-button" OnClick="btntoExcel_Click"></asp:Button>

                </td>

            </tr>
    </table>

    <div align="center">
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;margin-top:30px">
            <asp:GridView ID="Grdtyre" runat="server" BorderStyle="Inset" BorderColor="brown" BorderWidth="1px"></asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>

