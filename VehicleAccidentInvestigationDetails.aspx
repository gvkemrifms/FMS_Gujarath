<%@ Page Language="C#" MasterPageFile="~/temp.master" AutoEventWireup="true" CodeFile="VehicleAccidentInvestigationDetails.aspx.cs" Inherits="VehicleAccidentInvestigationDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/Validation.js"></script>
<script language="javascript" type="text/javascript">

    function vehicleCostAddition(obj) {
        if (!parseFloat(obj.value)) {
            alert('The value should be a valid decimal value and cannot be zero');
            obj.value = '';
        } else {
            var totalCostofRepairs = document.getElementById('<%= TxtTotalCostofRepairs.ClientID %>').value === ''
                ? 0
                : document.getElementById('<%= TxtTotalCostofRepairs.ClientID %>').value;
            var amountRecievedFromInsurance =
                document.getElementById('<%= TxtAmountRecievedFromInsurance.ClientID %>').value === ''
                    ? 0
                    : document.getElementById('<%= TxtAmountRecievedFromInsurance.ClientID %>').value;
            var costToCompany = document.getElementById('<%= TxtCostToCompany.ClientID %>');
            costToCompany.value = (parseFloat(totalCostofRepairs) - parseFloat(amountRecievedFromInsurance)).toFixed(2);
        }
    }

    function validation() {
        var costToCompany = document.getElementById('<%= TxtCostToCompany.ClientID %>');
        costToCompany.value =
            (parseFloat(window.TotalCostofRepairs) - parseFloat(window.AmountRecievedFromInsurance)).toFixed(2);

    }
</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<table cellpadding="1em" cellspacing="2em" width="100%">
<tr>
    <td>
        <fieldset>
            <legend>Vehicle Accident Investigation Details </legend>
            <table style="padding: 1em" width="100%">
                <tr>
                    <td>
                        <asp:Label ID="lblVehicleNumber" runat="server" Text="Vehicle Number"></asp:Label>
                    </td>
                    <td>
                        <cc1:ComboBox AutoCompleteMode="Append" ID="ddlistVehicleNumber" runat="server" Width="130px"
                                      AutoPostBack="True" DropDownStyle="DropDownList" OnSelectedIndexChanged="ddlistVehicleNumber_SelectedIndexChanged">
                        </cc1:ComboBox>
                        <asp:TextBox ID="txtVehNum" runat="server"></asp:TextBox>

                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblPolicyNumber" runat="server" Text="Policy Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtPolicyNumber" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblAccidentDateTime" runat="server" Text="Accident Date Time"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtAccidentDateTime" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate" Style="float: left" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="TxtAccidentDateTime_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                              PopupButtonID="imgPODate" TargetControlID="TxtAccidentDateTime">
                        </cc1:CalendarExtender>
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblAgency" runat="server" Text="Agency"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtAgency" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblAccidentTitle" runat="server" Text="Accident Title"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtAccidentTitle" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblInsuranceStartDate" runat="server" Text="Insurance Start Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtInsuranceStartDate" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate1" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="TxtInsuranceStartDate_CalendarExtender" runat="server"
                                              Format="MM/dd/yyyy" PopupButtonID="imgPODate1" TargetControlID="TxtInsuranceStartDate">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblSpotSurveyor" runat="server" Text="Spot Surveyor"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtSpotSurveyor" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblInsuranceEndDate" runat="server" Text="Insurance End Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtInsuranceEndDate" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate2" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="TxtInsuranceEndDate_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                              PopupButtonID="imgPODate2" TargetControlID="TxtInsuranceEndDate">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblSpotSurveyorDate" runat="server" Text="Spot Surveillance Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtSpotSurveyorDate" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate11" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="LblSpotSurveyorDate_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                              PopupButtonID="imgPODate11" TargetControlID="TxtSpotSurveyorDate">
                        </cc1:CalendarExtender>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblFinalSurveyor" runat="server" Text="Final Surveyor"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtFinalSurveyor" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblReinspectionSurveyor" runat="server" Text="Re-inspection Surveyor"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtReinspectionSurveyor" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LblFinalSurveyorDate" runat="server" Text="Final Surveillance Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtFinalSurveyorDate" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate10" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="TxtFinalSurveyorDate_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                              PopupButtonID="imgPODate10" TargetControlID="TxtFinalSurveyorDate">
                        </cc1:CalendarExtender>
                    </td>
                    <td>
                    <td></td>
                    <td>
                        <asp:Label ID="LblReinspectionSurveyorDate" runat="server" Text="Re-inspection Surveillance Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtReinspectionSurveyorDate" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="imgPODate6" runat="server" ImageUrl="images/Calendar.gif"/>
                        <cc1:CalendarExtender ID="TxtReinspectionSurveyorDate_CalendarExtender" runat="server"
                                              Format="MM/dd/yyyy" PopupButtonID="imgPODate6" TargetControlID="TxtReinspectionSurveyorDate">
                        </cc1:CalendarExtender>
                    </td>
                </tr>
            </table>
        </fieldset>
    </td>
</tr>
<tr>
    <td>
        <table style="padding-left: 115px; padding-right: 40px; padding-top: 5px">
            <tr>
                <td>
                    <asp:Label ID="LblClaimFormSubmissionDate" runat="server" Text="Claim Form Submission Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtClaimFormSubmissionDate" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imgPODate7" runat="server" ImageUrl="images/Calendar.gif"/>
                    <cc1:CalendarExtender ID="TxtClaimFormSubmissionDate_CalendarExtender" runat="server"
                                          Format="MM/dd/yyyy" PopupButtonID="imgPODate7" TargetControlID="TxtClaimFormSubmissionDate">
                    </cc1:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblTotalCostofRepairs" runat="server" Text="Total Cost of Repairs"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtTotalCostofRepairs" runat="server" onchange="return vehicleCostAddition(this)"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblSurveyorAssessmentValue" runat="server" Text="Surveyor Assessment Value"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtSurveyorAssessmentValue" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblBillSubmissionDate" runat="server" Text="Bill Submission Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtBillSubmissionDate" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imgPODate8" runat="server" ImageUrl="images/Calendar.gif"/>
                    <cc1:CalendarExtender ID="TxtBillSubmissionDate_CalendarExtender" runat="server"
                                          Format="MM/dd/yyyy" PopupButtonID="imgPODate8" TargetControlID="TxtBillSubmissionDate">
                    </cc1:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblPaymentStatus" runat="server" Text="Payment Status"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlistPaymentStatus" runat="server">
                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                        <asp:ListItem Value="1">Pending for Claim</asp:ListItem>
                        <asp:ListItem Value="2">Under repair</asp:ListItem>
                        <asp:ListItem Value="3">Bill Submitted</asp:ListItem>
                        <asp:ListItem Value="4">Pending for Settlement</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblRemarks" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td style="padding-top: 4px">
                    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250" TextMode="MultiLine"
                                 Width="150px">
                    </asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblPaymentRecievedDate" runat="server" Text="Payment Recieved Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtPaymentRecievedDate" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imgPODate9" runat="server" ImageUrl="images/Calendar.gif"/>
                    <cc1:CalendarExtender ID="TxtPaymentRecievedDate_CalendarExtender" runat="server"
                                          Format="MM/dd/yyyy" PopupButtonID="imgPODate9" TargetControlID="TxtPaymentRecievedDate">
                    </cc1:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblChequeNo" runat="server" Text="Cheque No"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtChequeNo" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblAmountRecievedFromInsurance" runat="server" Text="Amount Recieved From Insurance"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtAmountRecievedFromInsurance" runat="server" onchange="return vehicleCostAddition(this)"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LblCostToCompany" runat="server" Text="Cost To Company"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TxtCostToCompany" runat="server" onkeypress="return false"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                </td>
                <td></td>
            </tr>
            <tr style="padding: 1em;">
                <td style="float: right">
                    <asp:Button ID="BtnSave" runat="server" Text="Save" Width="70px" OnClick="BtnSave_Click"/>
                </td>
                <td>
                    <asp:Button ID="BtnReset" runat="server" Text="Reset" Width="70px"
                                OnClick="BtnReset_Click"/>
                </td>
                <td></td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:GridView ID="gvVehicleDetails" AutoGenerateColumns="false" runat="server"
                                  ForeColor="#333333" BorderWidth="1px" CssClass="gridviewStyle" GridLines="None"
                                  CellPadding="4" CellSpacing="2" Width="630px"
                                  OnRowCommand="gvVehicleDetails_RowCommand">
                        <RowStyle CssClass="rowStyleGrid"/>

                        <Columns>
                            <asp:TemplateField HeaderText="S No" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="2%"/>
                            </asp:TemplateField>
                            <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle Number"
                                            ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AccidentDateTime" HeaderText="Accident DateTime"/>
                            <asp:BoundField DataField="AccidentTitle" HeaderText="Accident Title"/>
                            <asp:BoundField DataField="PayStatus" HeaderText="Status"/>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="_Details" Text="View Details" CommandArgument=" <%# Container.DataItemIndex %>"/>
                                    <asp:HiddenField ID="hdnvehicelvalue" runat="server" Value='<%#Eval("VehicelInsuranceDetId") %>'/>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle CssClass="footerStylegrid"/>
                        <PagerStyle CssClass="pagerStylegrid"/>
                        <SelectedRowStyle CssClass="selectedRowStyle"/>
                        <HeaderStyle CssClass="headerStyle"/>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
