package com.yldbkd.www.library.android.common;

import android.text.TextUtils;
import android.util.Base64;

/**
 * Base64编码工具类
 * <p/>
 * Created by linghuxj on 15/10/8.
 */
public class Base64Utils {

    /**
     * Base64编码
     *
     * @param strEncode 待编码的字符串
     * @return 如果字符为空或null，则返回"" ，否则返回编码结果
     */
    public static String base64Encode(String strEncode) {
        if (TextUtils.isEmpty(strEncode)) {
            return "";
        } else {
            return Base64.encodeToString(strEncode.getBytes(), Base64.DEFAULT);
        }
    }

    /**
     * Base64解码
     *
     * @param strDecode 待解码的字符串
     * @return 如果字符为空或null，则返回"" ，否则返回解码结果
     */
    public static String base64Decode(String strDecode) {
        if (TextUtils.isEmpty(strDecode)) {
            return "";
        } else {
            return new String(Base64.decode(strDecode.getBytes(), Base64.DEFAULT));
        }
    }
}
