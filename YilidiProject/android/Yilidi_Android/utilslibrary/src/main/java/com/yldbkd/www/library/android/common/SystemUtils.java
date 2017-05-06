package com.yldbkd.www.library.android.common;

import android.content.Context;
import android.provider.Settings;
import android.telephony.TelephonyManager;

import java.util.UUID;

/**
 * 系统工具类
 * <p/>
 * Created by linghuxj on 15/12/8.
 */
public class SystemUtils {

    /**
     * 获取手机识别码
     *
     * @param context
     * @return
     */
    public static String getDeviceId(Context context) {
        final TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        final String tmDevice, tmSerial, androidId;
        tmDevice = "" + tm.getDeviceId();
        tmSerial = "" + tm.getSimSerialNumber();
        androidId = "" + Settings.Secure.getString(context.getContentResolver(),
                Settings.Secure.ANDROID_ID);
        UUID deviceUuid = new UUID(androidId.hashCode(), ((long) tmDevice.hashCode() << 32) | tmSerial.hashCode());
        return deviceUuid.toString();
    }
}
