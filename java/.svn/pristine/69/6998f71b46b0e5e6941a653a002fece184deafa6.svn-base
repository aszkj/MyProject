/**
 * 文件名称：StringUtils.java
 * 
 * 描述：字符串处理工具类
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;

/**
 * 功能描述：字符串处理工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@SuppressWarnings("rawtypes")
public final class StringUtils extends org.apache.commons.lang3.StringUtils {

    private static Logger logger = Logger.getLogger(StringUtils.class);

    /**
     * 默认常量定义
     */
    /**
     * 默认Byte常量：0
     */
    private static final Byte DEFAULTVALUE_BYTE = 0;
    /**
     * 默认Short常量：0
     */
    private static final Short DEFAULTVALUE_SHORT = 0;
    /**
     * 默认Integer常量：0
     */
    private static final Integer DEFAULTVALUE_INTEGER = 0;
    /**
     * 默认Long常量：0L
     */
    private static final Long DEFAULTVALUE_LONG = 0L;
    /**
     * 默认Float常量：0f
     */
    private static final Float DEFAULTVALUE_FLOAT = 0f;
    /**
     * 默认Double常量：0d
     */
    private static final Double DEFAULTVALUE_DOUBLE = 0d;
    /**
     * 默认Boolean常量：false
     */
    private static final Boolean DEFAULTVALUE_BOOLEAN = false;
    /**
     * 逗号字符串：,
     */
    private static final String COMMA_STRING = ",";
    /**
     * 分号字符串：;
     */
    private static final String SEMICOLON_STRING = ";";
    /**
     * 等号字符串：=
     */
    private static final String EQUAL_SIGN_STRING = "=";
    /**
     * 空格字符串
     */
    private static final String BACKSPACE_STRING = " ";
    /**
     * 时分秒开始字符串
     */
    public static final String STARTTIMESTRING = BACKSPACE_STRING + "00:00:00";
    /**
     * 时分秒结束字符串
     */
    public static final String ENDTIMESTRING = BACKSPACE_STRING + "23:59:59";
    /**
     * 已添加状态
     */
    public static final String ADDSTATUS_YES = "ADDSTATUS_YES";
    /**
     * 未添加状态
     */
    public static final String ADDSTATUS_NO = "ADDSTATUS_NO";

    /**
     * 金额在系统中都是以分为单位，需要乘以或除以100基数=元
     */
    public static final Long BASE_AMOUNT = 1000L;

    private static final String[] URL_REPLACEMENTS = new String[] { "%", "%25", "$", "%24", "&", "%26", "+", "%2B",
            COMMA_STRING, "%2C", "/", "%2F", ":", "%3A", SEMICOLON_STRING, "%3B", EQUAL_SIGN_STRING, "%3D", "?", "%3F", "@",
            "%40", BACKSPACE_STRING, "%20", "\"", "%22", "<", "%3C", ">", "%3E", "#", "%23", "{", "%7B", "}", "%7D", "|",
            "%7C", "\\", "%5C", "^", "%5E", "~", "%7E", "[", "%5B", "]", "%5D", "`", "%60" };

    private static final String UPPERALPHA_NUM = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    /**
     * 解析字符串为最小长度的数字类型。 如果value保存的是0~255之间的数则该方法回返回byte类型，如果是256则返回short类型 <br />
     * 使用方法： <br />
     * (1) parseNumber("1.25") 返回1.25 <br />
     * (2) parseNumber("1.25",999) 返回1.25 <br />
     * (3) arseNumber("a12b3",999) 转换异常，返回999
     * 
     * @param value
     *            待解析的字符串
     * @param defaultValue
     *            默认值
     * @return 解析后得到的数据
     */

    public static Number parseNumber(final String value, final Number... defaultValue) {
        try {
            if (value.indexOf(".") != -1) {
                try {
                    return Float.parseFloat(value);
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                    return Double.parseDouble(value);
                }
            } else {
                try {
                    return Byte.parseByte(value);
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                    try {
                        return Short.parseShort(value);
                    } catch (Exception e1) {
                        logger.error(e1.getMessage(), e1);
                        try {
                            return Integer.parseInt(value);
                        } catch (Exception e2) {
                            logger.error(e2.getMessage(), e2);
                            return Long.parseLong(value);
                        }
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (1 <= defaultValue.length) {
                return defaultValue[0];
            } else {
                return 0;
            }
        }
    }

    /**
     * 获取UUID字符串
     * 
     * @param isContainsDash
     *            是否包含-符号
     * @return isContainsDash为true，则返回包含破折号的UUID字符串，否则不包含
     */
    public static String getUUID(boolean isContainsDash) {
        if (isContainsDash) {
            return UUID.randomUUID().toString();
        } else {
            return UUID.randomUUID().toString().replaceAll("-", StringUtils.EMPTY);
        }

    }

    /**
     * 数据类型转换， 只支持如下数据类型： String，Integer，Byte，Character，Short，Long，Float，Double，Boolean。<br />
     * 使用方法：<br />
     * (1) changeType("28", Integer.class, 999) 成功返回28， 异常返回999 <br />
     * (2) changeType("abc",Integer.class,-1) 转换异常，则返回默认值-1
     * 
     * @param value
     *            待转换的字符串 <br />
     * @param param
     *            要转换的参数设置 , 如不指定则默认的为String.class <br />
     *            param[0] 要转换的类型[String.class, Integer.class 等] <br />
     *            param[1] 异常后的默认值，如果不提供，则为0 <br />
     * 
     * 
     * @return 转换后的对象
     */
    public static Object changeType(final String value, final Object... param) {
        if (null == value) {
            return null;
        }

        Class<?> type = String.class;
        Object defaultValue = null;
        if (param.length == 1) {
            type = (Class<?>) param[0];
        } else if (param.length == 2) {
            type = (Class<?>) param[0];
            defaultValue = param[1];
        }
        if (null == defaultValue) {
            defaultValue = "0";
        }

        if (Integer.class == type || int.class == type) {
            return StringUtils.parseInt(value, Integer.parseInt(defaultValue.toString()));
        } else if (String.class == type) {
            return value.toString();
        } else if (Byte.class == type || byte.class == type) {
            return StringUtils.parseByte(value, Byte.parseByte(defaultValue.toString()));
        } else if (Character.class == type || char.class == type) {
            return Character.valueOf(value.charAt(0));
        } else if (Short.class == type || short.class == type) {
            return StringUtils.parseShort(value, Short.parseShort(defaultValue.toString()));
        } else if (Long.class == type || long.class == type) {
            return StringUtils.parseLong(value, Long.parseLong(defaultValue.toString()));
        } else if (Float.class == type || float.class == type) {
            return StringUtils.parseFloat(value, Float.parseFloat(defaultValue.toString()));
        } else if (Double.class == type || double.class == type) {
            return StringUtils.parseDouble(value, Double.parseDouble(defaultValue.toString()));
        } else if (Boolean.class == type || boolean.class == type) {
            return StringUtils.parseBoolean(value, Boolean.parseBoolean(defaultValue.toString()));
        } else {
            return value;
        }

    }

    /**
     * 将字符类型数据转换成int类型数据。如果字符串格式非法其默认值为0。
     * 
     * @param value
     *            待转换的字符串
     * @param defaultValue
     *            转换异常时的默认值
     * @return 转换后的数据
     */
    public static Integer parseInt(final String value, final Integer... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_INTEGER;
                }
            } else {
                return Integer.parseInt(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_INTEGER;
            }
        }
    }

    /**
     * 将字符类型数据转换成float类型数据。如果字符串格式非法其默认值为0.0。
     * 
     * @param value
     *            待转换字符串
     * @param defaultValue
     *            转换异常时的默认值
     * @return 转换后的Float数据
     */
    public static Float parseFloat(final String value, final Float... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_FLOAT;
                }
            } else {
                return Float.parseFloat(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_FLOAT;
            }
        }
    }

    /**
     * 将字符类型数据转换成double类型数据。如果字符串格式非法其默认值为0.0。
     * 
     * @param value
     *            待转换的字符串
     * @param defaultValue
     *            转换异常后的默认值
     * @return 转换后的Double数据
     */
    public static Double parseDouble(final String value, final Double... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_DOUBLE;
                }
            } else {
                return Double.parseDouble(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_DOUBLE;
            }
        }
    }

    /**
     * 将字符类型数据转换成boolean类型数据。如果字符串格式非法其默认值为false <br />
     * 注意： 只有value值为 "true"时才返回true，否则都返回false
     * 
     * @param value
     *            待转换的字符串
     * @param defaultValue
     *            异常时的默认值
     * @return Boolean类型的数据
     */
    public static Boolean parseBoolean(final String value, final Boolean... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_BOOLEAN;
                }
            } else {
                return Boolean.parseBoolean(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_BOOLEAN;
            }
        }
    }

    /**
     * 将字符类型数据转换成long类型数据。如果字符串格式非法其默认值为0。
     * 
     * @param value
     *            待转换字符串
     * @param defaultValue
     *            异常时的默认值
     * @return 转换后的Long型数据
     */
    public static Long parseLong(final String value, final Long... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_LONG;
                }
            } else {
                return Long.parseLong(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_LONG;
            }
        }
    }

    /**
     * 将字符类型数据转换成byte类型数据。如果字符串格式非法其默认值为0。
     * 
     * @param value
     *            待转换的字符串
     * @param defaultValue
     *            异常时的默认值
     * @return 转换后的Byte数据
     */
    public static Byte parseByte(final String value, final Byte... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_BYTE;
                }
            } else {
                return Byte.parseByte(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_BYTE;
            }
        }
    }

    /**
     * 将字符类型数据转换成short类型数据。如果字符串格式非法其默认值为0。
     * 
     * @param value
     *            待转换的字符串
     * @param defaultValue
     *            异常时的默认值
     * @return 转换后的Short类型数据
     */
    public static Short parseShort(final String value, final Short... defaultValue) {
        try {
            if (ObjectUtils.isNullOrEmpty(value)) {
                if (defaultValue.length > 0) {
                    return defaultValue[0];
                } else {
                    return StringUtils.DEFAULTVALUE_SHORT;
                }
            } else {
                return Short.parseShort(value);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (defaultValue.length >= 1) {
                return defaultValue[0];
            } else {
                return StringUtils.DEFAULTVALUE_SHORT;
            }
        }
    }

    /**
     * 功能描述：将字符串转化为List集合类型。<br />
     * 在转化过程中可以指定分割符转换类型，当出现异常时，将采用默认值替代<br />
     * 
     * @param valueStr
     *            待转换的字符串
     * @param splitStr
     *            分割字符串的字符，默认为","
     * @param clz
     *            转换的目标类型， 默认为String.class
     * @return 转换后的list
     */
    @SuppressWarnings("unchecked")
    public static List parseList(final String valueStr, final String splitStr, Class clz) {
        String value = StringUtils.EMPTY;
        if (null != valueStr) {
            value = valueStr;
        }
        // 默认分割符。
        String split = COMMA_STRING;
        if (!StringUtils.isEmpty(splitStr)) {
            split = splitStr;
        }
        // 默认String类型
        Class<?> toType = String.class;
        if (!ObjectUtils.isNullOrEmpty(clz)) {
            toType = clz;
        }
        // 默认值是null。
        Object defaultValue = null;
        List list = null;
        list = new ArrayList<Object>(0);

        String[] tempSplit = value.split(split);
        for (String var : tempSplit) {
            list.add(StringUtils.changeType(var, toType, defaultValue));
        }
        return list;
    }

    /**
     * 将字符串转化为Map类型。在转化过程中可以指定分割符，转换类型，以及相应类型的默认转换值。 <br />
     * 说明：<br />
     * (1) 默认的key 与 value的分割符为 "=" <br />
     * (2) 默认的每个键值对分割符为 ";" <br />
     * (3) 默认的键类型为String <br />
     * (4) 默认的值类型为String，值为NULL <br />
     * 
     * @param valueStr
     *            待转换的字符串
     * @return 转换后的map对象
     */
    @SuppressWarnings("unchecked")
    public static Map parseMap(final String valueStr) {
        String value = StringUtils.EMPTY;
        if (null != valueStr) {
            value = valueStr;
        }
        // 默认分割符1。
        String splitKey = EQUAL_SIGN_STRING;
        // 默认分割符2。
        String splitVal = SEMICOLON_STRING;
        // key默认String类型
        Class<?> toTypeKey = String.class;
        // val默认String类型
        Class<?> toTypeVal = String.class;
        // 默认值是null。
        Object defaultValue = null;
        Map map = new HashMap<String, String>();

        String[] tempSplit = value.split(splitVal);
        for (String var : tempSplit) {
            String[] overSplit = var.split(splitKey);
            if (overSplit.length != 2) {
                continue;
            }
            Object ovKey = StringUtils.changeType(overSplit[0], toTypeKey);
            Object ovVar = StringUtils.changeType(overSplit[1], toTypeVal, defaultValue);
            map.put(ovKey.toString().trim(), ovVar);

        }
        return map;
    }

    /**
     * 获取指定字符串间的子串 <br />
     * 
     * <pre>
     * StringUtils.substringBetween("wx[b]yz", "[", "]") = "b"
     * StringUtils.substringBetween(null, *, *)          = null
     * StringUtils.substringBetween(*, null, *)          = null
     * StringUtils.substringBetween(*, *, null)          = null
     * StringUtils.substringBetween("", "", "")          = ""
     * StringUtils.substringBetween("", "", "]")         = null
     * StringUtils.substringBetween("", "[", "]")        = null
     * StringUtils.substringBetween("yabcz", "", "")     = ""
     * StringUtils.substringBetween("yabcz", "y", "z")   = "abc"
     * StringUtils.substringBetween("yabczyabcz", "y", "z")   = "abc"
     * </pre>
     * 
     * @param str
     *            the String containing the substring, may be null
     * @param open
     *            the String before the substring, may be null
     * @param close
     *            the String after the substring, may be null
     * @return the substring, <code>null</code> if no match
     */
    public static String subStringBetween(String str, String open, String close) {
        return StringUtils.substringBetween(str, open, close);
    }

    /**
     * 替换URL连接里面的特殊字符
     * 
     * @param str
     *            字符串
     * @return 返回的字符串
     */
    public static String urlEncode(String str) {
        String result = str;
        for (int n = 0; n < URL_REPLACEMENTS.length; n += 2) {
            result = result.replace(URL_REPLACEMENTS[n], URL_REPLACEMENTS[n + 1]);
        }
        return result;
    }

    /**
     * 功能描述: 使用给定的分隔符合并字符串数组成为新的字符串。
     * 
     * @param array
     *            要合并的字符串数组
     * @param separator
     *            分隔符
     * @return 由分隔符分隔字符串数组合并的新的字符串
     */
    public static String join(Object[] array, String separator) {

        if (ObjectUtils.isNullOrEmpty(array)) {
            return StringUtils.EMPTY;
        }
        StringBuffer buf = new StringBuffer();
        int length = array.length;
        for (int i = 0; i < length - 1; i++) {
            Object b = array[i];
            if (ObjectUtils.isNullOrEmpty(b)) {
                continue;
            }
            buf.append(b);
            buf.append(separator);
        }
        buf.append(array[length - 1]);
        return buf.toString();
    }

    /**
     * 功能描述：人民币转成大写
     * 
     * @param str
     *            数字字符串
     * @return String 人民币转换成大写后的字符串
     */
    public static String toRMB(String str) {
        double value;
        try {
            value = Double.parseDouble(str.trim());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return null;
        }
        char[] hunit = { '拾', '佰', '仟' }; // 段内位置表示
        char[] vunit = { '万', '亿' }; // 段名表示
        char[] digit = { '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' }; // 数字表示
        long midVal = (long) (value * 100); // 转化成整形
        String valStr = String.valueOf(midVal); // 转化成字符串
        String head = valStr.substring(0, valStr.length() - 2); // 取整数部分
        String rail = valStr.substring(valStr.length() - 2); // 取小数部分
        String prefix = StringUtils.EMPTY; // 整数部分转化的结果
        String suffix = StringUtils.EMPTY; // 小数部分转化的结果
        // 处理小数点后面的数
        if ("00".equals(rail)) { // 如果小数部分为0
            suffix = "整";
        } else {
            suffix = digit[rail.charAt(0) - '0'] + "角" + digit[rail.charAt(1) - '0'] + "分"; // 角分转化出来
        }
        // 处理小数点前面的数
        char[] chDig = head.toCharArray(); // 把整数部分转化成字符数组
        char zero = '0'; // 标志'0'表示出现过0
        byte zeroSerNum = 0; // 连续出现0的次数
        for (int i = 0; i < chDig.length; i++) { // 循环处理每个数字
            int idx = (chDig.length - i - 1) % 4; // 取段内位置
            int vidx = (chDig.length - i - 1) / 4; // 取段位置
            if (chDig[i] == '0') { // 如果当前字符是0
                zeroSerNum++; // 连续0次数递增
                if (zero == '0') { // 标志
                    zero = digit[0];
                } else if (idx == 0 && vidx > 0 && zeroSerNum < 4) {
                    prefix += vunit[vidx - 1];
                    zero = '0';
                }
                continue;
            }
            zeroSerNum = 0; // 连续0次数清零
            if (zero != '0') { // 如果标志不为0,则加上,例如万,亿
                prefix += zero;
                zero = '0';
            }
            prefix += digit[chDig[i] - '0']; // 转化该数字表示
            if (idx > 0) {
                prefix += hunit[idx - 1];
            }
            if (idx == 0 && vidx > 0) {
                prefix += vunit[vidx - 1]; // 段结束位置加上万,亿
            }
        }
        if (prefix.length() > 0) {
            prefix += '圆'; // 如果整数部分存在,则有圆
        }
        return prefix + suffix; // 返回正确表示
    }

    /**
     * 生成指定长度的随机数
     * 
     * @param length
     *            随机数的长度
     * @return 随机数
     */
    public static final String randomString(int length) {

        Random randGen = null;
        char[] numbersAndLetters = null;
        if (length < 1) {
            return null;
        }
        if (randGen == null) {
            randGen = new Random();
            // 由于数据当前使用的字符集默认为不区分大小写，为了不造成不必要的问题，全部随机为大写
            numbersAndLetters = UPPERALPHA_NUM.toCharArray();
        }
        char[] randBuffer = new char[length];
        for (int i = 0; i < randBuffer.length; i++) {
            randBuffer[i] = numbersAndLetters[randGen.nextInt(UPPERALPHA_NUM.length())];
        }
        return new String(randBuffer);
    }

    /**
     * 将字符串转换为字节数组，默认编码为UTF-8
     * 
     * @param str
     *            待转换的字符串
     * @return 字节数组
     */
    public static byte[] stringToByte(String str) {
        return stringToByte(str, CommonConstants.UTF_8);
    }

    /**
     * 根据编码，将自己字符串转换为字节数组
     * 
     * @param str
     *            待转换字符串
     * @param charEncode
     *            字符编码
     * @return 转换后字节数组
     */
    public static byte[] stringToByte(String str, String charEncode) {
        byte[] destObj = null;
        try {
            if (!StringUtils.isNotEmpty(str)) {
                destObj = new byte[0];
                return destObj;
            } else {
                destObj = str.getBytes(charEncode);
            }
        } catch (UnsupportedEncodingException e) {
            logger.info("字符串转换为带编码的字节数组异常: " + e);
        }
        return destObj;
    }

    /**
     * 将字节数组转换为字符串，默认编码为UTF-8
     * 
     * @param srcObj
     *            字节数组
     * @return 字符串
     */
    public static String byteToString(byte[] srcObj) {
        return byteToString(srcObj, CommonConstants.UTF_8);
    }

    /**
     * 根据编码将字节数组转换为字符串
     * 
     * @param srcObj
     *            字节数组
     * @param charEncode
     *            编码
     * @return 字符串
     */
    public static String byteToString(byte[] srcObj, String charEncode) {
        String destObj = null;
        try {
            destObj = new String(srcObj, charEncode);
        } catch (UnsupportedEncodingException e) {
            logger.info("字节数组转换为带编码的字符串异常: " + e);
        }
        return destObj.replaceAll("\0", BACKSPACE_STRING);
    }

    /**
     * 缩略字符串（不区分中英文字符）
     * 
     * @param str
     *            目标字符串
     * @param length
     *            截取长度
     * @return 截取后的字符串
     */
    public static String abbr(String str, int length) {
        if (str == null) {
            return StringUtils.EMPTY;
        }
        try {
            StringBuilder sb = new StringBuilder();
            int currentLength = 0;
            for (char c : replaceHtml(StringEscapeUtils.unescapeHtml4(str)).toCharArray()) {
                currentLength += String.valueOf(c).getBytes(CommonConstants.UTF_8).length;
                if (currentLength <= length - 3) {
                    sb.append(c);
                } else {
                    sb.append("...");
                    break;
                }
            }
            return sb.toString();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return StringUtils.EMPTY;
    }

    /**
     * 缩略字符串（替换html）
     * 
     * @param str
     *            目标字符串
     * @param length
     *            截取长度
     * @return 缩略后的字符串
     */
    public static String rabbr(String str, int length) {
        return abbr(replaceHtml(str), length);
    }

    /**
     * 替换掉HTML标签方法
     * 
     * @param html
     *            待替换的html
     * @return 替换后的html
     */
    public static String replaceHtml(String html) {
        if (isBlank(html)) {
            return StringUtils.EMPTY;
        }
        String regEx = "<.+?>";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(html);
        String s = m.replaceAll(StringUtils.EMPTY);
        return s;
    }

    /**
     * 生成评价单号字符串(长度为20，TyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateEvaluationOrderNo() {
        return generateSerialNo("E", "");
    }

    /**
     * 生成订单号字符串(长度为20，TyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateSaleOrderNo() {
        return generateSerialNo("T", "");
    }

    /**
     * 生成调货单号字符串(长度为20，FyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateFlittingOrderNo() {
        return generateSerialNo("F", "");
    }

    /**
     * 生成采购单号字符串(长度为20，PyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generatePurchaseOrderNo() {
        return generateSerialNo("P", "");
    }

    /**
     * 生成出库单号字符串(长度为20，SyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateStockOutOrderNo() {
        return generateSerialNo("S", "");
    }

    /**
     * 生成支付日志单号字符串(长度为20，AyyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generatePayLogOrderNo() {
        return generateSerialNo("A", "");
    }

    /**
     * 生成数据包产品导入批次号字符串(长度为20，ByyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generatePacketProductBatchNo() {
        return generateSerialNo("B", "");
    }

    /**
     * 生成发放优惠券批次号字符串(长度为20，ByyMMddHHmmssSSS+4位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateGrantCouponBatchNo() {
        return generateSerialNo("B", "");
    }

    /**
     * 生成品牌编码BrandCode(长度为20，yyyyMMddHHmmssSSS+3位随机数)
     * 
     * @return 20个字符的单号
     */
    public static String generateBrandCode() {
        return generateSerialNo("PB", "");
    }

    /**
     * 生成单号字符串(长度为20，yyMMddHHmmssSSS+4位随机数)
     * 
     * @param prefix
     *            前缀
     * @param postfix
     *            后缀
     * @return 20个字符的单号
     */
    public static String generateSerialNo(String prefix, String postfix) {
        StringBuffer sb = new StringBuffer();
        sb.append(prefix);
        sb.append(DateUtils.formatDate(new Date(), "yyMMddHHmmssSSS"));
        sb.append(StringUtils.randomString(4));
        sb.append(postfix);
        return sb.toString();
    }

    /**
     * 生成email地址
     * 
     * @return email地址
     */
    public static String generateEmail() {
        StringBuffer sb = new StringBuffer();
        sb.append(StringUtils.randomString(4));
        sb.append("@");
        sb.append(StringUtils.randomString(3));
        sb.append(".com");
        return sb.toString();
    }

    /**
     * 随机生成一段中文字符串
     * 
     * @param length
     *            需要生成的字符串长度
     * @return 中文字符串
     */
    public static String randomStringCN(int length) {
        if (0 >= length) {
            length = 6;
        }

        int start = 19968;
        int end = 40879;

        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            sb.append((char) RandomUtils.nextInt(start, end));
        }
        return sb.toString();
    }

    /**
     * 随便产生指定长度的数字
     * 
     * @param length
     *            长度
     * @return 随机数字
     */
    public static String generateArabicNumerals(int length) {
        Random rd = new Random();
        String n = "";
        int getNum;
        do {
            // 产生数字0-9的随机数
            getNum = Math.abs(rd.nextInt()) % 10 + 48;
            char num1 = (char) getNum;
            String dn = Character.toString(num1);
            n += dn;
        } while (n.length() < length);

        return n;
    }

    /**
     * 将图片地址换成http(https)完整路径
     * 
     * @param imageUrl
     *            图片地址
     * @return 图片完整地址
     */
    public static String toFullImageUrl(String imageUrl) {
        if (isBlank(imageUrl)) {
            return EMPTY;
        }
        imageUrl = imageUrl.replaceAll("\\\\", CommonConstants.BACKSLASH);
        if (imageUrl.startsWith(CommonConstants.BACKSLASH) && imageUrl.length() == 1) {
            return EMPTY;
        }
        if (imageUrl.startsWith(CommonConstants.BACKSLASH)) {
            imageUrl = imageUrl.substring(1);
        }
        if (imageUrl.startsWith("http") || imageUrl.startsWith("https")) {
            return imageUrl;
        }
        String uploadPath = defaultIfBlank(
                SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL), EMPTY);
        if (!uploadPath.endsWith(CommonConstants.BACKSLASH)) {
            uploadPath += CommonConstants.BACKSLASH;
        }
        return uploadPath + imageUrl;
    }

    /**
     * 将图片地址换成http(https)完整路径
     * 
     * @param imageUrl
     *            图片地址
     * @return 图片完整地址
     */
    public static String toFullLocalImageUrl(String imageUrl) {
        if (isBlank(imageUrl)) {
            return EMPTY;
        }
        imageUrl = imageUrl.replaceAll("\\\\", CommonConstants.BACKSLASH);
        if (imageUrl.startsWith(CommonConstants.BACKSLASH) && imageUrl.length() == 1) {
            return EMPTY;
        }
        if (imageUrl.startsWith(CommonConstants.BACKSLASH)) {
            imageUrl = imageUrl.substring(1);
        }
        if (imageUrl.startsWith("http") || imageUrl.startsWith("https")) {
            return imageUrl;
        }
        String uploadPath = defaultIfBlank(
                SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL), EMPTY);
        if (!uploadPath.endsWith(CommonConstants.BACKSLASH)) {
            uploadPath += CommonConstants.BACKSLASH;
        }
        return uploadPath + imageUrl;
    }

    /**
     * 将地址转换成手机端http全部地址
     * 
     * @param url
     *            url地址
     * @return url完整地址
     */
    public static String toFullMobileUrl(String url) {
        if (isBlank(url)) {
            return EMPTY;
        }
        url = url.replaceAll("\\\\", CommonConstants.BACKSLASH);
        if (url.startsWith(CommonConstants.BACKSLASH) && url.length() == 1) {
            return EMPTY;
        }
        if (url.startsWith(CommonConstants.BACKSLASH)) {
            url = url.substring(1);
        }
        if (url.startsWith("http") || url.startsWith("https")) {
            return url;
        }
        String mobileDomain = defaultIfBlank(
                SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.MOBILE_SYSTEM_DOMAIN), EMPTY);
        if (!mobileDomain.endsWith(CommonConstants.BACKSLASH)) {
            mobileDomain += CommonConstants.BACKSLASH;
        }
        return mobileDomain + url;
    }

    /**
     * 获取url的pathname,url去除域名和querystring部分
     * 
     * @param url
     *            http url
     * @return pathname
     */
    public static String getUrlPathName(String url) {
        if (url == null) {
            return null;
        }
        url = url.replace("/local/", "/");
        int at = url.indexOf("//");
        int from = url.indexOf("/", at >= 0 ? (url.lastIndexOf("/", at - 1) >= 0 ? 0 : at + 2) : 0);
        int to = url.length();
        if (url.indexOf('?', from) != -1) {
            to = url.indexOf('?', from);
        }
        if (url.lastIndexOf("#") > from && url.lastIndexOf("#") < to) {
            to = url.lastIndexOf("#");
        }
        return (from < 0) ? (at >= 0 ? "/" : url) : url.substring(from, to);
    }

    /**
     * 将字节流转换成16进制字符串
     * 
     * @param bytes
     *            字节流
     * @return 16进制字符串
     */
    public static String toHexString(byte[] bytes) {
        StringBuilder sign = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() == 1) {
                sign.append("0");
            }
            sign.append(hex);
        }
        return sign.toString();
    }

    /**
     * 过滤表情字符串
     * 
     * @param emojStr
     *            过滤的字符串
     * @return 过滤后的字符串
     */
    public static String removeNonBmpUnicode(String emojStr) {
        if (ObjectUtils.isNullOrEmpty(emojStr)) {
            return emojStr;
        }
        String pattern = "[\ud83c\udc00-\ud83c\udfff]|[\ud83d\udc00-\ud83d\udfff]|[\u2600-\u27ff]";
        Pattern emoji = Pattern.compile(pattern);
        Matcher emojiMatcher = emoji.matcher(emojStr);
        emojStr = emojiMatcher.replaceAll(EMPTY);
        return emojStr;
    }
}
