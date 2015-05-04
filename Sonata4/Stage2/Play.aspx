<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Play.aspx.cs" Inherits="Sonata4.Stage2.Play" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div data-role="page">
		<img id="imgBg" class="auto-scale" src="../Images/p3/p32.jpg" style="width: 540px; height: 850.5px" />
		<img id="imgCar" class="auto-scale" src="../Images/p3/p35.png" style="position: absolute; z-index: 1; left: 365px; top: 550px; width: 60px; height: 129px" />
		<img id="imgSteeringWheel" class="auto-scale" src="../Images/p2/p24.png"
			style="position: absolute; z-index: 1; left: 80px; top: 675px; width: 156px; height: 156px" />
		<div class="auto-scale" onclick="stopToPark()"
			style="cursor: pointer; position: absolute; z-index: 1; left: 398px; top: 758px; width: 136px; height: 66px">
		</div>
		<img id="imgTooltip" class="auto-scale" src="../Images/p2/p27.png" style="position: absolute; z-index: 1; left: 110px; top: 755px; width: 285px; height: 77px" />
		<img id="imgReady" class="auto-scale" src="../Images/p2/p2224.png" style="display: none; position: absolute; z-index: 1; left: 220px; top: 250px; width: 183px; height: 47px" />
		<img id="imgGo" class="auto-scale" src="../Images/p2/p2225.png" style="display: none; position: absolute; z-index: 1; left: 220px; top: 250px; width: 183px; height: 47px" />

		<div class="auto-scale"
			style="cursor: pointer; position: absolute; z-index: 1; left: 260px; top: 220px; width: 142px; height: 22px">
			<span id="span-timer" style="font-weight: bold; font-style: italic; font-size: 18px; line-height: 20px">
				用时：00:00:00
			</span>
		</div>

		<img id="imgEarly" class="auto-scale" src="../Images/p3/p37.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<img id="imgLate" class="auto-scale" src="../Images/p3/p36.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<img id="imgProper" class="auto-scale" src="../Images/p3/p38.jpg" style="display: none; position: absolute; z-index: 10; left: 0; top: 0; width: 640px; height: 1008px" />
		<a id="linkChangePage" class="auto-scale" style="position: absolute; z-index: 11; left: 117px; top: 498px; width: 128px; height: 55px">
		</a>
        <a id="linkChangePage1" class="auto-scale" style="position: absolute; z-index: 11; left: 395px; top: 498px; width: 128px; height: 55px">
		</a>
		<a id="linkChangePage2" class="auto-scale" style="position: absolute; z-index: 11; left: 255px; top: 498px; width: 128px; height: 55px">
		</a>
		<span id="spanTimeUsed" class="auto-scale"
			style="display: none; position: absolute; z-index: 11; left: 310px; top: 310px; width: 180px; height: 50px; font-weight: bold; font-size: 50px; line-height: 50px; color: #000; text-shadow: 5px 5px 5px #fff5b3">
			0.00s
		</span>
		<span id="spanPercent" class="auto-scale"
			style="display: none; position: absolute; z-index: 11; left: 362px; top: 365px; width: 40px; height: 36px; font-weight: bold; font-size: 36px; line-height: 36px; color: #000; text-shadow: 5px 5px 5px #fff5b3; text-align: right">
			19
		</span>
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
			$("#spanTimeUsed").css({
				"font-size": 50 * _ratio + "px",
				"line-height": 50 * _ratio + "px"
			});
			$("#spanPercent").css({
				"font-size": 40 * _ratio + "px",
				"line-height": 40 * _ratio + "px"
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

		// 向下移动汽车
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
			var top = 550 - _timeSpan * 150;
			if (top < 240) {
				stopToPark();
				return;
			}

			car.css("top", top * _ratio + "px");
			requestId = window.requestAnimationFrame(animate);
		}

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
			var minTop = 260 * _ratio;
			var maxTop = 280 * _ratio;
			var top = parseFloat($("#imgCar").css("top"));
			if (top > maxTop) {
				// 早了
				$("#imgEarly").show();
				$("#linkChangePage").attr("href", "Play.aspx");
				$("#linkChangePage1").attr("href", "../Appointments/Create.aspx");
			}
			else if (top < minTop) {
				// 晚了
				$("#imgLate").show();
				$("#linkChangePage").attr("href", "Play.aspx");
				$("#linkChangePage1").attr("href", "../Appointments/Create.aspx");
			}
			else {
				// 合适 - 时间直接加2秒
				_timeSpan += 2;
				showTimer();

				intoPark();
			}
		}

		// 倒车动画
		function intoPark() {
			var world = anima.world();

			// 旋转方向盘
			var steeringWheel = world.add(document.querySelector("#imgSteeringWheel"));
			steeringWheel.animate({
				rotate: [0, 0, 30],
				duration: 1000
			}).animate({
				rotate: [0, 0, -60],
				duration: 1000
			}).animate({
				rotate: [0, 0, 30],
				duration: 1000
			});

			// 倒车
			var car = world.add(document.querySelector("#imgCar"));
			car.animate([{
				translate: [10 * _ratio, 25 * _ratio, 0],
				duration: 500,
				ease: "linear"
			}, {
				rotate: [0, 0, -10],
				duration: 500,
				ease: "linear"
			}])
			.animate([{
				translate: [10 * _ratio, 25 * _ratio, 0],
				duration: 500,
				ease: "linear"
			}, {
				rotate: [0, 0, -10],
				duration: 500,
				ease: "linear"
			}])
			.animate([{
				translate: [40 * _ratio, 40 * _ratio, 0],
				duration: 1000,
				ease: "linear"
			}, {
				rotate: [0, 0, -20],
				duration: 1000,
				ease: "linear"
			}])
			.animate([{
				translate: [40 * _ratio, 50 * _ratio, 0],
				duration: 1000,
				ease: "linear"
			}, {
				rotate: [0, 0, 40],
				duration: 1000,
				ease: "linear"
			}])
			.on("end", function () {
				// 动画完成后进行页面跳转
				var url = "../Common/BusinessHandler.ashx?action=saveAndShowScore&r=" + Math.random();
				$.post(url, function (data) {
					$("#imgProper").show();

					$("#spanTimeUsed").show();
					$("#spanTimeUsed").text(data.timeUsed + "s");
					$("#spanPercent").show();
					$("#spanPercent").text(data.percent);

					// 显示已使用的时间
					showTimer();
				});

				$("#linkChangePage2").attr("href", "Proper.aspx");
			});
		}
	</script>
</asp:Content>
