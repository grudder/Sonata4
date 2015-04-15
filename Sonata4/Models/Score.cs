using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sonata4.Models
{
	[Table("T_Score")]
	[DisplayName("分数记录")]
	public class Score
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id
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
