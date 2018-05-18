﻿<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleHistoryReport.aspx.cs" Inherits="VehicleHistoryReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                function pageLoad() {
                    $('#<%= ddlDistrict.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                    $('#<%= ddlVehNumber.ClientID %>').select2({
                        disable_search_threshold: 5,
                        search_contains: true,
                        minimumResultsForSearch: 20,
                        placeholder: "Select an option"
                    });
                }
            </script>
            <legend align="center" style="color: brown">Vehicle History Report</legend>
            <table align="center">

                <tr>
                    <td>
                        Select District <span style="color: red">*</span>
                        <asp:DropDownList ID="ddlDistrict" runat="server" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>

                    <td>
                        Select Vehicle <span style="color: red">*</span>
                        <asp:DropDownList ID="ddlVehNumber" Width="150px" runat="server" AutoPostBack="True"
                                          OnSelectedIndexChanged="ddlVehNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Month <span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="search_3" Width="150px" ID="ddlMonth" style="margin-left: -150px" runat="server" AutoPostBack="True"
                                          OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                            <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            <asp:ListItem Text="January" Value="1"></asp:ListItem>
                            <asp:ListItem Text="February" Value="2"></asp:ListItem>
                            <asp:ListItem Text="March" Value="3"></asp:ListItem>
                            <asp:ListItem Text="April" Value="4"></asp:ListItem>
                            <asp:ListItem Text="May" Value="5"></asp:ListItem>
                            <asp:ListItem Text="June" Value="6"></asp:ListItem>
                            <asp:ListItem Text="July" Value="7"></asp:ListItem>
                            <asp:ListItem Text="August" Value="8"></asp:ListItem>
                            <asp:ListItem Text="September" Value="9"></asp:ListItem>
                            <asp:ListItem Text="October" Value="10"></asp:ListItem>
                            <asp:ListItem Text="November" Value="11"></asp:ListItem>
                            <asp:ListItem Text="December" Value="12"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Year<span style="color: red">*</span>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="search_3" Width="150px" ID="ddlYear" style="margin-left: -150px" runat="server" AutoPostBack="True">
                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                            <asp:ListItem Text="2004" Value="2004"></asp:ListItem>
                            <asp:ListItem Text="2005" Value="2005"></asp:ListItem>
                            <asp:ListItem Text="2006" Value="2006"></asp:ListItem>
                            <asp:ListItem Text="2007" Value="2007"></asp:ListItem>
                            <asp:ListItem Text="2008" Value="2008"></asp:ListItem>
                            <asp:ListItem Text="2009" Value="2009"></asp:ListItem>
                            <asp:ListItem Text="2010" Value="2010"></asp:ListItem>
                            <asp:ListItem Text="2011" Value="2011"></asp:ListItem>
                            <asp:ListItem Text="2012" Value="2012"></asp:ListItem>
                            <asp:ListItem Text="2013" Value="2013"></asp:ListItem>
                            <asp:ListItem Text="2014" Value="2014"></asp:ListItem>
                            <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                            <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>

                    <td align="center">
                        <asp:Button CssClass="form-submit-button" runat="server" style="margin-bottom: 40px" Width="100px" Text="Show Report"
                                    OnClick="btnShowRpt_Click"/>
                    </td>
                    <td align="center">
                        <asp:Button CssClass="form-reset-button" runat="server" style="margin-bottom: 40px; margin-left: -60px;" Text="Export To Excel" Width="120px"
                                    OnClick="btnExportToExcel_Click"/>
                    </td>
                </tr>
            </tr>
            <tr>
                <td></td>
            </tr>
            </table>
            <table align="center">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleHistoryReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>