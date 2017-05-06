package com.yldbkd.www.buyer.android.utils;

import android.util.Log;
import com.yldbkd.www.buyer.android.BuyerApp;

/**
 * 日志打印工具类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class Logger {

    private static boolean isDebug;

    static {
        isDebug = BuyerApp.getInstance().isDebug();
    }

    public static void e(String msg) {
        if (isDebug) {
            Log.e(Constants.TAG, msg);
        }
    }

    public static void d(String msg) {
        if (isDebug) {
            Log.d(Constants.TAG, msg);
        }
    }

    public static void i(String msg) {
        if (isDebug) {
            Log.i(Constants.TAG, msg);
        }
    }

    public static void w(String msg) {
        if (isDebug) {
            Log.w(Constants.TAG, msg);
        }
    }
}
