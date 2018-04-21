<%@ Page Title="" Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="IoclEmriRep.aspx.cs" Inherits="IoclEmriRep" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Reference Page="~/AccidentReport.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.10.2.min.js"></script>

    <script>
        function exp() {
            window.open('data:application/vnd.ms-excel,' +
                encodeURIComponent($('div[id$=ContentPlaceHolder1_Panel4]').html()));
        }

    </script>
    <style>
        td.width100 {
            max-width: 100px;
            min-width: 100px;
        }

        table.tablestyle { border: none; }
    </style>
    <script type="text/javascript">
        function rearrange() {
            var arrOfTable1 = [],
                i = 0;
            j = 0;
            var arrOfTable2 = [];
            arrOfTable1.push(123);
            arrOfTable1.push(1059);
            arrOfTable1.push(932);
            arrOfTable2.push(42);
            arrOfTable2.push(81);
            arrOfTable2.push(139);
            arrOfTable2.push(87);
            arrOfTable2.push(114);
            arrOfTable2.push(109);
            arrOfTable2.push(102);
            arrOfTable2.push(90);
            arrOfTable2.push(102);
            arrOfTable2.push(66);
            arrOfTable2.push(49);
            arrOfTable2.push(56);
            arrOfTable2.push(66);

            arrOfTable2.push(79);
            arrOfTable2.push(90);
            arrOfTable2.push(114);
            arrOfTable2.push(88);
            arrOfTable2.push(87);
            arrOfTable2.push(123);

            arrOfTable2.push(70);
            arrOfTable2.push(75);
            arrOfTable2.push(77);
            arrOfTable2.push(59);
            arrOfTable2.push(86);
            arrOfTable2.push(63);
            $('#ContentPlaceHolder1_tblHeader td').each(function() {
                // alert("a");
                //  alert(arrOfTable1[i]);
                $(this).css("min-width", arrOfTable1[i] + "px");
                $(this).css("max-width", arrOfTable1[i] + "px");
                $(this).css("width", arrOfTable1[i] + "px");
                $(this).css("word-wrap", "break-word");
                i++;
            });
            $('#ContentPlaceHolder1_grdRepData td').each(function() {
                // alert("a");
                //  alert(arrOfTable1[i]);
                $(this).css("min-width", arrOfTable2[j] + "px");
                $(this).css("max-width", arrOfTable2[j] + "px");
                $(this).css("width", arrOfTable2[j] + "px");
                $(this).css("word-wrap", "break-word");
                j++;
            });

        }

        $(document).ready(function() {

            rearrange();

        });
    </script>
    <script type="text/javascript">
   
       function ValidatePage()
        {
            var ddlVehicle = $('#<%= ddlvehicleNo.ClientID %> option:selected').text().toLowerCase();
            if (ddlVehicle === '--select--') {
               return alert("Please select Vehicle");

            }
            var txtFirstDate = $('#<%= txtfromdate.ClientID %>').val();
            var txtToDate = $('#<%= txttodate.ClientID %>').val();
            if (txtFirstDate === "") {
                //txtFirstDate.focus();
                return alert('From Date is Mandatory');
             
            }
            if (txtToDate === "") {         
               // txtToDate.focus();
                return alert("End Date is Mandatory");
            }
            var fromDate = (txtFirstDate).replace(/\D/g, '/');
            var toDate = (txtToDate).replace(/\D/g, '/');
            var ordFromDate = new Date(fromDate); var ordToDate = new Date(toDate);
            var currentDate = new Date();
            if (ordFromDate > currentDate) {
               return alert("From date should not be greater than today's date");
            }
            if (ordToDate < ordFromDate) {
               return alert("Please select valid date range");
            }
            return true;
        }
                
         
  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="main" class="row">

        <div id="mains" style="width: 100%;">
            <div id="first" style="float: left; width: 22%">
                <div class="row" style="margin-top: 20px">
                    <div class="col-sm-13" style="">
                        <label for="textfield" class="control-label col-sm-4" style="float: left; width: 23%;" id="PVlSuppCode9">
                            From&nbsp;Date
                        </label>

                        <div class="col-sm-6" style="width: 218px;" id="PVtSuppCode9">
                            <asp:TextBox ID="txtfromdate" Style="width: 170px;" runat="server" placeholder="" MaxLength="20"
                                         class="form-control">
                            </asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtfromdate" Enabled="true" CssClass="test">
                            </cc1:CalendarExtender>
                            <style type="text/css">
                                .test .ajax__calendar_body {
                                    background-color: gainsboro;
                                    border: 1px solid;
                                    color: lightslategray;
                                    font-family: Courier New;
                                    font-weight: bold;
                                    margin-top: 10px;
                                    width: 170px;
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
                        To&nbsp;Date
                    </label>
                    <div class="col-sm-6" style="width: 218px;" id="PVtSuppCode1">
                        <asp:TextBox ID="txttodate" Style="width: 170px;" runat="server" placeholder="" MaxLength="20"
                                     class="form-control">
                        </asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txttodate" Enabled="true" CssClass="test">
                        </cc1:CalendarExtender>
                    </div>
                </div>
            </div>
        </div>
        <div style="float: left; width: 30%">
            <div class="row" style="margin-top: 20px">
                <div class="col-sm-13" style="">
                    <label for="textfield" class="control-label col-sm-4" style="float: left; width: 20%;" id="PVlSuppCode1">
                        Vehicle Number
                    </label>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddlvehicleNo" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <div id="four" style="float: left; width: 6%">
            <div class="row" style="margin-top: 30px">
                <div class="col-sm-12" style="">
                    <asp:Button ID="btnShow" runat="server" class="btn btn-primary"
                                Text="Show" Style="border-radius: 3px; height: 33px; width: 55px;" OnClick="btnShow_Click" OnClientClick="if(!ValidatePage()) {return false;}">
                    </asp:Button>
                </div>
            </div>
        </div>
        <div id="five" style="float: left; width: 5%">
            <div class="row" style="margin-top: 30px">
                <asp:Button ID="btntoExcel" runat="server" OnClick="btntoExcel_Click" Text="Excel" Style="font-size: 12px; height: 33px; width: 50px;"></asp:Button>
            </div>
        </div>

    </div>
    <asp:Panel ID="Panel4" runat="server" Style="background-color: #F7F7F7; margin-left: 2px;">
        <div class="row" style="margin-left: 0%;">
            <div style="margin-left: 0%; margin-right: auto;">
                <table id="tblHeader" runat="server" class="table table-bordered" style="margin-bottom: 0px">
                    <tr>
                        <td>
                            ____
                        </td>
                        <td>
                            IOCL Transactions
                        </td>
                        <td>
                            EMRI Transactions
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="grdRepData" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered" ShowHeader="true" OnRowDataBound="grdRepData_RowDataBound">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="50px" HeaderText="Sno">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>
</asp:Content>