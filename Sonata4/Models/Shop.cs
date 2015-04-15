using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sonata4.Models
{
	[Table("T_Shop")]
	[DisplayName("4S店")]
	public class Shop
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "店代码")]
		[StringLength(10)]
		public string Code
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "特约店名称")]
		[StringLength(20)]
		public string Name
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "区域经理")]
		[StringLength(10)]
		public string Manager
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "省份")]
		[StringLength(10)]
		public string Province
		{
			get;
			set;
		}

		[Required]
		[Display(Name = "办事处")]
		[StringLength(10)]
		public string Office
		{
			get;
			set;
		}
	}
}
