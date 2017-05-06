package com.yldbkd.www.library.android.network;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

/**
 * 网络监测工具类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class NetworkUtils {

    // 判断当前是否有网络
    public static boolean isHasNetwork(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (cm == null) {
            return false;
        }
        NetworkInfo networkInfo = cm.getActiveNetworkInfo();
        return (networkInfo != null && networkInfo.isAvailable());
    }
}
