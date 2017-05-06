package com.yilidi.o2o.core.payment.tencent.common;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import com.yilidi.o2o.core.utils.StringUtils;

import javax.xml.parsers.ParserConfigurationException;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * 签名工具类
 * 
 * @author simpson
 * 
 */
public final class Signature {
	// 打log用
	private static Logger logger = Logger.getLogger(Signature.class);

	private Signature() {
	}

	/**
	 * 签名算法
	 * 
	 * @param o
	 *            要参与签名的数据对象
	 * @param isJs
	 *            是否是JS-即微信公众号平台支付方式进行微信支付
	 * @return 签名
	 * @throws IllegalAccessException
	 *             异常
	 */
	public static String getSign(Object o, boolean isJs) throws IllegalAccessException {
		ArrayList<String> list = new ArrayList<String>();
		Class<? extends Object> cls = o.getClass();
		Field[] fields = cls.getDeclaredFields();
		for (Field f : fields) {
			f.setAccessible(true);
			if (f.get(o) != null && !"".equals(f.get(o))) {
				list.add(f.getName() + "=" + f.get(o) + "&");
			}
		}
		int size = list.size();
		String[] arrayToSort = list.toArray(new String[size]);
		Arrays.sort(arrayToSort, String.CASE_INSENSITIVE_ORDER);
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < size; i++) {
			sb.append(arrayToSort[i]);
		}
		String result = sb.toString();
		result += "key=" + Configure.getKey(isJs);
		logger.info("======>签名生成之前的内容信息：" + result);
		result = MD5.encodeMD5(result).toUpperCase();
		return result;
	}

	/**
	 * 签名算法
	 * 
	 * @param map
	 *            要参与签名的数据map
	 * @param isJs
	 *            是否是JS-即微信公众号平台支付方式进行微信支付
	 * @return 签名
	 */
	public static String getSign(Map<String, Object> map, boolean isJs) {
		ArrayList<String> list = new ArrayList<String>();
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			if (!"".equals(entry.getValue())) {
				list.add(entry.getKey() + "=" + entry.getValue() + "&");
			}
		}
		int size = list.size();
		String[] arrayToSort = list.toArray(new String[size]);
		Arrays.sort(arrayToSort, String.CASE_INSENSITIVE_ORDER);
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < size; i++) {
			sb.append(arrayToSort[i]);
		}
		String result = sb.toString();
		result += "key=" + Configure.getKey(isJs);
		logger.info("======>签名生成之前的内容信息：" + result);
		result = MD5.encodeMD5(result).toUpperCase();
		return result;
	}

	/**
	 * 从API返回的XML数据里面重新计算一次签名
	 * 
	 * @param responseString
	 *            API返回的XML数据
	 * @param isJs
	 *            是否是JS-即微信公众号平台支付方式进行微信支付
	 * @return 新鲜出炉的签名
	 * @throws ParserConfigurationException
	 *             解析配置异常
	 * @throws IOException
	 *             io异常
	 * @throws SAXException
	 *             sax异常
	 */
	public static String getSignFromResponseString(String responseString, boolean isJs) throws IOException, SAXException,
			ParserConfigurationException {
		Map<String, Object> map = XMLParser.getMapFromXML(responseString);
		// 清掉返回数据对象里面的Sign数据（不能把这个数据也加进去进行签名），然后用签名算法进行签名
		map.put("sign", "");
		// 将API返回的数据根据用签名算法进行计算新的签名，用来跟API返回的签名进行比较
		return Signature.getSign(map, isJs);
	}

	/**
	 * 检验API返回的数据里面的签名是否合法，避免数据在传输的过程中被第三方篡改
	 * 
	 * @param responseString
	 *            API返回的XML数据字符串
	 * @param isJs
	 *            是否是JS-即微信公众号平台支付方式进行微信支付
	 * @return API签名是否合法
	 * @throws ParserConfigurationException
	 *             解析配置异常
	 * @throws IOException
	 *             io异常
	 * @throws SAXException
	 *             sax异常
	 */
	public static boolean checkIsSignValidFromResponseString(String responseString, boolean isJs)
			throws ParserConfigurationException, IOException, SAXException {

		Map<String, Object> map = XMLParser.getMapFromXML(responseString);
		Util.log(map.toString());

		String signFromAPIResponse = map.get("sign").toString();
		if (StringUtils.isEmpty(signFromAPIResponse)) {
			Util.log("API返回的数据签名数据不存在，有可能被第三方篡改!!!");
			return false;
		}
		Util.log("服务器回包里面的签名是:" + signFromAPIResponse);
		// 清掉返回数据对象里面的Sign数据（不能把这个数据也加进去进行签名），然后用签名算法进行签名
		map.put("sign", "");
		// 将API返回的数据根据用签名算法进行计算新的签名，用来跟API返回的签名进行比较
		String signForAPIResponse = Signature.getSign(map, isJs);

		if (!signForAPIResponse.equals(signFromAPIResponse)) {
			// 签名验不过，表示这个API返回的数据有可能已经被篡改了
			Util.log("API返回的数据签名验证不通过，有可能被第三方篡改!!!");
			return false;
		}
		Util.log("恭喜，API返回的数据签名验证通过!!!");
		return true;
	}

	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", "wx2a7706db5d469293");
		map.put("mch_id", "1332307101");
		map.put("device_info", "WEB");
		map.put("nonce_str", "folrfeprno0rwj2vgoeux9xzhcvd3lhs");
		map.put("body", "微信支付，订单编号：T1611291733038903KVK，订单金额：120.00元");
		map.put("out_trade_no", "A161129173304176SMFT");
		map.put("total_fee", "12000");
		map.put("spbill_create_ip", "183.14.152.3");
		map.put("trade_type", "JSAPI");
		map.put("openid", "oqJFDwsESLKKrlbVe_klxGZOLKrE");
		map.put("notify_url", "http://buyertest.yldbkd.com/interfaces/buyer/pay/wxpayappnotify");
		System.out.println(getSign(map, true));
		// String sign = "37FDFAE22E373E7FCA6FDAC79A5D009F";

		String s1 = "appid=wx2a7706db5d469293&body=微信支付，订单编号：T161130104116853L35A，订单金额：120.00元&detail=饮品核桃露-条形码 1件&device_info=WEB&fee_type=CNY&mch_id=1332307101&nonce_str=4pfhisa6stemx3f6semuc4act1z4mhjk&notify_url=http://buyertest.yldbkd.com/interfaces/buyer/pay/wxpayappnotify&openid=oqJFDwsESLKKrlbVe_klxGZOLKrE&out_trade_no=A161130104117795WKLC&spbill_create_ip=183.14.156.247&total_fee=12000&trade_type=JSAPI&key=f3b6d3578d7fc86f583da3484444812f";
		String s2 = "appid=wx2a7706db5d469293&body=微信支付，订单编号：T161130104116853L35A，订单金额：120.00元&detail=饮品核桃露-条形码 1件&device_info=WEB&fee_type=CNY&mch_id=1332307101&nonce_str=4pfhisa6stemx3f6semuc4act1z4mhjk&notify_url=http://buyertest.yldbkd.com/interfaces/buyer/pay/wxpayappnotify&openid=oqJFDwsESLKKrlbVe_klxGZOLKrE&out_trade_no=A161130104117795WKLC&spbill_create_ip=183.14.156.247&total_fee=12000&trade_type=JSAPI&key=f3b6d3578d7fc86f583da3484444812f";
		System.out.println(s1.equals(s2));
	}
}
