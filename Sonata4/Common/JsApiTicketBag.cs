using System;

using Senparc.Weixin.MP.Entities;

namespace Sonata4.Common
{
	public class JsApiTicketBag
	{
		/// <summary>
		///     只针对这个AppId的锁
		/// </summary>
		public object Lock = new object();

		public string AppId
		{
			get;
			set;
		}

		public string AppSecret
		{
			get;
			set;
		}

		public DateTime ExpireTime
		{
			get;
			set;
		}

		public JsApiTicketResult JsApiTicketResult
		{
			get;
			set;
		}
	}
}
