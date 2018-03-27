<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="OnroadReport.aspx.cs" Inherits="OnroadReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div id="main">
        
            
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
                    <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle&nbsp;Number" />     
<asp:BoundField DataField="OffRoadVehcileId" HeaderText="Offroad Vehicle Id" />              
                    <asp:BoundField DataField="OffRoadDate" HeaderText="Inactive From" />
 			<asp:BoundField DataField="ExpDateOfRecovery" HeaderText="Expected Date of Recovery" />
			
                    <asp:BoundField DataField="downodo" HeaderText="Down Odo Reading" />  
                  
                    <asp:BoundField DataField="District" HeaderText="District" />
                    <asp:BoundField DataField="ReasonForOffRoad" HeaderText="Reason" />
                   
                    <asp:BoundField DataField="totEstCost" HeaderText="Estimated Cost" />
                    <asp:BoundField DataField="PilotName" HeaderText="Pilot Details" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" />
                    <asp:BoundField DataField="RequestedBy" HeaderText="Requested By" />
                    
             

				 			

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

