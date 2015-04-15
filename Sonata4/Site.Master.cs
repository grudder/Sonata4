using System;
using System.Web.UI;

#if !DEBUG
using Senparc.Weixin.MP.Helpers;

using Sonata4.Common;
#endif

namespace Sonata4
{
	public partial class SiteMaster : MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				return;
			}

#if DEBUG
			// only for debug
			Session["token"] = "TEMP:access_token";
			Session["openId"] = "TEMP:openid";
			Session["nickname"] = "TEMP:nickname";
#else
{
			if (Session["token"] == null)
			{
				Session["ReturnUrl"] = "~/";
				Response.Redirect("~/Common/Member.ashx");
			}
			else
			{
				CreateSign();
			}
}
#endif
		}

#if !DEBUG
		private void CreateSign()
		{
			JSSDKHelper helper = new JSSDKHelper();
			string jsapiTicket = ApiTicketContainer.GetTicket(Consts.AppId);
			string nonceStr = JSSDKHelper.GetNoncestr();
			string timestamp = JSSDKHelper.GetTimestamp();
			string signature = helper.GetSignature(jsapiTicket, nonceStr, timestamp, Request.Url.AbsoluteUri);

			ltlConfig.Text = "<script type='text/javascript'>" +
				"wx.config({debug: false, appId: '" + Consts.AppId + "', timestamp: " + timestamp + ", " +
				"nonceStr: '" + nonceStr + "', signature: '" + signature + "'," +
				"jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage','chooseImage','uploadImage'] " +
				"});</script>";
		}
#endif
	}
}