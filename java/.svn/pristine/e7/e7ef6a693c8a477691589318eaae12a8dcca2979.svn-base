package com.yilidi.o2o.core.connect.wechat.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

import org.apache.log4j.Logger;

/**
 * 签名工具类
 * 
 * @author simpson
 * 
 */
public final class WXSDKSignature {
	// 打log用
	private static Logger logger = Logger.getLogger(WXSDKSignature.class);

	private WXSDKSignature() {
	}

	/**
	 * 签名算法
	 * 
	 * @param o
	 *            要参与签名的数据对象
	 * @return 签名
	 * @throws IllegalAccessException
	 *             异常
	 */
	public static String getSign(Object o) throws IllegalAccessException {
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
		result = result.substring(0, result.length() - 1);
		logger.info("======>签名生成之前的内容信息：" + result);
		result = SHA1.sha1Encode(result).toUpperCase();
		return result;
	}

	/**
	 * 签名算法
	 * 
	 * @param map
	 *            要参与签名的数据map
	 * @return 签名
	 */
	public static String getSign(Map<String, Object> map) {
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
		result = result.substring(0, result.length() - 1);
		logger.info("======>签名生成之前的内容信息：" + result);
		result = SHA1.sha1Encode(result).toUpperCase();
		return result;
	}
}
