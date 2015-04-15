using System;
using System.Web.UI;

using Sonata4.DataAccess;
using Sonata4.Models;

namespace Sonata4.Winnings
{
	public partial class Create : Page
	{
		private readonly ApplicationDbContext _db = new ApplicationDbContext();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				return;
			}

			var prize = Session["prize"] as Prize;
			if (prize == null)
			{
				Response.Redirect("~/");
				return;
			}

			imageBg.ImageUrl = prize.ImageUrl;
		}

		protected void btnSubmit_OnClick(object sender, EventArgs e)
		{
			string name = tbxName.Text.Trim();
			string contact = tbxContact.Text.Trim();

			var prize = Session["prize"] as Prize;
			if (prize == null)
			{
				Response.Redirect("~/");
				return;
			}

			float timeUsed;
			if (Session["timeUsed"] == null)
			{
				timeUsed = 0F;
			}
			else if (!float.TryParse(Session["timeUsed"].ToString(), out timeUsed))
			{
				timeUsed = 0F;
			}

			var winning = new Winning
			{
				PrizeId = prize.Id,
				WeixinId = Session["openId"].ToString(),
				Nickname = Session["nickname"].ToString(),
				Name = name,
				Contact = contact,
				TimeUsed = timeUsed,
				CreateTime = DateTime.Now
			};
			_db.Winnings.Add(winning);
			_db.SaveChanges();

			Session["prize"] = null;

			Response.Redirect("~/");
		}
	}
}
