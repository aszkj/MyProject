package com.yldbkd.www.library.android.common;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import java.util.Timer;
import java.util.TimerTask;

/**
 * 键盘显示工具类
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class KeyboardUtils {

    /**
     * 关闭软件盘
     *
     * @param activity 当前的Activity
     */
    public static void close(Activity activity) {
        if (null == activity) {
            return;
        }
        InputMethodManager inputMethodManager = (InputMethodManager) activity
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        if (inputMethodManager.isActive()) {
            View currentFocusView = activity.getCurrentFocus();
            if (null != currentFocusView) {
                inputMethodManager.hideSoftInputFromWindow(currentFocusView.getWindowToken(), 0);
            }
        }
    }

    public static void open(Context context, View view) {
        InputMethodManager inputmethodmanager = (InputMethodManager) context
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        if (inputmethodmanager != null) {
            inputmethodmanager.showSoftInput(view, 0);
        }
    }

    /**
     * 延时打开软键盘
     *
     * @param context
     * @param view
     */
    public static void openDelay(final Context context, final View view) {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
                           public void run() {
                               InputMethodManager inputmethodmanager = (InputMethodManager) context
                                       .getSystemService(Context.INPUT_METHOD_SERVICE);
                               if (inputmethodmanager != null) {
                                   inputmethodmanager.showSoftInput(view, 0);
                               }
                           }

                       },
                500);
    }


    /**
     * 关闭软件盘
     *
     * @param activity 当前的Activity
     */
    public static void close(Activity activity, View view) {
        if (null == activity) {
            return;
        }
        InputMethodManager inputMethodManager = (InputMethodManager) activity
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        if (inputMethodManager.isActive()) {
            inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }
}
