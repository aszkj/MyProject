package com.yilidi.o2o.core.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

/**
 * 功能描述：正则表达式工具 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class RegexUtils {

	private RegexUtils() {
	}

	/**
	 * redis配置参数
	 */
	private static Map<String, String> configParams = new HashMap<String, String>();

	static {
		configParams = PropertiesUtils.get("regex.properties");
	}

	/**
	 * 
	 * 匹配字符串
	 * 
	 * @param regex
	 *            正则表达式
	 * @param beTestString
	 *            字符串
	 * @return boolean
	 */
	public static boolean match(String regex, String beTestString) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(beTestString);
		return matcher.matches();
	}

	/**
	 * 检查是否为手机号码
	 * 
	 * @param beTestString
	 *            手机号码
	 * @return boolean 是否为有效手机号码
	 */
	public static boolean isMobileNumble(String beTestString) {
		if (StringUtils.isBlank(beTestString)) {
			return false;
		}
		String regx = configParams.get("mobile_regex");
		return match(regx, beTestString);
	}

	/**
	 * 检查是否为固话
	 * 
	 * @param str
	 *            电话号码
	 * @return 是否为固话
	 */
	public static boolean isTelNumber(String str) {
		if (StringUtils.isBlank(str)) {
			return false;
		}
		String regex = configParams.get("tel_regex");
		return match(regex, str);
	}

	/**
	 * 判断是否为有效的email地址
	 * 
	 * @param str
	 *            待验证的Email字符串
	 * @return 是否为有效email
	 */
	public static boolean isEmail(String str) {
		if (StringUtils.isBlank(str)) {
			return false;
		}
		String regex = configParams.get("email_regex");
		return match(regex, str);
	}

	/**
	 * 判断是否为有效的URL地址
	 * 
	 * @param str
	 *            待验证的URL字符串
	 * @return 是否为有效URL
	 */
	public static boolean isUrl(String str) {
		if (StringUtils.isBlank(str)) {
			return false;
		}
		String regex = configParams.get("url_regex");
		return match(regex, str);
	}

}
