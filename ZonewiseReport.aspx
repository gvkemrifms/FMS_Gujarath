<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="ZonewiseReport.aspx.cs" Inherits="ZonewiseReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <table>
    <tr>
        <td>
       <asp:Label ID="lblcardtypereport" style="font-size:20px;color:brown" runat="server" Text="ZoneWise&nbsp;Report"></asp:Label> 
        </td>
    </tr>
    </table>
    
          <table style="width:70px;margin-left:125px;">
    <tr>
        
        <td>
           <asp:Label ID="lbldistrict" runat="server" Text="Select&nbsp;District"></asp:Label>              
        </td>
        
        <td>
            <asp:DropDownList ID="ddldistrict" runat="server" style="width:100px" AutoPostBack="True"></asp:DropDownList>
        </td>

        
        <td>
            <asp:Label ID="lblmonth" runat="server" Text="Select&nbsp;Month"></asp:Label>
        </td>
 <td>
     <asp:DropDownList ID="ddlmonth" runat="server" style="width:100px" AutoPostBack="true">
     
                      
                      
                  
                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
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
            <asp:Label ID="lblyear" runat="server" Text="Select&nbsp;Year"></asp:Label>
        </td>

<td>
    <asp:DropDownList ID="ddlyear" runat="server" style="width:100px">
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
                                <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
				                <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
				                <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
				                <asp:ListItem Text="2020" Value="2020"></asp:ListItem>

    </asp:DropDownList>
</td>
        <td>
            <asp:Button runat="server" Text="ShowReport" OnClick="btnsubmit_Click"></asp:Button>
        </td>
       
        <td>   
              <asp:Button runat="server" Text="ExportExcel" OnClick="btntoExcel_Click"></asp:Button> 
         </td>
              
          
    </tr>
    
          </table>
     <div>
        <asp:Panel ID="Panel2" runat="server" Style="margin-left: 2px;">
            <asp:GridView ID="Grddetails" EmptyDataText="Records Not Available" runat="server" ShowHeaderWhenEmpty="true"></asp:GridView>
        </asp:Panel>
    </div>

</asp:Content>





