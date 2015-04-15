$(document).on("pageinit", function () {
	weixinInit();

	adjustScale();

	// 禁止滑动屏幕
	document.addEventListener("touchmove", function(event) {
		event.preventDefault();
	});
	// 覆盖默认的window.alert方法
	window.alert = function (message) {
		jAlert(message, "提示");
	};
});

// 缩放比例
var _ratio = 1.0;

function adjustScale() {
	var width = $(document.body).width();
	_ratio = parseFloat(width / 640);

	$(".auto-scale").each(function () {
		var left = parseFloat($(this).css("left"));
		var top = parseFloat($(this).css("top"));
		var width = parseFloat($(this).css("width"));
		var height = parseFloat($(this).css("height"));
		//console.log(left + " - " + top + " - " + width + " - " + height);

		if (left > 0) {
			$(this).css("left", left * _ratio);
		}
		if (top > 0) {
			$(this).css("top", top * _ratio);
		}
		if (width > 0) {
			$(this).css("width", width * _ratio);
		}
		if (height > 0) {
			$(this).css("height", height * _ratio);
		}
	});
}

// 动态引入样式表文件
function importCssFile(path) {
	var element = document.createElement("link");
	element.rel = "stylesheet";
	element.type = "text/css";
	element.media = "screen";
	element.href = path;
	var head = document.getElementsByTagName("head")[0];
	head.appendChild(element);
}

function weixinInit() {
	window.shareData = {
		"imgUrl": "http://weixin.unisw.com/sonata4/images/app/app.jpg",
		"timeLineLink": "http://weixin.unisw.com/sonata4/",
		"tTitle": "纵横泊车，等你来战",
		"tContent": "纵横泊车，等你来战"
	};

	function onShareComplete() {
	}

	document.addEventListener("WeixinJSBridgeReady", function onBridgeReady() {
		WeixinJSBridge.call("hideToolbar");
		WeixinJSBridge.on("menu:share:appmessage", function (argv) {
			WeixinJSBridge.invoke("sendAppMessage", {
				"img_url": window.shareData.imgUrl,
				"link": window.shareData.timeLineLink,
				"desc": window.shareData.tContent,
				"title": window.shareData.tTitle
			}, onShareComplete);
		});
		WeixinJSBridge.on("menu:share:timeline", function (argv) {
			WeixinJSBridge.invoke("shareTimeline", {
				"img_url": window.shareData.imgUrl,
				"img_width": "640",
				"img_height": "640",
				"link": window.shareData.timeLineLink,
				"desc": window.shareData.tContent,
				"title": window.shareData.tContent
			}, onShareComplete);
		});
	}, false);
}
