<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Sonata4.Default" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div data-role="page">
		<img class="auto-scale" src="Images/p1/p11.jpg" style="width: 640px; height: 1008px" />
		
		<a class="auto-scale" href="Stage1/Rule.aspx" data-transition="fade" data-ajax="false"
			style="cursor: pointer; position: absolute; z-index: 1; left: 215px; top: 590px; width: 200px; height: 140px">
		</a>

		<a class="auto-scale" href="Rule.aspx" data-transition="fade"
			style="position: absolute; z-index: 1; left: 42px; top: 745px; width: 153px; height: 66px">
		</a>

		<a class="auto-scale" href="Appointments/Create.aspx" data-transition="fade" data-ajax="false"
			style="cursor: pointer; position: absolute; z-index: 1; left: 445px; top: 745px; width: 153px; height: 66px">
		</a>
	</div>
</asp:Content>
