package com.yldbkd.www.seller.android.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * 时间计算工具类
 * <p/>
 * Created by linghuxj on 16/7/14.
 */
public class TimeUtils {

    public static String deliveryTime(String payTime) {
        try {
            SimpleDateFormat format = new SimpleDateFormat(Constants.TIME_FORMAT, Locale.getDefault());
            Calendar pay = strToCalendar(format, payTime);
            pay.add(Calendar.HOUR_OF_DAY, 1);
            return format.format(pay.getTime());
        } catch (Exception e) {

        }
        return "";
    }

    private static Calendar strToCalendar(SimpleDateFormat format, String time) throws Exception {
        Calendar calendar = null;
        try {
            Date date = format.parse(time);
            calendar = Calendar.getInstance();
            calendar.setTime(date);
        } catch (ParseException e) {
            Logger.e("时间转换出现异常，订单列表给出的支付时间格式不正确");
            throw new Exception(e);
        }
        return calendar;
    }
}
