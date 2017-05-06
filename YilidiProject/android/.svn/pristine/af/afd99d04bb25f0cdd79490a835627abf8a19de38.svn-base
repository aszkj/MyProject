package com.yldbkd.www.library.android.common;

import android.content.Context;
import android.view.Gravity;
import android.widget.Toast;

/**
 * 提示信息工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class ToastUtils {

    public static Toast toast;
    public static final Character FLAG = 1;

    public static void show(Context context, String msg) {
        if (context == null) {
            return;
        }
        makeText(context, msg, Toast.LENGTH_LONG);
    }

    public static void show(Context context, int msgResId) {
        if (context == null) {
            return;
        }
        makeText(context, context.getResources().getString(msgResId), Toast.LENGTH_LONG);
    }

    public static void showShort(Context context, String msg) {
        if (context == null) {
            return;
        }
        makeText(context, msg, Toast.LENGTH_SHORT);
    }

    public static void showShort(Context context, int msgResId) {
        if (context == null) {
            return;
        }
        makeText(context, context.getResources().getString(msgResId), Toast.LENGTH_SHORT);
    }

    private static void makeText(Context context, String msg, int type) {
        synchronized (FLAG) {
            if (toast == null) {
                toast = Toast.makeText(context, msg, type);
            } else {
                toast.setText(msg);
                toast.setDuration(type);
            }
            toast.setGravity(Gravity.CENTER, 0, 0);
            toast.show();
        }
    }
}
