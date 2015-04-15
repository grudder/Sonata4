using System;
using System.Web;

using Sonata4.Common;

namespace Sonata4
{
	public class Global : HttpApplication
	{
		void Application_Start(object sender, EventArgs e)
		{
			// 在应用程序启动时运行的代码
			Senparc.Weixin.MP.CommonAPIs.AccessTokenContainer.Register(Consts.AppId, Consts.AppSecret);
			ApiTicketContainer.Register(Consts.AppId, Consts.AppSecret);
		}

		void Application_End(object sender, EventArgs e)
		{
			//  在应用程序关闭时运行的代码

		}

		void Application_Error(object sender, EventArgs e)
		{
			// 在出现未处理的错误时运行的代码

		}
	}
}
