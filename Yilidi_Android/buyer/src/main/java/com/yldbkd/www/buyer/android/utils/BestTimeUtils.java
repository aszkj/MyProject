package com.yldbkd.www.buyer.android.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

/**
 * 送货时间工具类
 * <p/>
 * Created by linghuxj on 15/10/31.
 */
public class BestTimeUtils {

    public static final String[] TIME_AREAS = {"00:00 - 01:00", "01:00 - 02:00", "02:00 - 03:00", "03:00 - 04:00",
            "04:00 - 05:00", "05:00 - 06:00", "06:00 - 07:00", "07:00 - 08:00", "08:00 - 09:00", "09:00 - 10:00",
            "10:00 - 11:00", "11:00 - 12:00", "12:00 - 13:00", "13:00 - 14:00", "14:00 - 15:00", "15:00 - 16:00",
            "16:00 - 17:00", "17:00 - 18:00", "18:00 - 19:00", "19:00 - 20:00", "20:00 - 21:00", "21:00 - 22:00",
            "22:00 - 23:00", "23:00 - 00:00"};

    public static final String[] TIME_AREAS_SPECIAL = {"10:00 - 12:00", "12:00 - 14:00", "14:00 - 16:00", "16:00 - 18:00",
            "18:00 - 20:00", "20:00 - 22:00"};

    private static final int INTERVAL = 1;
    private static final int SPECIAL_INTERVAL = 2;

    public static final String[] DAY_AREAS = {"今天", "明天", "后天"};

    public static final String SOON_AREA = "立即送达";

    public static String[] getDayAreas(Long currentTime, Integer storeType) {
        if (storeType == Constants.StoreType.SUPER_MARKET) {
            Integer currentPosition = getCurrentPosition(currentTime, storeType);
            Integer endPosition = TIME_AREAS_SPECIAL.length - 1;
            if (currentPosition > endPosition) {
                return new String[]{
                        DAY_AREAS[1], DAY_AREAS[2]
                };
            } else {
                return DAY_AREAS;
            }
        } else {
            return DAY_AREAS;
        }
    }

    public static String[][] getTimeAreas(String beginTime, String endTime, Long currentTime, Integer storeType) {
        String[][] times;
        Integer beginPosition, endPosition;
        Integer currentPosition = getCurrentPosition(currentTime, storeType);
        if (storeType == Constants.StoreType.SUPER_MARKET) {
            beginPosition = 0;
            endPosition = TIME_AREAS_SPECIAL.length - 1;
            if (currentPosition > endPosition) {
                times = new String[2][];
                times[0] = times[1] = getCurrentTimeArea(false, beginPosition, endPosition, null, storeType);
            } else {
                times = new String[3][];
                times[0] = getCurrentTimeArea(false, beginPosition, endPosition, currentPosition, storeType);
                times[2] = times[1] = getCurrentTimeArea(false, beginPosition, endPosition, null, storeType);
            }
        } else {
            times = new String[3][];
            beginPosition = Integer.valueOf(beginTime.substring(0, 2));
            endPosition = Integer.valueOf(endTime.substring(0, 2));
            times[0] = getCurrentTimeArea(true, beginPosition, endPosition, currentPosition, storeType);
            times[2] = times[1] = getCurrentTimeArea(false, beginPosition, endPosition, null, storeType);
        }
        return times;
    }

    private static String[] getCurrentTimeArea(boolean isToday, Integer beginPosition, Integer endPosition,
                                               Integer currentPosition, Integer storeType) {
        List<String> timeList = new ArrayList<>();
        if (currentPosition != null) {
            beginPosition = currentPosition;
        }
        if (isToday) {
            timeList.add(SOON_AREA);
        }
        String[] timeAreas;
        if (storeType == Constants.StoreType.SUPER_MARKET) {
            timeAreas = TIME_AREAS_SPECIAL;
        } else {
            timeAreas = TIME_AREAS;
        }
        if (beginPosition >= endPosition) {
            // 该情况为垮天
            if (!isToday) {
                for (int i = 0; i < endPosition; i++) {
                    timeList.add(timeAreas[i]);
                }
            }
            for (int j = beginPosition; j < 24; j++) {
                timeList.add(timeAreas[j]);
            }
        } else {
            for (int i = beginPosition; i < endPosition; i++) {
                timeList.add(timeAreas[i]);
            }
        }
        String[] time = new String[timeList.size()];
        return timeList.toArray(time);
    }

    private static Integer getCurrentPosition(Long currentTime, Integer storeType) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(currentTime);
        Integer interval = INTERVAL;
        Integer timeDifferent = Integer.valueOf(TIME_AREAS[0].substring(0, 2)) / INTERVAL;
        if (storeType == Constants.StoreType.SUPER_MARKET) {
            // 商超类型
            interval = SPECIAL_INTERVAL;
            timeDifferent = Integer.valueOf(TIME_AREAS_SPECIAL[0].substring(0, 2)) / SPECIAL_INTERVAL;
        }
        calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) + INTERVAL);
        Integer position = (calendar.get(Calendar.HOUR_OF_DAY) + interval) / interval - timeDifferent;
        position = position < 0 ? 0 : position;
        return position;
    }

    public static String getBestTime(Long currentTime, Integer dayPosition, String time, Integer storeType) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(currentTime);
        calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + dayPosition);
        calendar.set(Calendar.HOUR_OF_DAY, getTime(time, storeType));
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return new SimpleDateFormat(Constants.DAY_TIME_FORMAT, Locale.CHINA).format(calendar.getTime());
    }

    private static Integer getTime(String selectTime, Integer storeType) {
        int position = 0;
        String[] timeAreas = storeType == Constants.StoreType.SUPER_MARKET ? TIME_AREAS_SPECIAL :
                TIME_AREAS;
        for (String time : timeAreas) {
            if (time.equals(selectTime)) {
                break;
            }
            position++;
        }
        return Integer.valueOf(timeAreas[position].substring(0, 2));
    }
}
