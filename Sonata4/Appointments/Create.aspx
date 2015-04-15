<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="Sonata4.Appointments.Create" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div data-role="page">
		<img class="auto-scale" src="../Images/p1/p13.jpg" style="width: 640px; height: 1008px" />

		<div class="auto-scale"
			style="cursor: pointer; position: absolute; z-index: 1; left: 165px; top: 480px; width: 440px; height: 220px">
			<form runat="server" method="post">
				<div data-role="fieldcontain">
					<asp:TextBox ID="tbxName" runat="server" />
					<asp:RequiredFieldValidator runat="server" Display="None" ControlToValidate="tbxName" ErrorMessage="请填写姓名" />
				</div>
				<div data-role="fieldcontain">
					<asp:TextBox ID="tbxContact" runat="server" />
					<asp:RequiredFieldValidator runat="server" Display="None" ControlToValidate="tbxContact" ErrorMessage="请填写联系方式" />
				</div>
				<div data-role="fieldcontain">
					<asp:DropDownList ID="ddlProvince" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvince_OnSelectedIndexChanged" />
					<asp:RequiredFieldValidator runat="server" Display="None" ControlToValidate="ddlProvince" ErrorMessage="请选择城市" />
				</div>
				<div data-role="fieldcontain">
					<asp:DropDownList ID="ddlShop" runat="server" />
					<asp:RequiredFieldValidator runat="server" Display="None" ControlToValidate="ddlShop" ErrorMessage="请选择4S店" />
				</div>
				<div style="display: none">
					<asp:Button ID="btnSubmit" runat="server" Text="提交" OnClick="btnSubmit_OnClick" />
				</div>
				<asp:ValidationSummary runat="server" ShowMessageBox="True" ShowSummary="False" />
			</form>
		</div>
		<div onclick="submit()" class="auto-scale"
			style="cursor: pointer; position: absolute; z-index: 1; left: 242px; top: 822px; width: 155px; height: 64px">
		</div>
	</div>
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
	<script>
		$(document).on("pageinit", function () {
			$(".ui-field-contain").each(function () {
				$(this).css({
					"margin": 0,
					"padding": 0,
					"border": 0
			});
			});
			$(".ui-input-text").each(function() {
				$(this).css({
					"margin-top": 0.3 * _ratio + "em",
					"margin-bottom": 0.3 * _ratio + "em"
				});
			});
			$(".ui-input-text input").each(function() {
				$(this).css({
					"padding": 0.2 * _ratio + "em",
					"height": 1.8 * _ratio + "em"
				});
			});
			$(".ui-select").each(function() {
				$(this).css({
					"margin-top": 0.4 * _ratio + "em",
					"margin-bottom": 0.4 * _ratio + "em",
					"padding": 0
				});
			});
			$(".ui-select span").each(function() {
				$(this).css({
					"font-size": 25 * _ratio + "px",
					"height": 25 * _ratio + "px",
					"line-height": 25 * _ratio + "px"
				});
			});
		});

		function submit() {
			var btnSubmitId = "<%: btnSubmit.ClientID %>";
			$("#" + btnSubmitId)[0].click();
		}
	</script>
</asp:Content>
