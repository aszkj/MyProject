package com.yldbkd.www.library.android.common;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextUtils;
import android.text.style.ImageSpan;
import android.text.style.TextAppearanceSpan;
import android.util.Log;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * 文字大小不同改变
 * <p/>
 * Created by linghuxj on 16/5/27.
 */
public class TextChangeUtils {

    public static final String PATTERN = "%[0-9]\\$[a-z]";

    /**
     * 将金额显示效果进行修改，将小数数据显示缩小
     *
     * @param context    上下文
     * @param money      所需显示金额，如：￥1,000.00
     * @param textView   所要显示的控件
     * @param styleResId 小数的style资源ID
     */
    public static void setMoneyText(Context context, TextView textView, String money, int styleResId) {
        if (money.length() < 3 || !money.contains(".")) {
            return;
        }
        String[] split = money.split("\\.");
        split[0] = split[0] + ".";
        List<String> values = Arrays.asList(split);
        Map<Integer, Integer> styleMap = new HashMap<>();
        styleMap.put(1, styleResId);
        addSpan(context, textView, values, styleMap);
    }

    /**
     * 以原设置文本属性填充各种类型数据的属性展示出来
     *
     * @param textView     所显示的控件，默认为下列stringResId的显示属性
     * @param resId        默认显示的内容resource
     * @param styleResIds  特殊内容的显示属性
     * @param stringResIds 需要显示的特殊内容
     */
    public static void setDifferentText(Context context, TextView textView, int resId,
                                        List<Integer> styleResIds, Object... stringResIds) {
        if (stringResIds == null || context == null) {
            return;
        }
        textView.setText(null);
        String stringRes = context.getString(resId);
        List<String> values = new ArrayList<>();
        Map<Integer, Integer> styleMap = new HashMap<>();
        Pattern pattern = Pattern.compile(PATTERN);
        String[] splitStr = pattern.split(stringRes);
        if (splitStr.length < stringResIds.length) {
            Log.e("TextChangeUtils", "length is not enough!");
            return;
        }
        int index = -1;
        for (int i = 0; i < splitStr.length; i++) {
            String value = splitStr[i];
            if (!TextUtils.isEmpty(value)) {
                values.add(value);
                index++;
            }
            if (i < stringResIds.length) {
                values.add(String.valueOf(stringResIds[i]));
                index++;
                if (i < styleResIds.size()) {
                    styleMap.put(index, styleResIds.get(i));
                }
            }
        }
        addSpan(context, textView, values, styleMap);
    }

    /**
     * 图片加入到文本前
     *
     * @param context    上下文
     * @param textView   文本View
     * @param imageResId 图片资源ID
     * @param string     文字内容
     */
    public static void setImageText(Context context, TextView textView, int imageResId, String string) {
        setImageText(context, textView, imageResId, string, false);
    }

    /**
     * 图片加入到文本前后
     *
     * @param context    上下文
     * @param textView   文本View
     * @param imageResId 图片资源ID
     * @param string     文字内容
     * @param isEnd      是否图片处于文本之后
     */
    public static void setImageText(Context context, TextView textView, int imageResId, String string, boolean isEnd) {
        Bitmap bitmap = BitmapFactory.decodeResource(context.getResources(), imageResId);
        ImageSpan imageSpan = new ImageSpan(context, bitmap);
        setImageText(textView, imageSpan, string, isEnd);
    }

    /**
     * 图片加入到文本前后
     *
     * @param textView  文本View
     * @param imageSpan 图片资源
     * @param stringRes 文字内容
     * @param isEnd     是否图片处于文本之后
     */
    private static void setImageText(TextView textView, ImageSpan imageSpan, String stringRes, boolean isEnd) {
        SpannableString spannableString = new SpannableString("icon");
        spannableString.setSpan(imageSpan, 0, 4, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        if (isEnd) {
            textView.setText(stringRes);
            textView.append(spannableString);
        } else {
            textView.setText(spannableString);
            textView.append(stringRes);
        }
    }

    /**
     * 改变文字内容显示
     *
     * @param context  上下文
     * @param textView 文本View
     * @param values   文本内容列表
     * @param map      Map：Key为文本内容列表index，value为文本所需要的style资源ID
     */
    private static void addSpan(Context context, TextView textView, List<String> values, Map<Integer, Integer> map) {
        Spannable spannable;
        for (int i = 0; i < values.size(); i++) {
            spannable = new SpannableString(values.get(i));
            Integer styleResId = map.get(i);
            if (styleResId != null) {
                TextAppearanceSpan span = new TextAppearanceSpan(context, styleResId);
                spannable.setSpan(span, 0, values.get(i).length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            }
            textView.append(spannable);
        }
    }
}
