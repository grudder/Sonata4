using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Sonata4.Common
{
	/// <summary>
	/// CssHandler 的摘要说明
	/// </summary>
	public class CssHandler : IHttpHandler
	{
		public void ProcessRequest(HttpContext context)
		{
			string fileUrl = context.Request["fileUrl"];
			string filePath = context.Server.MapPath(fileUrl);
			string fileContent = ReadFileContent(filePath);

			float ratio = float.Parse(context.Request["_ratio"]);
			string cssFileContent = ConvertCssToFitSize(fileContent, ratio);

			context.Response.ContentType = "text/css";
			context.Response.Write(cssFileContent);
		}

		/// <summary>
		/// 读取文件内容。
		/// </summary>
		/// <param name="filePath">文件路径。</param>
		/// <returns>文件内容。</returns>
		private string ReadFileContent(string filePath)
		{
			if (!File.Exists(filePath))
			{
				return null;
			}

			using (var reader = new StreamReader(filePath, Encoding.UTF8))
			{
				string fileContent = reader.ReadToEnd();
				reader.Close();

				return fileContent;
			}
		}

		/// <summary>
		/// 将CSS文件的内容转换成合适的尺寸。
		/// </summary>
		/// <param name="cssFileContent">CSS文件的内容。</param>
		/// <param name="ratio">缩放比例。</param>
		/// <returns>转换后的CSS文件内容。</returns>
		private string ConvertCssToFitSize(string cssFileContent, float ratio)
		{
			Regex regexPixel = new Regex(@"(-?\d+[\.\d+]*)px");

			string[] lines = cssFileContent.Split('\n');
			for (int i = 0; i < lines.Length; i++)
			{
				string line = lines[i];
				if (line.Contains("matrix("))
				{
					if (line.Contains("matrix(1, 0, 0, 1, 0, 0)"))
					{
						continue;
					}

					const string t1 = "-webkit-transform: matrix(";
					string t2 = line.Substring(line.IndexOf(t1) + t1.Length).TrimStart('(');
					string t3 = t2.Substring(0, t2.IndexOf(")"));
					string t4 = t2.Substring(t2.IndexOf(")"));
					string[] nums = t3.Split(',');
					for (int n = 0; n < nums.Length; n++)
					{
						float n1 = float.Parse(nums[n]);
						if (Math.Abs(n1) > 1)
						{
							nums[n] = (n1 * ratio).ToString();
						}
					}
					lines[i] = t1 + String.Join(",", nums) + t4;
				}
				else if (line.Contains("-webkit-transform-origin:"))
				{
					if (!regexPixel.IsMatch(line))
					{
						continue;
					}
					string t = "-webkit-transform-origin: ";
					foreach (Match m in regexPixel.Matches(line))
					{
						float k = float.Parse(m.Groups[1].Value);
						t += k * ratio + "px ";
					}
					lines[i] = t.Trim() + ";";
				}
			}

			return String.Join("\n", lines);
		}

		public bool IsReusable
		{
			get
			{
				return false;
			}
		}
	}
}