package com.yldbkd.www.buyer.android.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * 日期时间工具类
 * <p/>
 * Created by linghuxj on 16/8/24.
 */
public class DateUtils {
    /**
     * 完整日期时间格式化
     */
    public static final String DAY_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    public static final String DAY_TIME_FORMAT_SHORT = "yyyy-MM-dd";

    public static String parseDate(long time) {
        SimpleDateFormat sdf = new SimpleDateFormat(DAY_TIME_FORMAT, Locale.getDefault());
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(time);
        return sdf.format(cal.getTime());
    }

    public static String parseDateChange(String time, String fromat) {
        SimpleDateFormat sdf = new SimpleDateFormat(fromat, Locale.getDefault());
        try {
            return sdf.format(sdf.parse(time));
        } catch (ParseException e) {
            Logger.e("时间转化异常" + e);
            return null;
        }
    }

    /**
     * 计算两个日期之间相差的毫秒数
     *
     * @param date1 时间1
     * @param date2 时间2
     * @return 相差毫秒数
     */
    public static long secondsBetween(String date1, String date2) {
        SimpleDateFormat sdf = new SimpleDateFormat(DAY_TIME_FORMAT, Locale.getDefault());
        try {
            return secondsBetween(sdf.parse(date1), sdf.parse(date2));
        } catch (ParseException e) {
            Logger.e("时间转化异常" + e);
            return 0;
        }
    }

    /**
     * 计算两个日期之间相差的毫秒数
     *
     * @param date1 时间1
     * @param date2 时间2
     * @return 相差毫秒数
     */
    public static long secondsBetween(Date date1, Date date2) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date1);
        long time1 = cal.getTimeInMillis();
        cal.setTime(date2);
        long time2 = cal.getTimeInMillis();
        return time2 - time1;
    }

    /**
     * 计算所计算日期与当前时间之间相差的毫秒数
     *
     * @param date 时间
     * @return 相差毫秒数
     */
    public static long secondsBetweenNow(String date) {
        SimpleDateFormat sdf = new SimpleDateFormat(DAY_TIME_FORMAT, Locale.getDefault());
        try {
            return secondsBetweenNow(sdf.parse(date));
        } catch (ParseException e) {
            Logger.e("时间转化异常" + e);
            return 0;
        }
    }

    /**
     * 计算所计算日期与当前时间之间相差的毫秒数
     *
     * @param date 时间
     * @return 相差毫秒数
     */
    public static long secondsBetweenNow(Date date) {
        Calendar cal = Calendar.getInstance();
        long now = cal.getTimeInMillis();
        cal.setTime(date);
        long time = cal.getTimeInMillis();
        return time - now;
    }

    /**
     * 获取当前时间
     *
     * @return 日期
     */
    public static String getCurrentTiem() {
        SimpleDateFormat sdf = new SimpleDateFormat(DAY_TIME_FORMAT, Locale.getDefault());
        Calendar cal = Calendar.getInstance();
        cal.getTime();
        return sdf.format(cal.getTime());
    }

    /**
     * 获取当前毫秒数的计算出来的小时数
     *
     * @param timeInMillis 当前毫秒数
     * @return 小时数 00 - 99
     */
    public static String getHour(long timeInMillis) {
        long hour = timeInMillis / (60 * 60 * 1000);
        if (hour < 10) {
            return "0" + hour;
        } else if (hour > 99) {
            return "99";
        } else {
            return String.valueOf(hour);
        }
    }

    /**
     * 获取当前毫秒数的计算出来的分钟数
     *
     * @param timeInMillis 当前毫秒数
     * @return 分钟数 00 - 59
     */
    public static String getMinute(long timeInMillis) {
        long time = timeInMillis % (60 * 60 * 1000);
        long minute = time / (60 * 1000);
        if (minute < 10) {
            return "0" + minute;
        } else if (minute > 59) {
            return "59";
        } else {
            return String.valueOf(minute);
        }
    }

    /**
     * 获取当前毫秒数的计算出来的秒数
     *
     * @param timeInMillis 当前毫秒数
     * @return 秒数 00 - 59
     */
    public static String getSecond(long timeInMillis) {
        long time = timeInMillis % (60 * 1000);
        long second = time / 1000;
        if (second < 10) {
            return "0" + second;
        } else if (second > 59) {
            return "59";
        } else {
            return String.valueOf(second);
        }
    }
}
