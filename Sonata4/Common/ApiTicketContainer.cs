using System;
using System.Collections.Generic;

using Senparc.Weixin.HttpUtility;
using Senparc.Weixin.MP.CommonAPIs;
using Senparc.Weixin.MP.Entities;

namespace Sonata4.Common
{
	public class ApiTicketContainer
	{
		public static Dictionary<string, JsApiTicketBag> JsApiTicketCollection =
		   new Dictionary<string, JsApiTicketBag>(StringComparer.OrdinalIgnoreCase);

		/// <summary>
		/// 注册应用凭证信息，此操作只是注册，不会马上获取Ticket，并将清空之前的Ticket。
		/// </summary>
		/// <param name="appId"></param>
		/// <param name="appSecret"></param>
		public static void Register(string appId, string appSecret)
		{
			JsApiTicketCollection[appId] = new JsApiTicketBag()
			{
				AppId = appId,
				AppSecret = appSecret,
				ExpireTime = DateTime.MinValue,
				JsApiTicketResult = new JsApiTicketResult()
			};
		}

		/// <summary>
		/// 获取可用Ticket
		/// </summary>
		/// <param name="appId"></param>
		/// <param name="getNewTicket">是否强制重新获取新的Ticket</param>
		/// <returns></returns>
		public static string GetTicket(string appId, bool getNewTicket = false)
		{
			return GetTicketResult(appId, getNewTicket).ticket;
		}

		/// <summary>
		/// 获取可用Ticket
		/// </summary>
		/// <param name="appId"></param>
		/// <param name="getNewTicket">是否强制重新获取新的Ticket</param>
		/// <returns></returns>
		private static JsApiTicketResult GetTicketResult(string appId, bool getNewTicket = false)
		{
			if (!JsApiTicketCollection.ContainsKey(appId))
			{
				throw new Exception("此appId尚未注册，请先使用JsApiTicketContainer.Register完成注册（全局执行一次即可）！");
			}

			var accessTicketBag = JsApiTicketCollection[appId];
			lock (accessTicketBag.Lock)
			{
				if (getNewTicket || accessTicketBag.ExpireTime <= DateTime.Now)
				{
					//已过期，重新获取
					var accessToken = AccessTokenContainer.GetToken(appId);

					var url = string.Format("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token={0}&type={1}",
											accessToken, "jsapi");
					accessTicketBag.JsApiTicketResult = Get.GetJson<JsApiTicketResult>(url);
					accessTicketBag.ExpireTime = DateTime.Now.AddSeconds(accessTicketBag.JsApiTicketResult.expires_in);
				}
			}
			return accessTicketBag.JsApiTicketResult;
		}
	}
}