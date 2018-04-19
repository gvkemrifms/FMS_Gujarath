<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="GpsKm.aspx.cs" Inherits="GpsKm" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
    <div id="main" class="row">
        <div class="row">
            <div class="col-xs-12">
                <div class="panel">
                    <header class="panel-heading">
                        Vehicle List
                    </header>
                    <div class="row" runat="server" id="dvSearch" visible="false">
                        <div class="col-md-12">
                            <div class="panel-body">
                                <div class="form-horizontal tasi-form">
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Vehicle Number</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtVehicleNumber" runat="server" class="form-control" onkeypress="return numeric_only(event)"
                                                         MaxLength="12">
                                            </asp:TextBox>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Limit</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtLimit" runat="server" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Petrocard Number</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtCardNumber" runat="server" class="form-control" onkeypress="return numeric_only(event)"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Can Push automatically</label>
                                        <div class="col-sm-10">
                                            <asp:CheckBox runat="server" ID="chkpush"/>
                                        </div>
                                    </div>
                                    <div>
                                        <asp:Button runat="server" Text="Update and Submit" OnClick="btnsubmit_Click" ID="btnsubmit"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <div id="five" style="float: left; width: 5%">
            <div class="row" style="margin-top: 30px">
                <asp:Button ID="btntoExcel" runat="server" OnClick="btntoExcel_Click" Text="Excel" Style="height: 33px; font-size: 12px; width: 50px;"></asp:Button>
            </div>
        </div>

    </div>
    <div class="panel-body table-responsive">
        <asp:GridView ID="grdRepData" runat="server" OnRowCommand="grdRepData_RowCommand" AutoGenerateColumns="true" CssClass="table table-bordered" ShowHeader="true">
            <Columns>
                <asp:TemplateField HeaderText="Change">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "vehiclenumber") %>'
                                        CommandName="change" Text="Change">
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

