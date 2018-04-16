<%@ Page AutoEventWireup="true" CodeFile="AttachDocuments.aspx.cs" Inherits="AttachDocuments" Language="C#" MasterPageFile="~/temp.master" %>

<%@ Import Namespace="System.ComponentModel" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="Scripts/jquery-1.4.4.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <script src="js/Validation.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#<%= btnAttachFiles.ClientID %>').click(function() {
                var remarks = $('#<%= txtRemarks.ClientID %>').val();
                var fileAttachments = $('#<%= fileAttachmentPurpose.ClientID %>').val();
                var ddlVehicle = $('#<%= ddlistVehicleNumber.ClientID %> option:selected').text().toLowerCase();
                var attachmentPurpose =
                    $('#<%= ddlistAttachmentPurpose.ClientID %> option:selected').text().toLowerCase();
                if (ddlVehicle === '--select--') {
                    alert("Please select Vehicle");
                    e.preventDefault();
                }

                if (attachmentPurpose === 'select') {
                    alert("Please select Attachment Purpose");
                    e.preventDefault();
                }
                if (fileAttachments === "") {
                    alert("File Attachment is Mandatory");
                    e.preventDefault();
                }

                if (remarks === "") {
                    alert('Remarks is Mandatory');
                    remarks.focus();
                    e.preventDefault();
                }

            });
        });
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td class="tdlabel">
                        Vehicle Number<font color="red">*</font>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <asp:DropDownList ID="ddlistVehicleNumber" runat="server">
                        </asp:DropDownList>


                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td class="tdlabel">
                        Attachment Purpose<font color="red">*</font>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <asp:DropDownList ID="ddlistAttachmentPurpose" runat="server">
                            <asp:ListItem>SELECT</asp:ListItem>
                            <asp:ListItem Value="General">General</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td class="tdlabel">
                        Remarks<font color="red">*</font>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" onkeypress="return remark(event);"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td class="tdlabel">
                        Attachment<font color="red">*</font>
                    </td>
                    <td class="columnseparator"></td>
                    <td>
                        <asp:FileUpload ID="fileAttachmentPurpose" runat="server" ForeColor="red"/>
                        <asp:Button ID="btnAttachFiles" runat="server" Text="Attach Files" Enabled="true"
                                    OnClick="btnAttachFiles_Click"/>
                        <asp:Button ID="btnUpload" runat="server" Text="Upload" Visible="False" OnClick="btnUpload_Click"/>
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="True"/>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">

                        <asp:Button ID="btnHideViewAttachFiles" runat="server" Text="Hide/View Attached Files"
                                    Visible="False"/>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView ID="grdVehicleAttachment" runat="server" AutoGenerateColumns="False"
                                      Width="80%" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"
                                      CellPadding="3" CellSpacing="2" ForeColor="#333333" GridLines="None" AllowPaging="True"
                                      OnPageIndexChanging="grdVehicleAttachment_PageIndexChanging">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333"/>
                            <Columns>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AttachmentPurposeFile") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Remarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Attachment Purpose">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAttachmentPurpose" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AttachmentPurpose") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UploadDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUploadDate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CreatedDate", "{0:dd-MM-yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UploadBy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUploadBy" runat="server" Text="FE"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" Visible="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnDelete" runat="server" Text="Delete" CommandArgument='<% DataBinder.Eval(Container.Dataitem, "") %>'
                                                        CommandName="vehicleAccidentDelete">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510"/>
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510"/>
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center"/>
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White"/>
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White"/>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnAttachFiles"/>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

