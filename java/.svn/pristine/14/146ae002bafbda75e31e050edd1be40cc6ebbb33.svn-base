/**
 * 文件名称：CharsetUtils.java
 * 
 * 描述：字符集转换工具类
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.UnsupportedEncodingException;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：字符集转换工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class CharsetUtils {

	private CharsetUtils() {
	}

	/**
	 * 将字符编码转换成ISO-8859-1码
	 * 
	 * @param str
	 *            待转换的字符串
	 * @return ISO-8859-1码
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String toISO88591(String str) throws UnsupportedEncodingException {
		return changeCharset(str, CommonConstants.ISO_8859_1);
	}

	/**
	 * 字符编码转换成UTF-8码
	 * 
	 * @param str
	 *            待转换的字符串
	 * @return UTF-8码
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String toUTF8(String str) throws UnsupportedEncodingException {
		return changeCharset(str, CommonConstants.UTF_8);
	}

	/**
	 * 将字符编码转换成UTF-16码
	 * 
	 * @param str
	 *            待转换的字符串
	 * @return UTF-16码
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String toUTF16(String str) throws UnsupportedEncodingException {
		return changeCharset(str, CommonConstants.UTF_16);
	}

	/**
	 * 将字符编码转换成GBK码
	 * 
	 * @param str
	 *            待转换的字符串
	 * @return GBK码
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String toGBK(String str) throws UnsupportedEncodingException {
		return changeCharset(str, CommonConstants.GBK);
	}

	/**
	 * 字符串编码转换的实现方法
	 * 
	 * @param str
	 *            待转换编码的字符串
	 * @param newCharset
	 *            目标编码
	 * @return 转码后的字符串
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String changeCharset(String str, String newCharset) throws UnsupportedEncodingException {
		if (str != null) {
			// 用默认字符编码解码字符串。
			byte[] bs = str.getBytes();
			// 用新的字符编码生成字符串
			return new String(bs, newCharset);
		}
		return null;
	}

	/**
	 * 字符串编码转换的实现方法
	 * 
	 * @param str
	 *            待转换编码的字符串
	 * @param oldCharset
	 *            原编码
	 * @param newCharset
	 *            目标编码
	 * @return 转码后的字符串
	 * @throws UnsupportedEncodingException
	 *             不支持的编码异常
	 */
	public static String changeCharset(String str, String oldCharset, String newCharset) throws UnsupportedEncodingException {
		if (str != null) {
			// 用旧的字符编码解码字符串。解码可能会出现异常。
			byte[] bs = str.getBytes(oldCharset);
			// 用新的字符编码生成字符串
			return new String(bs, newCharset);
		}
		return null;
	}

}
