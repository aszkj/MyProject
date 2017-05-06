/**
 * 文件名称：ArithUtils.java
 * 
 * 描述：金额计算工具
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.math.BigDecimal;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：金额计算工具 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class ArithUtils {
    private static Logger logger = Logger.getLogger(ArithUtils.class);

    private ArithUtils() {
    }

    private static final String TIPS = "scale参数必须是大于等于0的整数";
    /**
     * 默认除法计算精度
     */
    private static final int DEF_DIV_SCALE = 10;

    /**
     * 四舍五入精度默认值，小数点后3位
     */
    public static final int DEF_ROUND_SCALE = 3;

    /**
     * double 转换为float 类型转换(Float)
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static float convertsToFloat(double v) {
        BigDecimal b = new BigDecimal(v);
        return b.floatValue();
    }

    /**
     * 将double类型转换为整型 ， 不进行四舍五入
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static int convertsToIntNoRound(double v) {
        BigDecimal b = new BigDecimal(v);
        return b.intValue();
    }

    /**
     * 将double类型转换为整型(四舍五入)
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static int convertsToIntWithRound(double v) {
        BigDecimal b = new BigDecimal(v).setScale(0, BigDecimal.ROUND_HALF_UP);
        return b.intValue();
    }

    /**
     * double类型转换为Long型，不进行四舍五入
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static long convertsToLongNoRound(double v) {
        BigDecimal b = new BigDecimal(v);
        return b.longValue();
    }

    /**
     * double类型转换为Long型(四舍五入)
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static long convertsToLongWithRound(double v) {
        BigDecimal b = new BigDecimal(v).setScale(0, BigDecimal.ROUND_HALF_UP);
        return b.longValue();
    }

    /**
     * 返回两个数中大的一个值
     * 
     * @param v1
     *            需要被对比的第一个数
     * @param v2
     *            需要被对比的第二个数
     * @return 返回两个数中大的一个值
     */
    public static double returnMax(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.max(b2).doubleValue();
    }

    /**
     * 返回两个数中小的一个值
     * 
     * @param v1
     *            需要被对比的第一个数
     * @param v2
     *            需要被对比的第二个数
     * @return 返回两个数中小的一个值
     */
    public static double returnMin(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.min(b2).doubleValue();
    }

    /**
     * 对比两个数字
     * 
     * @param v1
     *            需要被对比的第一个数
     * @param v2
     *            需要被对比的第二个数
     * @return 如果两个数一样则返回0，如果第一个数比第二个数大则返回1，反之返回-1
     */
    public static int compareTo(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.compareTo(b2);
    }

    /**
     * 加法运算。
     * 
     * @param v1
     *            被加数
     * @param v2
     *            加数
     * @return 两个参数的和
     */
    public static double add(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2).doubleValue();
    }

    /**
     * 多个参数的加法运算。
     * 
     * <pre>
     * add(12.6, 15.14);
     * add(12.6, 15.14, 21.56);
     * add(12.6, 15.14, 21.56, 14.8);
     * </pre>
     * 
     * @param params
     *            参与运算的参数列表
     * @return 多个参数的和
     */
    public static double add(double... params) {
        double result = 0;
        for (int i = 0; i < params.length; i++) {
            result = add(result, params[i]);
        }
        return result;
    }

    /**
     * 减法运算。
     * 
     * @param v1
     *            被减数
     * @param v2
     *            减数
     * @return 两个参数的差
     */
    public static double sub(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.subtract(b2).doubleValue();
    }

    /**
     * 计算多个参数的差
     * 
     * <pre>
     * sub(25.6, 21.2) => 25.6 - 21.2
     * sub(25.6, 21.2, 28.5) => 25.6 - 21.2 - 28.5
     * </pre>
     * 
     * @param parms
     *            参与运算的参数列表
     * @return 运算结果
     */
    public static double sub(double... parms) {
        if (null == parms || 0 == parms.length) {
            return 0.0;
        }
        double result = parms[0];
        for (int i = 1; i < parms.length; i++) {
            result = sub(result, parms[i]);
        }
        return result;
    }

    /**
     * 乘法运算。
     * 
     * @param v1
     *            被乘数
     * @param v2
     *            乘数
     * @return 两个参数的积
     */
    public static double mul(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }

    /**
     * 除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
     * 
     * @param v1
     *            被除数
     * @param v2
     *            除数
     * @return 两个参数的商
     */
    public static double div(double v1, double v2) {
        return div(v1, v2, DEF_DIV_SCALE);
    }

    /**
     * 除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
     * 
     * @param v1
     *            被除数
     * @param v2
     *            除数
     * @param scale
     *            表示表示需要精确到小数点以后几位（必须是大于或等于0的整数）。
     * @return 两个参数的商
     */
    public static double div(double v1, double v2, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(TIPS);
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 小数位四舍五入处理，保留默认配置的小数位(保留小数点后3位)
     * 
     * @param v
     *            需要四舍五入的数字
     * @return 四舍五入后的结果
     */
    public static double round(double v) {
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal(1);
        return b.divide(one, DEF_ROUND_SCALE, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 小数位四舍五入处理。
     * 
     * @param v
     *            需要四舍五入的数字
     * @param scale
     *            小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static double round(double v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(TIPS);
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal(1);
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * Long转换为double类型转换
     * 
     * @param v
     *            需要被转换的数字
     * @return 返回转换结果
     */
    public static double convertLongTodouble(Long v) {
        if (v == null) {
            return 0.0;
        }
        BigDecimal b = new BigDecimal(v);
        return b.doubleValue();
    }

    /**
     * 将Long对象转换为基础类型long
     * 
     * @param value
     *            Long对象
     * @return 基础类型long值
     */
    public static long converLongTolong(Long value) {
        if (null == value) {
            return 0L;
        }
        return value.longValue();
    }

    /**
     * 将Integer对象转换为基础类型int
     * 
     * @param value
     *            Long对象
     * @return 基础类型long值
     */
    public static int converIntegerToInt(Integer value) {
        if (null == value) {
            return 0;
        }
        return value.intValue();
    }

    /**
     * 将字符串转换为整形
     * 
     * @param str
     *            待转字符串
     * @return 转换后的整数
     */
    public static int converStringToInt(String str) {
        return converStringToInt(str, 0);
    }

    /**
     * 将字符串转换为整形
     * 
     * @param str
     *            待转字符串
     * @param defaultValue
     *            默认值
     * @return 转换后的整数
     */
    public static int converStringToInt(String str, int defaultValue) {
        if (StringUtils.isEmpty(str)) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(str);
        } catch (Exception e) {
            logger.error(e, e);
            return defaultValue;
        }
    }

    /**
     * 将厘单位转换为分单位
     * 
     * @param liLong
     *            厘数值
     * @return 分数值
     */
    public static Long convertToFen(Long liLong) {
        if (null == liLong) {
            return 0L;
        }
        return (liLong + 5) / 10;
    }

    /**
     * 将厘单位数值转换为元单位数值的字符串
     * 
     * @param liLong
     *            厘数值
     * @return 元字符串
     */
    public static String convertToYuanStr(Long liLong) {
        if (null == liLong) {
            return "0.00";
        }
        Long fenLong = convertToFen(liLong);
        StringBuilder yuanBuilder = new StringBuilder();
        yuanBuilder.append(fenLong / 100).append(CommonConstants.DELIMITER_DOT);
        Long afterDot = fenLong % 100;
        if (afterDot < 10) {
            yuanBuilder.append("0");
        }
        yuanBuilder.append(afterDot);
        return yuanBuilder.toString();
    }
}
