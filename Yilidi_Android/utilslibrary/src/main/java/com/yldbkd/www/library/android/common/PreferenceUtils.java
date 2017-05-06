package com.yldbkd.www.library.android.common;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import java.util.ArrayList;
import java.util.Map;
import java.util.Set;

/**
 * Preference工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class PreferenceUtils {
    public static ArrayList<String> getAllPreferenceKey(Context context) {
        if (context != null) {
            SharedPreferences sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null && null != sharedpreferences.getAll()) {
                ArrayList<String> arrayList = new ArrayList<String>();
                Set<String> keySet = sharedpreferences.getAll().keySet();
                for (String key : keySet) {
                    arrayList.add(key);
                }
                return arrayList;
            }
        }
        return null;

    }

    public static boolean getBooleanPref(Context context, String key, boolean flag) {
        SharedPreferences sharedpreferences;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                return sharedpreferences.getBoolean(key, flag);
            }
        }
        return flag;
    }

    public static long getLongPref(Context context, String key, long l) {
        SharedPreferences sharedpreferences;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                return sharedpreferences.getLong(key, l);
            }
        }
        return l;
    }

    public static int getIntPref(Context context, String key, int l) {
        SharedPreferences sharedpreferences;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                return sharedpreferences.getInt(key, l);
            }
        }
        return l;
    }

    public static String getStringPref(Context context, String key, String defaultStr) {
        SharedPreferences sharedpreferences;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                return sharedpreferences.getString(key, defaultStr);
            }
        }
        return defaultStr;
    }

    public static void getMapPref(Context context, Map<String, String> keyValues, String defaultStr) {
        SharedPreferences sharedpreferences;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                for (String key : keyValues.keySet()) {
                    keyValues.put(key, sharedpreferences.getString(key, defaultStr));
                }
            }
        }
    }

    public static void removePref(Context context, String key) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                editor.remove(key);
                editor.apply();
            }
        }
    }

    public static void removeMapPref(Context context, Map<String, String> map) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                for (String key : map.keySet()) {
                    editor.remove(key);
                }
                editor.apply();
            }
        }
    }

    public static void setBooleanPref(Context context, String s, boolean flag) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                editor.putBoolean(s, flag);
                editor.apply();
            }
        }

    }

    public static void setIntPref(Context context, String s, int long1) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                editor.putInt(s, long1);
                editor.apply();
            }
        }
    }

    public static void setLongPref(Context context, String s, long long1) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                editor.putLong(s, long1);
                editor.apply();
            }
        }
    }

    public static void setStringPref(Context context, String key, String value) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        if (context != null) {
            sharedpreferences = PreferenceManager.getDefaultSharedPreferences(context);
            if (sharedpreferences != null) {
                editor = sharedpreferences.edit();
                editor.putString(key, value);
                editor.apply();
            }
        }
    }

}
