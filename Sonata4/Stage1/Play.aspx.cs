using System;
using System.Web.UI;

namespace Sonata4.Stage1
{
	public partial class Play : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				return;
			}

			if (Request.UrlReferrer == null)
			{
				return;
			}
			if (Request.UrlReferrer.AbsolutePath.Contains("/Stage1/Rule.aspx"))
			{
				// 清空已使用的时间
				Session["timeUsed"] = 0F;
			}
		}
	}
}