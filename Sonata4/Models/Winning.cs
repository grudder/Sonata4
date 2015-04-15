using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sonata4.Models
{
	[Table("T_Winning")]
	[DisplayName("获奖")]
	public class Winning
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "奖品")]
		public int PrizeId
		{
			get;
			set;
		}

		[ForeignKey("PrizeId")]
		public virtual Prize Prize
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "微信号")]
		[StringLength(100)]
		public string WeixinId
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "昵称")]
		[StringLength(100)]
		public string Nickname
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "姓名")]
		[StringLength(20)]
		public string Name
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "联系方式")]
		[StringLength(40)]
		public string Contact
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "用时")]
		public float TimeUsed
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "创建时间")]
		public DateTime CreateTime
		{
			get;
			set;
		}
	}
}
