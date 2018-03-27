<%@ page title="" language="C#" masterpagefile="~/temp.master" autoeventwireup="true" inherits="GvkFMSAPP.PL.Reports.VehicleHistoryReport, App_Web_ttubqba0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="updtpnlVehicleHistoryReport" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select District :
                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        Select Vehicle :
                        <asp:DropDownList ID="ddlVehNumber" runat="server" AutoPostBack="True" 
                            onselectedindexchanged="ddlVehNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        Select Month :
                        <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="True" 
                            onselectedindexchanged="ddlMonth_SelectedIndexChanged">
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
                     <td>
                        </td>
                        <td>
                            Year :
                            <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="True">
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
                        <td>
                        </td>
                    <tr>
                    <td>
                    
                    </td>
                    <td>
                        <asp:Button ID="btnShowRpt" runat="server" Text="Show Report" 
                            onclick="btnShowRpt_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="142px"
                            OnClick="btnExportToExcel_Click" />
                    </td>
                    </tr>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <iframe id="iframe_VehicleHistoryReport" runat="server"></iframe>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

