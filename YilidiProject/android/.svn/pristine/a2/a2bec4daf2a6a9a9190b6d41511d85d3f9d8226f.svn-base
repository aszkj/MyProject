package com.yldbkd.www.library.android.common;

import android.app.Activity;
import android.util.DisplayMetrics;

/**
 * 屏幕像素转换工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class DisplayUtils {

    // 屏幕的宽高, 单位像素
    public static int screenWidth;
    public static int screenHeight;

    // 屏幕的密度
    public static float density; // 只有五种情况 : 0.75/ 1.0/ 1.5/ 2.0/ 3.0
    public static int densityDpi; // 只有五种情况 : 120/ 160/ 240/ 320/ 480

    // 水平垂直精确密度
    public static float xdpi; // 水平方向上的准确密度, 即每英寸的像素点
    public static float ydpi; // 垂直方向上的准确密度, 即没音村的像素点

    public static void getPixelDisplayMetricsII(Activity context) {
        DisplayMetrics dm = new DisplayMetrics();
        context.getWindowManager().getDefaultDisplay().getMetrics(dm);
        screenWidth = dm.widthPixels;
        screenHeight = dm.heightPixels;
        density = dm.density;
        densityDpi = dm.densityDpi;
        xdpi = dm.xdpi;
        ydpi = dm.ydpi;
    }

    public static int px2dp(Activity context, int px) {
        // 设备独立像素 和 分辨率之间转换 : dp = px / density ;
        getPixelDisplayMetricsII(context);
        return (int) (px / density + 0.5);
    }

    public static int dp2px(Activity context, float dp) {
        // 像素 和 设备独立像素 转换公式 : px = dp * densityDpi / 160 , density 是归一化密度;
        getPixelDisplayMetricsII(context);
        return (int) dp * densityDpi / 160;
    }
}
