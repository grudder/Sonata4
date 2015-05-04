using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sonata4.Models
{
	[Table("T_Provider")]
	[DisplayName("经销商")]
	public class Provider
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
		[Display(Name = "访问次数")]
		public int VisitCount
		{
			get;
			set;
		}
	}
}
