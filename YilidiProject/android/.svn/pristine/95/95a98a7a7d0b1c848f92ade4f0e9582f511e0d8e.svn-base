package com.yldbkd.www.buyer.android.utils;

import android.content.Context;
import android.text.TextUtils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yldbkd.www.library.android.common.PreferenceUtils;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * 搜索历史记录工具类
 * <p/>
 * Created by linghuxj on 15/11/5.
 */
public class HistoryUtils {

    private static final int DEFAULT_SIZE = 15;

    public static List<String> getHistory(Context context ,String key) {
//        String history = PreferenceUtils.getStringPref(context, PreferenceName.Search.SEARCH_HISTORY, null);
        String history = PreferenceUtils.getStringPref(context, key, null);
        if (TextUtils.isEmpty(history)) {
            return null;
        }
        Gson gson = new Gson();
        Type type = new TypeToken<List<String>>() {
        }.getType();
        return gson.fromJson(history, type);
    }

    public static void addHistory(Context context, String history ,String key) {
        if (TextUtils.isEmpty(history)) {
            return;
        }
        List<String> list = getHistory(context ,key);
        if (list == null) {
            list = new ArrayList<>();
        }
        Logger.d("搜索历史记录数据：" + new Gson().toJson(list));
        int position = -1;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).equals(history)) {
                position = i;
            }
        }
        if (position >= 0) {
            list.remove(list.get(position));
        }
        list.add(history);
        if (list.size() > DEFAULT_SIZE) {
            list.remove(0);
        }
        Logger.d("搜索历史记录数据后：" + new Gson().toJson(list));
//        PreferenceUtils.setStringPref(context, PreferenceName.Search.SEARCH_HISTORY, new Gson().toJson(list));
        PreferenceUtils.setStringPref(context, key, new Gson().toJson(list));
    }

    public static void clearHistory(Context context,String key) {
//        PreferenceUtils.removePref(context, PreferenceName.Search.SEARCH_HISTORY);
        PreferenceUtils.removePref(context, key);
    }

}
