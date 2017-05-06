package com.yilidi.o2o.core.payment.tencent.common;

/**
 * 这里放置各种配置数据
 * 
 * @author simpson
 * 
 */
public final class Configure {

	// 这个就是自己要保管好的私有Key了（切记只能放在自己的后台代码里，不能放在任何可能被看到源代码的客户端程序中）
	// 每次自己Post数据给API的时候都要用这个key来对所有字段进行签名，生成的签名会放在Sign这个字段，API收到Post数据的时候也会用同样的签名算法对Post过来的数据进行签名和验证
	// 收到API的返回的时候也要用这个key来对返回的数据算下签名，跟API的Sign数据进行比较，如果值不一致，有可能数据被第三方给篡改
	private static final String KEY = "84f6e5434034547a3e9b971e5209d43b";//
	private static final String PUBLISH_KEY = "f3b6d3578d7fc86f583da3484444812f";

	// 微信分配的APP端的APPID（开通公众号之后可以获取到）
	private static final String APP_ID = "wxadf10b780467d1f7"; //
	private static final String PUBLISH_APP_ID = "wx2a7706db5d469293";

	// 微信支付分配的商户号ID（开通公众号的微信支付功能之后可以获取到）
	private static final String MCH_ID = "1346581701"; //
	private static final String PUBLISH_MCH_ID = "1332307101";

	// 受理模式下给子商户分配的子商户号
	private static final String SUB_MCH_ID = "";

	// HTTPS证书的本地路径
	private static final String CERT_LOCAL_PATH = Configure.class.getResource("/").getPath()
			+ "/cert/tencent/apiclient_cert.p12";
	private static final String PUBLISH_CERT_LOCAL_PATH = Configure.class.getResource("/").getPath()
			+ "/cert/tencent/apiclient_cert.p12"; //TODO

	// HTTPS证书密码，默认密码等于商户号MCHID
	private static final String CERT_PASSWORD = MCH_ID;
	private static final String PUBLISH_CERT_PASSWORD = PUBLISH_MCH_ID;

	// 是否使用异步线程的方式来上报API测速，默认为异步模式
	private static final boolean USE_THREAD_TO_DO_REPORT = true;

	/** 调用方式JSAPI的方式 */
	public static final String JS_TRADE_TYPE = "JSAPI";
	/**
	 * 返回结果通知URL：/interfaces/buyer/pay/wxpayappnotify
	 */
	public static final String NOTIFY_URL = "/interfaces/buyer/pay/wxpayappnotify";

	// 机器IP
	private static String ip = "";

	// 以下是几个API的路径：
	/**
	 * 1）统一下单API
	 */
	public static final String UNIFIED_ORDER_API = "https://api.mch.weixin.qq.com/pay/unifiedorder";

	/**
	 * 2）查询订单API
	 */
	public static final String ORDER_QUERY_API = "https://api.mch.weixin.qq.com/pay/orderquery";

	/**
	 * 3）关闭订单API
	 */
	public static final String CLOSE_ORDER_API = "https://api.mch.weixin.qq.com/pay/closeorder";

	/**
	 * 4）申请退款API
	 */
	public static final String REFUND_API = "https://api.mch.weixin.qq.com/secapi/pay/refund";

	/**
	 * 5）查询退款API
	 */
	public static final String REFUND_QUERY_API = "https://api.mch.weixin.qq.com/pay/refundquery";

	/**
	 * 6）下载对账单API
	 */
	public static final String DOWNLOAD_BILL_API = "https://api.mch.weixin.qq.com/pay/downloadbill";

	/**
	 * 7) 统计上报API
	 */
	public static final String REPORT_API = "https://api.mch.weixin.qq.com/payitil/report";

	/**
	 * 8) 提交刷卡支付API
	 */
	public static final String MICROPAY_API = "https://api.mch.weixin.qq.com/pay/micropay";

	/**
	 * 9) 撤销订单API
	 */
	public static final String REVERSE_API = "https://api.mch.weixin.qq.com/secapi/pay/reverse";

	/**
	 * https请求类名称
	 */
	public static final String HTTPS_REQUEST_CLASS_NAME = "com.yilidi.o2o.core.payment.tencent.common.HttpsRequest";

	private Configure() {
	}

	public static String getKey(boolean isJS) {
		return isJS ? PUBLISH_KEY : KEY;
	}

	public static String getAppid(boolean isJS) {
		return isJS ? PUBLISH_APP_ID : APP_ID;
	}

	public static String getMchid(boolean isJS) {
		return isJS ? PUBLISH_MCH_ID : MCH_ID;
	}

	public static String getSubMchid() {
		return SUB_MCH_ID;
	}

	public static String getCertLocalPath(boolean isJS) {
		return isJS ? PUBLISH_CERT_LOCAL_PATH : CERT_LOCAL_PATH;
	}

	public static String getCertPassword(boolean isJS) {
		return isJS ? PUBLISH_CERT_PASSWORD : CERT_PASSWORD;
	}

	public static boolean isUseThreadToDoReport() {
		return USE_THREAD_TO_DO_REPORT;
	}

	public static String getIP() {
		return ip;
	}

	public static void setIp(String ip) {
		Configure.ip = ip;
	}

}
