$(function() {
	if (!isLogin()) {
		if (getSessionStorage(sessionStorageWXCodeKey) && isUserUnbinding())
			window.location.replace("/user/bindTeleNumber.html");
		else {
			var urlLoc = "http://m.yldbkd.com/wx-code.html?appid=wx2a7706db5d469293&redirect_uri="
					+ "http://"
					+ document.domain
					+ "/user/inLogining.html"
					+ "&response_type=code&scope=snsapi_userinfo&state=wx#wechat_redirect"
			window.location.replace(urlLoc);
		}
	}
})