using System;
using System.Web;
using System.Web.SessionState;

using Senparc.Weixin.MP.AdvancedAPIs.OAuth;

namespace Sonata4.Common
{
	/// <summary>
	///     Member 的摘要说明
	/// </summary>
	public class Member : IHttpHandler, IRequiresSessionState
	{
		const string RedirectUri = "http://weixin.unisw.com/sonata4/common/member.ashx";
		const string WeixinAuthUrl = @"https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_userinfo&state=query#wechat_redirect";

		public void ProcessRequest(HttpContext context)
		{
			string redirectAuthUrl = String.Format(WeixinAuthUrl, Consts.AppId, context.Server.UrlEncode(RedirectUri));
			context.Response.Charset = "utf-8";
			context.Response.ContentType = "application/json";
			string code = context.Request["code"];
			if (String.IsNullOrEmpty(code))
			{
				context.Response.Redirect(redirectAuthUrl);
				return;
			}

			OAuthAccessTokenResult result = OAuthApi.GetAccessToken(Consts.AppId, Consts.AppSecret, code);
			context.Session["token"] = result.access_token;
			context.Session["openId"] = result.openid;

			OAuthUserInfo userInfo = OAuthApi.GetUserInfo(result.access_token, result.openid);
			context.Session["nickname"] = userInfo.nickname;

			if (context.Session["ReturnUrl"] == null)
			{
				context.Response.Redirect("~/");
			}
			else
			{
				var url = context.Session["ReturnUrl"].ToString();
				context.Response.Redirect(url);
			}
		}

		public bool IsReusable
		{
			get
			{
				return false;
			}
		}
	}
}
