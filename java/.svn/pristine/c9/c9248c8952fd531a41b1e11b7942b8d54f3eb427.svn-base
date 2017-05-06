var channel = getUrlParam("intfCallChannel");
var isPhone = channel && channel.toLowerCase() == "ios";
var isAndroid = channel && channel.toLowerCase() == "android";
var isJS = !isPhone && !isAndroid;
function getCorPath() {
	if (isPhone)
		return "<script type='text/javascript' src='http://" + document.domain
				+ "/static-resource/js/platform-ios/cordova.js'></script>";
	if (isAndroid)
		return "<script type='text/javascript' src='http://" + document.domain
				+ "/static-resource/js/platform-android/cordova.js'></script>";
	return "<script type='text/javascript' src='http://res.wx.qq.com/open/js/jweixin-1.0.0.js'></script>";
}
document.write(getCorPath());
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
function backTo() {
	if (isJS)
		history.back();
	else
		cordova.exec(corSuccess, corFail, "Operation", "backPressed", []);
}
function corSuccess(message) {
	alert("success = " + message);
};
function corFail(message) {
	alert("fail = " + message);
};