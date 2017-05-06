package com.yldbkd.www.library.android.common;

import java.math.BigDecimal;

/**
 * 距离工具类
 * <p/>
 * Created by linghuxj on 16/6/24.
 */
public class DistanceUtils {

    public static final String M = "m";
    public static final String KM = "km";

    public static String getDistance(Integer distance) {
        if (distance == null || distance <= 0) {
            return 0 + M;
        }
        return new BigDecimal(distance / 1000f).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue() + KM;
    }
}
