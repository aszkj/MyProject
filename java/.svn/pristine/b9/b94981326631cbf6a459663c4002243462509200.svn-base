//加入其他JS文件引用
var TERMINAL_URL = '/mobile';
document
		.write("<script type='text/javascript' src='/static-resource/js/base64.js'></script>");
document
		.write("<script type='text/javascript' src='/static-resource/js/jquery-2.1.3.min.js'></script>");
document
		.write("<script type='text/javascript' src='/static-resource/js/json2.js'></script>");
document
		.write("<script type='text/javascript' src='/static-resource/js/resize.js'></script>");
document
		.write("<script type='text/javascript' src='/static-resource/js/jquery.tmpl.js'></script>");

function setErrorDefaultImg(e) {
	$(e).attr(
			"src",
			"http://" + document.domain
					+ "/static-resource/images/noImageDetails.png");
}
function setErrorLongDefaultImg(e) {
	$(e).attr("src",
			"http://" + document.domain + "/static-resource/images/121.png");
}

function ajax(url, params, func) {
	ajax(url, params, func, function(msg) {
		alert(msg);
	});
}

function ajax(url, params, successFunc, failureFunc) {
	ajax(url, params, successFunc, failureFunc, false);
}

function ajax(url, params, successFunc, failureFunc, isLoading) {
	_JQAjax("post", url, params, successFunc, failureFunc, false, isLoading);
}

/**
 * 私有方法，统一调用ajax封装方法
 * 
 * @param method
 *            调用类型，GET或者POST
 * @param surl
 *            接口调用URL
 * @param sparams
 *            接口调用参数数组信息
 * @param successFunc
 *            接口成功以后回调方法，即成功后MsgCode=1
 * @param failureFunc
 *            接口失败以后回调方法，即接口调用失败或者成功后MsgCode=0
 * @param isCache
 *            是否使用缓存 *
 * @param isLoading
 *            是否使用Loading页面效果，统一使用pageloading为ID的页面内容
 */
function _JQAjax(method, surl, sparams, successFunc, failureFunc, isCache,
		isLoading) {
	var params = new Object();
	params.intfCallChannel = 3
	params.key = 123;
	params.deviceId = getUID();
	params.entity = sparams;
	var param = [];
	param.push('param='
			+ encodeURIComponent(new Base64().encode(JSON.stringify(params))));
	$(document).ready(function() {
		$.ajax({
			url : TERMINAL_URL + surl,
			type : method,
			data : param.join("&"),
			dataType : "json",
			cache : false,
			beforeSend : loading,
			success : suFunc,
			error : erFunc
		});
	});
	function loading() {
		if (isLoading)
			$("#pageloading").show();
	}
	function suFunc(data) {
		$("#pageloading").hide();
		var resultStr = new Base64().decode(data.result);
		var result = eval('(' + resultStr + ')');
		if (result.msgCode == 1) {
			successFunc(result.entity);
		} else if (result.msgCode == 2) {
			// 返回未登录或登录超时，是否需要统一处理后续修改
			clearUserInfo();
		} else {
			failureFunc(result.msg);
		}
	}
	function erFunc(xhr, status, error) {
		$("#pageloading").hide();
		if (xhr.status >= 400 && xhr.status < 500) {
			alert("网络异常，请检查网络或稍后重试");
		} else {
			alert("网络异常，请检查网络或稍后重试!");
		}
	}
}