<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Play.aspx.cs" Inherits="Sonata4.Stage1.Play" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div data-role="page">
		<img id="imgBg" class="auto-scale" src="../Images/p2/p22.jpg" style="width: 540px; height: 850.5px" />
		<img id="imgCar" class="auto-scale" src="../Images/p2/p25.png" style="position: absolute; z-index: 1; left: 90px; top: 272px; width: 145px; height: 68px" />
		<img id="imgSteeringWheel" class="auto-scale" src="../Images/p2/p24.png"
			style="position: absolute; z-index: 1; left: 80px; top: 675px; width: 156px; height: 156px" />
		<div class="auto-scale" onclick="stopToPark()"
			style="cursor: pointer; position: absolute; z-index: 1; left: 403px; top: 763px; width: 126px; height: 56px">
		</div>
		<img id="imgTooltip" class="auto-scale" src="../Images/p2/p27.png" style="position: absolute; z-index: 1; left: 110px; top: 755px; width: 285px; height: 77px" />
		<img id="imgReady" class="auto-scale" src="../Images/p2/p2224.png" style="display: none; position: absolute; z-index: 1; left: 220px; top: 250px; width: 183px; height: 47px" />
		<img id="imgGo" class="auto-scale" src="../Images/p2/p2225.png" style="display: none; position: absolute; z-index: 1; left: 220px; top: 250px; width: 183px; height: 47px" />

		<div class="auto-scale"
			style="cursor: pointer; position: absolute; z-index: 1; left: 260px; top: 220px; width: 180px; height: 22px">
			<span id="span-timer" style="font-weight: bolder; font-style: italic; font-size: 20px; line-height: 20px">
				用时：00:00:00
			</span>
		</div>

		<img id="imgEarly" class="auto-scale" src="../Images/p2/p26.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<img id="imgLate" class="auto-scale" src="../Images/p2/p27.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<img id="imgProper" class="auto-scale" src="../Images/p2/p28.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<a id="linkChangePage" class="auto-scale" style="position: absolute; z-index: 11; left: 255px; top: 498px; width: 128px; height: 55px">
		</a>
	</div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
	<script src="<%: ResolveUrl("~/Scripts/Polyfill.js") %>"></script>
	<script src="<%: ResolveUrl("~/Scripts/anima.min.js") %>"></script>
	<script>
		var _timeUsed = 0.0;
		var _timeSpan = 0.0;

		$(document).on("pageinit", function () {
			$("#span-timer").css({
				"font-size": 18 * _ratio + "px",
				"line-height": 20 * _ratio + "px"
			});
			readyGo();

			// 获取已使用的时间
			getTimeUsed();
		});

		// 获取已使用的时间
		function getTimeUsed() {
			var url = "../Common/BusinessHandler.ashx?action=get-time-used&r=" + Math.random();
			$.post(url, function (data) {
				_timeUsed = data.timeUsed;

				// 显示已使用的时间
				showTimer();
			});
		}

		// 保存已使用的时间
		function saveTimeUsed() {
			var url = "../Common/BusinessHandler.ashx?action=save-time-used&r=" + Math.random();
			$.post(url, { "timeUsed": _timeUsed + _timeSpan });
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
			$("#span-timer").text("用时：" + m + ":" + s + ":" + ms);
		}

		// 准备开始
		function readyGo() {
			$("#imgReady").show(1000, function () {
				$("#imgReady").hide();
				$("#imgGo").show(1000, function () {
					$("#imgGo").hide();
					$("#imgTooltip").hide();
					moveCar();
				});
			});
		}

		var requestId = 0;
		var animationStartTime = 0;

		// 向右移动汽车
		function moveCar() {
			try {
				animationStartTime = window.Date.now();
				requestId = window.requestAnimationFrame(animate);
			}
			catch (e) {
				alert(e);
			}
		}

		function animate() {
			_timeSpan = (window.Date.now() - animationStartTime) / 1000;
			showTimer();

			var car = $("#imgCar");
			var left = 90 + _timeSpan * 100;
			if (left > 460) {
				stopToPark();
				return;
			}

			car.css("left", left * _ratio + "px");
			requestId = window.requestAnimationFrame(animate);
		}

		// 停下来进行倒车
		function stopToPark() {
			if (!requestId) {
				return;
			}
			window.cancelAnimationFrame(requestId);
			requestId = 0;

			checkPosition();

			saveTimeUsed();
		}

		// 检查停车的位置是否正确
		function checkPosition() {
			var minLeft = 355;
			var maxLeft = 385;
			var left = parseFloat($("#imgCar").css("left")) / _ratio;
			if (left < minLeft) {
				// 早了
				$("#imgEarly").show();
				$("#linkChangePage").attr("href", "Early.aspx");
			}
			else if (left > maxLeft) {
				// 晚了
				$("#imgLate").show();
				$("#linkChangePage").attr("href", "Late.aspx");
			}
			else {
				// 合适
				_timeSpan += 2;
				showTimer();

				intoPark();
			}
		}

		// 停车入位
		function intoPark() {
			var world = anima.world();

			// 旋转方向盘
			var steeringWheel = world.add(document.querySelector("#imgSteeringWheel"));
			steeringWheel.animate({
				rotate: [0, 0, 45],
				duration: 2000
			}).animate({
				rotate: [0, 0, -45],
				duration: 2000
			});

			// 倒车
			var car = world.add(document.querySelector("#imgCar"));
			car.animate([{
				translate: [-120 * _ratio, 80 * _ratio, 0],
				duration: 2000,
				ease: "linear"
			}, {
				rotate: [0, 0, -55],
				duration: 2000,
				ease: "linear"
			}])
			.animate([{
				translate: [-70 * _ratio, 160 * _ratio, 0],
				duration: 2000,
				ease: "ease-in"
			}, {
				rotate: [0, 0, -35],
				duration: 2000,
				ease: "linear"
			}])
			.on("end", function () {
				// 动画完成后进行页面跳转
				$("#imgProper").show();
				$("#linkChangePage").attr("href", "Proper.aspx");
			});
		}
	</script>
</asp:Content>
