package com.yilidi.o2o.core.utils;

public class DistanceUtils {

    /**
     * 计算地球上任意两点(经纬度)距离
     * 
     * @param long1
     *            第一点经度
     * @param lat1
     *            第一点纬度
     * @param long2
     *            第二点经度
     * @param lat2
     *            第二点纬度
     * @return 返回距离 单位：米
     */
    public static int distance(String long1, String lat1, String long2, String lat2) {
        double a, b, R;
        R = 6378137; // 地球半径
        double latitude1 = Double.parseDouble(lat1) * Math.PI / 180.0;
        double latitude2 = Double.parseDouble(lat2) * Math.PI / 180.0;
        a = latitude1 - latitude2;
        b = (Double.parseDouble(long1) - Double.parseDouble(long2)) * Math.PI / 180.0;
        double d;
        double sa2, sb2;
        sa2 = Math.sin(a / 2.0);
        sb2 = Math.sin(b / 2.0);
        d = 2 * R * Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(latitude1) * Math.cos(latitude2) * sb2 * sb2));
        return Integer.parseInt(new java.text.DecimalFormat("0").format(d));
    }

}
