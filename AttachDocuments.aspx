<%@ Page AutoEventWireup="true" CodeFile="AttachDocuments.aspx.cs" Inherits="AttachDocuments" Language="C#" MasterPageFile="~/temp.master" %>

<%@ Import Namespace="System.ComponentModel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Reference Page="~/AccidentReport.aspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">

        function enableButton() {
            document.getElementById('<%= btnAttachFiles.ClientID %>').disabled = false;
        }

        function validation(obj, id) {

            id = obj.id.replace(id, "ddlistVehicleNumber");
            var ddlistAttachmentPurpose = obj.id.replace(id, "ddlistAttachmentPurpose");
            var txtRemarks = obj.id.replace(id, "txtRemarks");
            var attachmentPurpose = document.getElementById(ddlistAttachmentPurpose);
            var remarks = document.getElementById(txtRemarks);
            var fileAttachment = document.getElementById('<%= fileAttachmentPurpose.ClientID %>');


            if (id.selectedIndex === 0) {
                alert("Please select the attachment Purpose");
                id.focus();
                return false;
            }


            if (attachmentPurpose.selectedIndex === 0) {
                alert("Please select the attachment Purpose");
                attachmentPurpose.focus();
                return false;
            }

            if (trim(remarks.value) === '') {
                alert("Remarks Cannot be Blank");
                remarks.focus();
                return false;
            }

            if (fileAttachment.value === '') {
                alert("Upload a File");
                fileAttachment.focus();
                return false;
            }

            return true;
        }

        function trim(value) {
            value = value.replace(/^\s+/, '');
            value = value.replace(/\s+$/, '');
            return value;

        }

        function remark(e) {
            var keycode;
            if (window.event) keycode = window.event.keyCode;
            else if (event) keycode = event.keyCode;
            else if (e) keycode = e.which;
            else return true;
            if ((keycode !== 34) && (keycode !== 39)) {
                return true;
            } else {
                return false;
            }
        }

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
                        <asp:AsyncFileUpload ID="fileAttachmentPurpose" runat="server" CompleteBackColor="White"
                                             UploaderStyle="Modern" OnClientUploadComplete="enableButton"/>
                        <%-- <input type="file" id="fileAttachmentPurpose" runat="server" />--%>
                        <asp:Button ID="btnUpload" runat="server" Text="Upload" Visible="False"
                                    OnClick="btnUpload_Click"/>
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="False"/>
                    </td>
                </tr>
                <tr>
                    <td class="rowseparator"></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:Button ID="btnAttachFiles" runat="server" Text="Attach Files" Enabled="false"
                                    OnClick="btnAttachFiles_Click"/>
                        <asp:Button ID="btnHideViewAttachFiles" runat="server" Text="Hide/View Attached Files"
                                    Visible="false"/>
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

