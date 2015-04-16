<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proper.aspx.cs" Inherits="Sonata4.Stage2.Proper" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div data-role="page" class="wlby_movie">
		<div class="auto-scale"
			style="cursor: pointer; position: absolute; z-index: 1; left: 260px; top: 220px; width: 180px; height: 22px">
			<span id="span-timer" style="display: none; font-weight: bolder; font-style: italic; font-size: 20px; line-height: 20px">
				用时：00:00:00
			</span>
		</div>
		<div class="auto-scale" onclick="lottery()"
			style="cursor: pointer; position: absolute; z-index: 1; left: 256px; top: 755px; width: 126px; height: 53px">
		</div>

		<div class="wlby_graphic">
			<input type="image" id="imgBg" class="wlby_49 auto-scale" src="../Images/p3/p35.jpg" style="width: 540px; height: 850.5px" />
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_3 wlby_fs">
				<!-- Start of symbol: 元件 11 -->
				<img src="../Images/p3/p229.png" height="96px" width="438px" class="wlby_4"/>
				<!-- End of symbol: 元件 11 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_5 wlby_fs"></div>
			<div class="wlby_6">
				<!-- Start of symbol: 元件 1 -->
				<img src="../Images/p3/p221.png" height="139px" width="113px" class="wlby_7"/>
				<!-- End of symbol: 元件 1 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_8 wlby_fs"></div>
			<div class="wlby_9">
				<!-- Start of symbol: 元件 3 -->
				<img src="../Images/p3/p331.png" height="260px" width="109px" class="wlby_10"/>
				<!-- End of symbol: 元件 3 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_5 wlby_fs"></div>
			<div class="wlby_11">
				<!-- Start of symbol: 元件 2 -->
				<img src="../Images/p3/p222.png" height="269px" width="200px" class="wlby_12"/>
				<!-- End of symbol: 元件 2 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_13 wlby_fs"></div>
			<div class="wlby_14">
				<!-- Start of symbol: 元件 4 -->
				<img src="../Images/p3/p224.png" height="77px" width="80px" class="wlby_15"/>
				<!-- End of symbol: 元件 4 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_16 wlby_fs"></div>
			<div class="wlby_17">
				<!-- Start of symbol: 元件 10 -->
				<img src="../Images/p3/wave-01.png" height="72px" width="72px" class="wlby_18"/>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_20 wlby_fs"></div>
					<img src="../Images/p3/wave-02.png" height="72px" width="72px" class="wlby_50"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_22 wlby_fs"></div>
					<img src="../Images/p3/wave-03.png" height="73px" width="72px" class="wlby_51"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_25 wlby_fs"></div>
					<img src="../Images/p3/wave-04.png" height="72px" width="72px" class="wlby_52"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_27 wlby_fs"></div>
					<img src="../Images/p3/wave-05.png" height="72px" width="72px" class="wlby_53"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_29 wlby_fs"></div>
					<img src="../Images/p3/wave-06.png" height="72px" width="72px" class="wlby_54"/>
				</div>
				<!-- End of symbol: 元件 10 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_16 wlby_fs"></div>
			<div class="wlby_31">
				<!-- Start of symbol: 元件 10 -->
				<img src="../Images/p3/wave-01.png" height="72px" width="72px" class="wlby_18"/>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_20 wlby_fs"></div>
					<img src="../Images/p3/wave-02.png" height="72px" width="72px" class="wlby_50"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_22 wlby_fs"></div>
					<img src="../Images/p3/wave-03.png" height="73px" width="72px" class="wlby_51"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_25 wlby_fs"></div>
					<img src="../Images/p3/wave-04.png" height="72px" width="72px" class="wlby_52"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_27 wlby_fs"></div>
					<img src="../Images/p3/wave-05.png" height="72px" width="72px" class="wlby_53"/>
				</div>
				<div class="wlby_19 wlby_sprite">
					<div class="wlby_29 wlby_fs"></div>
					<img src="../Images/p3/wave-06.png" height="72px" width="72px" class="wlby_54"/>
				</div>
				<!-- End of symbol: 元件 10 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_16 wlby_fs"></div>
			<div class="wlby_32">
				<!-- Start of symbol: 元件 5 -->
				<img src="../Images/p3/p332.png" height="130px" width="57px" class="wlby_33"/>
				<!-- End of symbol: 元件 5 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_34 wlby_fs"></div>
			<div class="wlby_35">
				<!-- Start of symbol: 元件 6 -->
				<img src="../Images/p3/p333.png" height="130px" width="57px" class="wlby_33"/>
				<!-- End of symbol: 元件 6 -->
			</div>
		</div>
		<div class="wlby_1 wlby_graphic">
			<div class="wlby_36 wlby_fs"></div>
			<div class="wlby_37">
				<!-- Start of symbol: 元件 7 -->
				<img src="../Images/p3/p227.png" height="76px" width="80px" class="wlby_38"/>
				<!-- End of symbol: 元件 7 -->
			</div>
		</div>
		<div class="wlby_graphic">
			<img src="../Images/p3/p35.png" height="129px" width="60px" class="wlby_55 wlby_fs"/>
			<div class="wlby_40 wlby_fs">
				<!-- Start of symbol: 补间 5 -->
				<img src="../Images/p3/p35.png" height="129px" width="60px" class="wlby_41"/>
				<!-- End of symbol: 补间 5 -->
			</div>
			<img src="../Images/p3/p35.png" height="129px" width="60px" class="wlby_56 wlby_fs"/>
			<img src="../Images/p3/p35.png" height="129px" width="60px" class="wlby_57 wlby_fs"/>
			<div class="wlby_45">
				<!-- Start of symbol: 元件 9 -->
				<div class="wlby_46">
					<!-- Start of symbol: 补间 1 -->
					<div class="wlby_47">
						<!-- Start of symbol: 元件 8 -->
						<img src="../Images/p3/p35.png" height="129px" width="60px" class="wlby_48"/>
						<!-- End of symbol: 元件 8 -->
					</div>
					<!-- End of symbol: 补间 1 -->
				</div>
				<!-- End of symbol: 元件 9 -->
			</div>
		</div>
	</div>
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
	<script src="../Scripts/Stage2.js"></script>
	<script>
		var _timeUsed = 4.1;
		var _timeSpan = 0.0;

		$(document).on("pageinit", function () {
			var cssFilePath = "../Common/CssHandler.ashx?fileUrl=~/Content/Stage2.css&_ratio=" + _ratio;
			importCssFile(cssFilePath);

			$("#span-timer").css({
				"font-size": 18 * _ratio + "px",
				"line-height": 20 * _ratio + "px"
			});
			$("img").each(function () {
				var width = parseFloat($(this).width());
				var height = parseFloat($(this).height());
				$(this).css({
					"width": width * _ratio,
					"height": height * _ratio
				});
			});

			intoPark();
		});

		var requestId = 0;
		var animationStartTime = 0;

		// 停车入位的过程中计时
		function intoPark() {
			try {
				animationStartTime = window.Date.now();
				requestId = window.requestAnimationFrame(startAnimate);
			} catch (e) {
				alert(e);
			}
		}

		function startAnimate() {
			_timeSpan = (window.Date.now() - animationStartTime) / 1000;
			if (6.6 <= _timeSpan && _timeSpan <= 8.2) {
				_timeSpan = _timeSpan - 6.6;
				showTimer();
			}
			else if (10.8 <= _timeSpan && _timeSpan <= 13.3) {
				_timeSpan = _timeSpan - 10.8 + 1.6;
				showTimer();
			}
			else if (_timeSpan > 13.3) {
				stopAnimate();
			}
			requestId = window.requestAnimationFrame(startAnimate);
		}

		function stopAnimate() {
			if (!requestId) {
				return;
			}
			window.cancelAnimationFrame(requestId);
			requestId = 0;
		}

		// 显示计时器
		function showTimer() {
			var seconds = _timeUsed + _timeSpan;
			var m = parseInt(seconds / 60);
			if (m < 10) {
				m = "0" + m;
			}
			var s = parseInt(seconds - m * 60);
			if (s < 10) {
				s = "0" + s;
			}
			var ms = parseInt((seconds - m * 60 - s) * 100);
			if (ms < 10) {
				ms = "0" + ms;
			}
			$("#span-timer").show();
			$("#span-timer").text("用时：" + m + ":" + s + ":" + ms);
		}

		function lottery() {
			var url = "../Common/BusinessHandler.ashx?action=draw-lottery&r=" + Math.random();
			$.ajax({
				type: "POST",
				url: url,
				error: function (xmlHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				},
				success: function (data) {
					if (data.valid === false) {
						// 已经中过奖，不再具有中奖资格
						//alert(data.message);
						location.href = "../Winnings/Lose.aspx";
						return;
					}

					if (data.prize !== null && data.prize.IfWin === true) {
						// 中奖
						location.href = "../Winnings/Create.aspx";
					}
					else {
						// 未中奖
						location.href = "../Winnings/Lose.aspx";
					}
				}
			});
		}
	</script>
</asp:Content>
