var UA = navigator.userAgent.toLowerCase();
var isPhone = RegExp("iphone").test(UA);
var isAndroid = RegExp("android").test(UA) || RegExp("linux").test(UA);
function getCorPath() {
	if (isPhone)
		return "/platform-ios";
	if (isAndroid)
		return "/platform-android";
}
document.write("<script type='text/javascript' src='static-resource/js"
		+ getCorPath() + "/cordova.js'></script>");