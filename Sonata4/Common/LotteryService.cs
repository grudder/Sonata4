using System;
using System.Collections.Generic;
using System.Linq;

using Sonata4.DataAccess;
using Sonata4.Models;

namespace Sonata4.Common
{
	/// <summary>
	/// 抽奖服务。
	/// </summary>
	public class LotteryService
	{
		private static readonly ApplicationDbContext Db = new ApplicationDbContext();

		/// <summary>
		/// 随机抽奖。
		/// </summary>
		/// <returns>奖品。</returns>
		public static Prize DrawLottery()
		{
			// 奖品池
			var prizePool = new List<Prize>();

			// 按照概率构造奖品池
			var prizes = Db.Prizes.Where(i => i.Probability > 0).ToList();
			foreach (Prize prize in prizes)
			{
				if (!prize.IfWin)
				{
					// 不获奖的情况
					for (int i = 0; i < prize.Probability; ++i)
					{
						prizePool.Add(prize);
					}
				}
				else
				{
					// 获奖的情况
					int totalCount = Db.Winnings.Count(i => i.PrizeId == prize.Id);
					if (totalCount < prize.TotalAmount)
					{
						// 奖品总数还有剩余
						DateTime maxDateTime = DateTime.Today.AddDays(1);
						int todayCount = Db.Winnings.Count(i => i.PrizeId == prize.Id
							&& i.CreateTime >= DateTime.Today
							&& i.CreateTime < maxDateTime);
						if (todayCount < prize.DailyAmount)
						{
							// 当天奖品数还有剩余
							for (int i = 0; i < prize.Probability; ++i)
							{
								prizePool.Add(prize);
							}
						}
					}
				}
			}

			if (prizePool.Count == 0)
			{
				// 奖池为空
				return null;
			}

			// 产生随机索引值
			int index = new Random().Next(prizePool.Count);

			// 抽取奖品
			Prize resultPrize = prizePool[index];

			return resultPrize;
		}
	}
}