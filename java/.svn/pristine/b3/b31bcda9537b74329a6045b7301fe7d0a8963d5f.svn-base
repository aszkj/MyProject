/**
 * 文件名称：DateUtils.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */

package com.yilidi.o2o.core.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Random;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：时间处理工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class DateUtils extends org.apache.commons.lang3.time.DateUtils {

    private DateUtils() {
    }

    private static final SimpleDateFormat SIMPLEDATEFORMAT = new SimpleDateFormat(CommonConstants.DATE_FORMAT_CURRENTTIME);

    /**
     * 获得当前时间的毫秒值
     * 
     * @return 时间 毫秒数
     */
    public static long millisTime() {
        return System.currentTimeMillis();
    }

    /**
     * 获取当前时间
     * 
     * @return 返回当前时间,Date类型
     */
    public static Date getCurrentDateTime() {
        java.util.Calendar calNow = java.util.Calendar.getInstance();
        java.util.Date dtNow = calNow.getTime();
        return dtNow;
    }

    /**
     * 获得当前日期时间字符串（yyyy-MM-dd HH:mm:ss）
     * 
     * @return 返回当前时间字符
     */
    public static String getCurrentDateTimeStr() {
        return SIMPLEDATEFORMAT.format(getCurrentDateTime());
    }

    /**
     * 将java.util.Date类型转换为java.sql.Date类型
     * 
     * @param date
     *            类型为java.util.Date
     * @return 返回java.sql.Date
     */
    public static java.sql.Date transferToSQLDate(Date date) {
        return new java.sql.Date(date.getTime());
    }

    /**
     * java.sql.Date 转换成 java.util.Date
     * 
     * @param date
     *            java.sql.Date类型
     * @return 返回java.util.Data类型
     */
    public static Date transferToUtilDate(java.sql.Date date) {
        return new Date(date.getTime());
    }

    /**
     * 
     * 将字符串格式化为日期
     * 
     * @param dateStr
     *            日期字符串
     * @param formatStr
     *            需要的格式，如 yyyy-MM-dd HH:mm:ss等
     * @return date
     * @throws ParseException
     *             转换异常
     * 
     */
    public static Date parseDate(String dateStr, String formatStr) throws ParseException {
        SIMPLEDATEFORMAT.applyPattern(formatStr);
        return SIMPLEDATEFORMAT.parse(dateStr);
    }

    /**
     * 
     * 将字符串格式化为日期
     * 
     * @param dateStr
     *            日期字符串(yyyy-MM-dd HH:mm:ss)
     * @return date
     * @throws ParseException
     *             转换异常
     * 
     */
    public static Date parseDate(String dateStr) throws ParseException {
        return parseDate(dateStr, CommonConstants.DATE_FORMAT_CURRENTTIME);
    }

    /**
     * 
     * 日期格式化为字符串
     * 
     * @param date
     *            日期
     * @param formatStr
     *            需要的格式， 如 yyyy-MM-dd HH:mm:ss等
     * @return 字符串格式的日期
     * 
     */
    public static String formatDate(Date date, String formatStr) {
        SIMPLEDATEFORMAT.applyPattern(formatStr);
        return SIMPLEDATEFORMAT.format(date);
    }

    /**
     * 
     * 将日期格式化为字符串，格式为 yyyy-MM-dd HH:mm:ss
     * 
     * @param date
     *            待转换的日期
     * @return 返回 格式化日期字符串
     * 
     */
    public static String formatDateLong(Date date) {
        return formatDate(date, CommonConstants.DATE_FORMAT_CURRENTTIME);
    }

    /**
     * 获取当前日期年份
     * 
     * @param date
     *            当前日期
     * @return 年份
     * 
     */
    public static String getYear(Date date) {
        SIMPLEDATEFORMAT.applyPattern("yyyy");
        return SIMPLEDATEFORMAT.format(date);
    }

    /**
     * 获取当前日期月份
     * 
     * @param date
     *            当前日期
     * @return 当前月份
     * 
     */
    public static String getMonth(Date date) {
        SIMPLEDATEFORMAT.applyPattern("MM");
        return SIMPLEDATEFORMAT.format(date);
    }

    /**
     * 
     * 取得给定日期 加上 给定分钟后的日期对象.
     * 
     * @param date
     *            当前日期
     * @param minutes
     *            分钟（大于0，日期推后，小于0，日期提前）
     * @return 日期
     * 
     */
    public static Date addMinutes(Date date, int minutes) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.MINUTE, minutes);
        return calendar.getTime();
    }

    /**
     * 
     * 取得给定日期 加上 给定小时后的日期对象.
     * 
     * @param date
     *            当前日期
     * @param hours
     *            分钟（大于0，日期推后，小于0，日期提前）
     * @return 日期
     * 
     */
    public static Date addHours(Date date, int hours) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.HOUR_OF_DAY, hours);
        return calendar.getTime();
    }

    /**
     * 
     * 得到当前日期提前或推后指定天数的 日期
     * 
     * @param date
     *            当前日期
     * @param days
     *            大于0，日期推后，小于0，日期提前 . 例如当前日期为2014-10-14，当days为2时，日期为2014-10-16，days为-2时，日期为2014-10-12
     * @return 日期
     * 
     */
    public static Date addDays(Date date, int days) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, days);
        return calendar.getTime();
    }

    /**
     * 
     * 取得给定日期 加上 给定月后的日期对象.
     * 
     * @param date
     *            当前日期
     * @param months
     *            月 大于0，日期推后，小于0，日期提前
     * @return 日期
     * 
     */
    public static Date addMonths(Date date, int months) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, months);
        return calendar.getTime();
    }

    /**
     * 
     * 取得给定日期 加上 给定年后的日期对象.
     * 
     * @param date
     *            当前日期
     * @param years
     *            月 大于0，日期推后，小于0，日期提前
     * @return 日期
     * 
     */
    public static Date addYears(Date date, int years) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.YEAR, years);
        return calendar.getTime();
    }

    /**
     * 根据指定的日期返回当前是星期几。1表示星期天、2表示星期一、7表示星期六。
     * 
     * @param date
     *            指定的日期
     * @return 星期编号 1表示星期天、2表示星期一、7表示星期六。
     */
    public static int getDayOfWeek(Date date) {
        Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return cal.get(Calendar.DAY_OF_WEEK);
    }

    /**
     * 根据指定的日期返回当前处于当月的第几周(一周的第一天为星期一)。
     * 
     * @param date
     *            指定的日期
     * @return 当前处于当月的第几周
     */
    public static int getWeekOfMonth(Date date) {
        Calendar cal = new GregorianCalendar();
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        cal.setTime(date);
        return cal.get(Calendar.WEEK_OF_MONTH);
    }

    /**
     * 返回当指定年月有多少天
     * 
     * @param year
     *            年
     * @param month
     *            月
     * @return 天数
     */
    public static int getMonthLastDay(int year, int month) {
        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month - 1);
        // 把日期设置为当月第一天
        a.set(Calendar.DATE, 1);
        // 日期回滚一天，也就是最后一天
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);

        return maxDate;
    }

    /**
     * 将字符串类型的日期转换为一个timestamp（时间戳记java.sql.Timestamp）
     * 
     * @param dateString
     *            待转换的字符串，格式为 yyyy
     * @param format
     * @return timestamp
     * @throws ParseException
     *             转换异常
     */
    public static java.sql.Timestamp string2Timestamp(String dateString) throws ParseException {
        Date date = SIMPLEDATEFORMAT.parse(dateString);
        return new java.sql.Timestamp(date.getTime());
    }

    /**
     * 计算两个日期之间相差的天数
     * 
     * @param data1
     *            时间1
     * @param data2
     *            时间2
     * @return 相差天数
     * @throws ParseException
     *             转换异常
     */
    public static long daysBetween(Date data1, Date data2) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(data1);
        long time1 = cal.getTimeInMillis();
        cal.setTime(data2);
        long time2 = cal.getTimeInMillis();
        long betweenDays = (time2 - time1) / (1000 * 3600 * 24);

        return Math.abs(betweenDays);
    }

    /**
     * 计算两个日期之间相差的天数
     * 
     * @param data1
     *            较小的时间
     * @param data2
     *            较大的时间
     * @return 相差天数
     * @throws ParseException
     *             转换异常
     */
    public static long daysBetween(String data1, String data2) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(CommonConstants.DATE_FORMAT_CURRENTTIME);
        Calendar cal = Calendar.getInstance();
        cal.setTime(sdf.parse(data1));
        long time1 = cal.getTimeInMillis();
        cal.setTime(sdf.parse(data2));
        long time2 = cal.getTimeInMillis();
        long betweenDays = (time2 - time1) / (1000 * 3600 * 24);

        return Math.abs(betweenDays);
    }

    /**
     * 计算两个日期之间相差的秒数
     * 
     * @param data1
     *            较小的时间
     * @param data2
     *            较大的时间
     * @return 相差秒数
     * @throws ParseException
     *             转换异常
     */
    public static long secondsBetween(String data1, String data2) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(CommonConstants.DATE_FORMAT_CURRENTTIME);
        Calendar cal = Calendar.getInstance();
        cal.setTime(sdf.parse(data1));
        long time1 = cal.getTimeInMillis();
        cal.setTime(sdf.parse(data2));
        long time2 = cal.getTimeInMillis();
        long betweenSeconds = (time2 - time1) / 1000;

        return Math.abs(betweenSeconds);
    }

    /**
     * 计算两个日期之间相差的秒数
     * 
     * @param data1
     *            时间1
     * @param data2
     *            时间2
     * @return 相差秒数
     * @throws ParseException
     *             转换异常
     */
    public static long secondsBetween(Date data1, Date data2) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(data1);
        long time1 = cal.getTimeInMillis();
        cal.setTime(data2);
        long time2 = cal.getTimeInMillis();
        long betweenSeconds = (time2 - time1) / 1000;

        return Math.abs(betweenSeconds);
    }

    /**
     * 
     * 获取当天的开始时间 00:00:00
     * 
     * @return 获取当天的开始时间
     * @throws ParseException
     *             转换异常
     */
    public static Date getTodayStartDate() throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    /**
     * 
     * 获取当天的结束时间 23:59:59
     * 
     * @return
     * @throws ParseException
     */
    public static Date getTodayEndDate() throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    /**
     * 
     * 获取指定某一天的开始时间 00:00:00
     * 
     * @return
     * @throws ParseException
     */
    public static Date getSpecificStartDate(Date specificDate) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(specificDate);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    /**
     * 
     * 获取指定某一天的结束时间 23:59:59
     * 
     * @return
     * @throws ParseException
     */
    public static Date getSpecificEndDate(Date specificDate) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(specificDate);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    /**
     * 
     * 获取指定某一天的开始时间 00:00:00
     * 
     * @return
     * @throws ParseException
     */
    public static Date getSpecificStartDate(String strSpecificDate) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(DateUtils.parseDate(strSpecificDate, CommonConstants.DATE_FORMAT_DAY));
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    /**
     * 
     * 获取指定某一天的结束时间 23:59:59
     * 
     * @return
     * @throws ParseException
     */
    public static Date getSpecificEndDate(String strSpecificDate) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(DateUtils.parseDate(strSpecificDate, CommonConstants.DATE_FORMAT_DAY));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    /**
     * 
     * 获取当前时间 时分秒 HH:mm:ss字符串
     * 
     * @return
     * @throws ParseException
     */
    public static String getTimeOfDay(Date date) throws ParseException {
        return formatDate(date, CommonConstants.DATE_FORMAT_TIME);
    }

    /**
     * @Description 距离今天还有多少秒
     * @return
     */
    public static int getTodayLeftSeconds() {
        Calendar curDate = Calendar.getInstance();
        Calendar tommorowDate = new GregorianCalendar(curDate.get(Calendar.YEAR), curDate.get(Calendar.MONTH),
                curDate.get(Calendar.DATE) + 1, 0, 0, 0);
        return (int) (tommorowDate.getTimeInMillis() - curDate.getTimeInMillis()) / 1000;
    }

    /**
     * 获取当前周或向前或向后推迟数周后具体某一天的日期 一周：星期一到星期日
     * 
     * @param putOffWeeks
     *            推迟的周数，0本周，-1上周，1下周，2下下周，依次类推
     * @param calendarWeekDay
     *            星期几 Calendar.MONDAY，Calendar.TUESDAY，Calendar.WEDNESDAY，依次类推
     * @return Date 当前周或向前或向后推迟数周后具体某一天的日期
     */
    public static Date getConcreteDateByPutOffWeeks(int putOffWeeks, int calendarWeekDay) {
        Calendar calendar = Calendar.getInstance();
        if (1 == getDayOfWeek(getCurrentDateTime())) {
            if (Calendar.SUNDAY == calendarWeekDay) {
                calendar.add(Calendar.DATE, (putOffWeeks) * 7);
            } else {
                calendar.add(Calendar.DATE, (putOffWeeks - 1) * 7);
            }
        } else {
            if (Calendar.SUNDAY == calendarWeekDay) {
                calendar.add(Calendar.DATE, (putOffWeeks + 1) * 7);
            } else {
                calendar.add(Calendar.DATE, (putOffWeeks) * 7);
            }
        }
        calendar.set(Calendar.DAY_OF_WEEK, calendarWeekDay);
        return calendar.getTime();
    }

    /**
     * 获取当前月或向前或向后推迟数月的第一天
     * 
     * @param putOffMonths
     *            推迟的月数，0本月，-1上月，1下月，2下下月，依次类推
     * @return Date 当前月或向前或向后推迟数月的第一天
     */
    public static Date getFirstDateByPutOffMonths(int putOffMonths) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, putOffMonths);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * 获取当前月或向前或向后推迟数月的最后一天
     * 
     * @param putOffMonths
     *            推迟的月数，0本月，-1上月，1下月，2下下月，依次类推
     * @return Date 当前月或向前或向后推迟数月的最后一天
     */
    public static Date getLastDateByPutOffMonths(int putOffMonths) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, putOffMonths);
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        return calendar.getTime();
    }
    
    /**
     * 获取一个月前两个月内的任意时间
     * 描述:<描述函数实现的功能>.
     * @param date
     * @param start 
     * @param end
     * @return
     */
    public static Date getLastMonth(Date date,Integer start,Integer end) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
    	String repeatDate = sdf.format(date);
        Calendar cal = Calendar.getInstance();
        int year = Integer.parseInt(repeatDate.substring(0, 4));
        String monthsString = repeatDate.substring(4, 6);
        String daySting = repeatDate.substring(6, 8);
        int month;
        if ("0".equals(monthsString.substring(0, 1))) {
            month = Integer.parseInt(monthsString.substring(1, 2));
        } else {
            month = Integer.parseInt(monthsString.substring(0, 2));
        }
        int day ;
        if ("0".equals(monthsString.substring(0, 1))) {
        	day = Integer.parseInt(daySting.substring(1, 2));
        } else {
        	day = Integer.parseInt(daySting.substring(0, 2));
        }
        cal.set(year,month-1,day-getRandomNum(start,end),getRandomNum(7,23),getRandomNum(1,60),getRandomNum(1,60));//Calendar.DATE);
        return cal.getTime();
    }
    /**
     * 获取指定范围的随机数
     * @param min
     * @param max
     * @return
     */
    public static Integer getRandomNum(Integer min,Integer max) {
    	Random random = new Random();
    	Integer s = random.nextInt(max)%(max-min+1) + min;
    	return s;
    }
    

}
