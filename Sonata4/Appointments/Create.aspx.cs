using System;
using System.Linq;
using System.Web.UI;

using Sonata4.DataAccess;
using Sonata4.Models;

namespace Sonata4.Appointments
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

			LoadProvinces();
		}

		protected void ddlProvince_OnSelectedIndexChanged(object sender, EventArgs e)
		{
			LoadShopsByProvince();
		}

		protected void btnSubmit_OnClick(object sender, EventArgs e)
		{
			string name = tbxName.Text.Trim();
			string contact = tbxContact.Text.Trim();
			int shopId = int.Parse(ddlShop.SelectedValue);

			var appointment = new Appointment
			{
				WeixinId = Session["openId"].ToString(),
				Nickname = Session["nickname"].ToString(),
				Name = name,
				Contact = contact,
				ShopId = shopId,
				CreateTime = DateTime.Now
			};
			_db.Appointments.Add(appointment);
			_db.SaveChanges();

			Response.Redirect("~/");
		}

		private void LoadProvinces()
		{
			var provinces = _db.Shops.Select(s => new
			{
				Id = s.Province,
				Name = s.Province
			}).Distinct().ToList();

			ddlProvince.DataValueField = "Id";
			ddlProvince.DataTextField = "Name";
			ddlProvince.DataSource = provinces;
			ddlProvince.DataBind();

			LoadShopsByProvince();
		}

		private void LoadShopsByProvince()
		{
			string province = ddlProvince.SelectedValue;
			var shops = _db.Shops.Where(s => s.Province == province).ToList();

			ddlShop.DataValueField = "Id";
			ddlShop.DataTextField = "Name";
			ddlShop.DataSource = shops;
			ddlShop.DataBind();
		}
	}
}
