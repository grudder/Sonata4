using System;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;

using Sonata4.DataAccess;
using Sonata4.Models;

namespace Sonata4
{
	public partial class Default : Page
	{
		private readonly ApplicationDbContext _db = new ApplicationDbContext();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack)
			{
				return;
			}

			string channel = Request.QueryString["channel"];
			if (String.IsNullOrEmpty(channel))
			{
				return;
			}
			channel = channel.Trim().ToUpper();
			Provider provider = _db.Providers.Single(p => p.Code == channel);
			provider.VisitCount++;
			_db.Entry(provider).State = EntityState.Modified;
			_db.SaveChanges();
		}
	}
}
