var UA = navigator.userAgent.toLowerCase();
var isPhone = RegExp("iphone").test(UA);
var isAndroid = RegExp("android").test(UA) || RegExp("linux").test(UA);
function getCorPath() {
	if (isPhone)
		return "/platform-ios";
	if (isAndroid)
		return "/platform-android";
}
alert("获取到的自带参数intfCallChannel的值为：" + getUrlParam("intfCallChannel"));
document.write("<script type='text/javascript' src='static-resource/js"
		+ getCorPath() + "/cordova.js'></script>");
// 获取url参数
function getUrlParam(sName) {
	var sValue = '';
	var re = new RegExp("\\b" + sName + "\\b=([^&=]+)");
	var st = null;
	st = window.location.search.match(re);
	if (st && st.length == 2) {
		st[1] = st[1].replace(/^\s*|\s*$/g, '');
		sValue = st[1];
	}
	return sValue;
}