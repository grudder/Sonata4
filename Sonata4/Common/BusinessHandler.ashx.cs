using System;
using System.Linq;
using System.Web;
using System.Web.SessionState;

using Newtonsoft.Json;

using Sonata4.DataAccess;
using Sonata4.Models;

namespace Sonata4.Common
{
	/// <summary>
	/// 业务处理。
	/// </summary>
	public class BusinessHandler : IHttpHandler, IRequiresSessionState
	{
		private readonly ApplicationDbContext _db = new ApplicationDbContext();

		public void ProcessRequest(HttpContext context)
		{
			context.Response.Charset = "utf-8";
			context.Response.ContentType = "application/json";
			string action = context.Request["action"].Trim();
			string result = String.Empty;
			switch (action)
			{
				// 获取已使用的时间
				case "get-time-used":
					result = GetTimeUsed(context);
					break;

				// 保存已使用的时间
				case "save-time-used":
					SaveTimeUsed(context);
					break;

				// 保存并显示成绩和排名
				case "saveAndShowScore":
					result = SaveAndShowScore(context);
					break;

				// 抽奖
				case "draw-lottery":
					result = DrawLottery(context);
					break;
			}

			context.Response.Write(result);
		}

		public bool IsReusable
		{
			get
			{
				return false;
			}
		}

		private string GetTimeUsed(HttpContext context)
		{
			float timeUsed;
			if (context.Session["timeUsed"] == null)
			{
				timeUsed = 0F;
			}
			else if (!float.TryParse(context.Session["timeUsed"].ToString(), out timeUsed))
			{
				timeUsed = 0F;
			}

			return "{\"timeUsed\": " + timeUsed + "}";
		}

		private void SaveTimeUsed(HttpContext context)
		{
			float timeUsed = float.Parse(context.Request["timeUsed"]);
			context.Session["timeUsed"] = timeUsed;
		}

		private string DrawLottery(HttpContext context)
		{
			string weixinId = context.Session["openId"].ToString();
			bool winningExists = _db.Winnings.Any(i => i.WeixinId == weixinId);
			if (winningExists)
			{
				return "{\"valid\": false, \"message\": \"您已中奖，请继续关注北京现代其他精彩活动！\"}";
			}

			Prize prize = LotteryService.DrawLottery();
			context.Session["prize"] = prize;

			string jsonResult = "{{\"valid\": true, \"prize\": {0}}}";
			jsonResult = String.Format(jsonResult, JsonConvert.SerializeObject(prize));

			return jsonResult;
		}

		private string SaveAndShowScore(HttpContext context)
		{
			if (context.Session["timeUsed"] == null)
			{
				context.Session["timeUsed"] = 0.00;
			}

			float timeUsed = Convert.ToSingle(context.Session["timeUsed"]);
			string weixinId = context.Session["openId"].ToString();
			bool scoreExists = _db.Scores.Any(i => i.WeixinId == weixinId && Math.Abs(i.TimeUsed - timeUsed) < 0.01);
			if (!scoreExists)
			{
				var score = new Score
				{
					WeixinId = weixinId,
					Nickname = context.Session["nickname"].ToString(),
					TimeUsed = timeUsed,
					CreateTime = DateTime.Now
				};
				_db.Scores.Add(score);
				_db.SaveChanges();
			}

			int total = _db.Scores.Count();
			int worse = _db.Scores.Count(i => i.TimeUsed > timeUsed);
			int percent = (int)Math.Floor(worse * 100.0 / total);

			return "{\"timeUsed\": " + timeUsed.ToString("N") + ", \"percent\": " + percent + "}";
		}
	}
}
