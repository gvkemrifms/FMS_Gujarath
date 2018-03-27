<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="FuelReport.aspx.cs" Inherits="FuelReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div id="main">
        
        <div id="mains" style="width: 100%;">
            <div id="first" style="float: left; width: 22%">
                <div class="row" style="margin-top: 20px">
                    <div class="col-sm-13" style="">
                        <label for="textfield" class="control-label col-sm-4" style="float: left; width: 23%;" id="PVlSuppCode9">
                            From&nbsp;Date</label>

                        <div class="col-sm-6" style="width: 218px;" id="PVtSuppCode9">
                            <asp:TextBox ID="txtfromdate" style="width:170px;" runat="server" placeholder="" MaxLength="20"
                                class="form-control"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtfromdate" Enabled="true" CssClass="test">
                            </cc1:CalendarExtender>
                            <style type="text/css">
                                .test .ajax__calendar_body {
                                    width: 170px;
                                    border: 1px solid;           
                                    margin-top: 10px;                
                                    background-color: gainsboro;             
                                    font-family:Courier New;                
                                    font-weight:bold;
                                    color:lightslategray;            
                                }             
                                                    
                                .test .ajax__calendar_header {            
                                    background-color: gainsboro;
                                    width: 170px;
                                }
                            </style>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="two" style="float: left; width: 20%">                 
            <div class="row" style="margin-top: 20px">
                <div class="col-sm-13" style="">
                    <label for="textfield" class="control-label col-sm-4" style="float: left; width: 20%;" id="PVlSuppCode1">
                        To&nbsp;Date</label>
                    <div class="col-sm-6" style="width: 218px;" id="PVtSuppCode1">
                        <asp:TextBox ID="txttodate"  style="width:170px;" runat="server" placeholder="" MaxLength="20"
                            class="form-control"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txttodate" Enabled="true" CssClass="test">
                        </cc1:CalendarExtender>
                    </div>
                </div>
            </div>
        </div>
       
        <div id="four" style="float: left; width: 6%">
            <div class="row" style="margin-top: 30px">
                <div class="col-sm-12" style="">
                    <asp:Button ID="btnShow" runat="server" class="btn btn-primary"
                        Text="Show"  Style="height: 33px; width: 55px; border-radius: 3px;" OnClick="btnShow_Click"></asp:Button>
                </div>
            </div>
        </div>
        <div id="five" style="float: left; width: 5%">
            <div class="row" style="margin-top: 30px">
                <asp:Button ID="btntoExcel" runat="server" OnClick="btntoExcel_Click" Text="Excel" Style="height: 33px; font-size: 12px; width: 50px;" ></asp:Button>
            </div>
        </div>

    </div>
    <div class="row" style="margin-left: 0%;">
        <div style="margin-left: 0%; margin-right: auto;">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Style="margin-top: 2%;"
                EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red"
                HeaderStyle-ForeColor="#337ab7" class="table table-striped table-bordered table-hover">
                <Columns>
                    <asp:TemplateField HeaderText="S&nbsp;No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle Number" />
			<asp:BoundField DataField="fuelentryid" HeaderText="Fuel Entry ID" />
                    <asp:BoundField DataField="Previous_odo" HeaderText="Opening ODO" />
                    <asp:BoundField DataField="present_odo" HeaderText="Closing ODO" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:BoundField DataField="KMPL" HeaderText="KMPL" />
                    <asp:BoundField DataField="Totalkm_Run" HeaderText="Totalkm&nbsp;Run" />
                    <asp:BoundField DataField="EntryDate" HeaderText="Filling&nbsp;Date" />
                    <asp:BoundField DataField="Pilot" HeaderText="Pilot&nbsp;Id" />
                    <asp:BoundField DataField="PilotName" HeaderText="Pilot&nbsp;Name" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" />
                    
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

