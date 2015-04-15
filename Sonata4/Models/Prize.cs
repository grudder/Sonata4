using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sonata4.Models
{
	[Table("T_Prize")]
	[DisplayName("奖品")]
	public class Prize
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "名称")]
		[StringLength(20)]
		public string Name
		{
			get;
			set;
		}

		[Display(Name = "图片")]
		[StringLength(200)]
		public string ImageUrl
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "中奖概率")]
		public int Probability
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "总数量")]
		public int TotalAmount
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "每天数量")]
		public int DailyAmount
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "是否中奖")]
		public bool IfWin
		{
			get;
			set;
		}
	}
}
