/**
 * 文件名称：CharsetUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.UnsupportedEncodingException;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 */
public class CharsetUtilTest {

	private static Logger logger = Logger.getLogger(CharsetUtils.class);

	@Test
	public void testCharset() throws UnsupportedEncodingException {

		String str = "This is a 中文的 String!";
		logger.info("str: " + str);

		String gbk = CharsetUtils.toGBK(str);
		logger.info("转换成GBK码: " + gbk);

		String iso88591 = CharsetUtils.toISO88591(str);
		logger.info("转换成ISO-8859-1码: " + iso88591);

		gbk = CharsetUtils.changeCharset(iso88591, CommonConstants.ISO_8859_1, CommonConstants.GBK);
		logger.info("再把ISO-8859-1码的字符串转换成GBK码: " + gbk);

		String utf8 = CharsetUtils.toUTF8(str);
		logger.info("转换成UTF-8码: " + utf8);

		gbk = CharsetUtils.changeCharset(utf8, CommonConstants.UTF_8, CommonConstants.GBK);
		logger.info("再把UTF-8码的字符串转换成GBK码: " + gbk);

		String utf16 = CharsetUtils.toUTF16(str);
		logger.info("转换成UTF-16码:" + utf16);

		String s = new String("中文".getBytes(CommonConstants.UTF_8), CommonConstants.UTF_8);
		logger.info(s);
	}
}
