package com.yldbkd.www.library.android.common;

import android.text.TextUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by HP on 2015/10/26.
 */
public class CheckUtils {


    /**
     * 判断是否是电话号码
     *
     * @param mobile
     * @return
     */
    public static boolean isMobileNO(String mobile) {
        return Pattern.compile("^1[0-9]{10}$").matcher(mobile).matches(); // 验证手机号
    }

    /**
     * 校验密码：6至16位任意字符且不含空格
     *
     * @param pwd
     * @return
     */
    public static boolean checkPwd(String pwd) {
        String reg = "^[^\\s]{6,16}$";
        if (pwd.matches(reg)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 注册修改密码：6至16位数字加字母
     *
     * @param pwd
     * @return
     */
    public static boolean checkRegiPwd(String pwd) {
        String reg = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        if (pwd.matches(reg)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 修改昵称：4至20位中英文数字加_ -
     *
     * @param name
     * @return
     */
    public static boolean checkChineseName(String name) {
        String reg = "[\\u4e00-\\u9fa5a-zA-Z0-9\\-_]{4,20}";
        if (name.matches(reg)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 校验验证码
     *
     * @param checkCode
     * @return
     */
    public static boolean checkCode(String checkCode) {
        if (TextUtils.isEmpty(checkCode)) {
            return false;
        }
        if (checkCode.length() != 4) {
            return false;
        }
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(checkCode);
        if (!isNum.matches()) {
            return false;
        }
        return true;
    }

    /**
     * 判断字符串中是否包含特殊字符
     *
     * @param data
     * @return
     */
    public static boolean isConSpeCharacters(String data) {
        if (TextUtils.isEmpty(data)) {
            return false;
        }
        String string = new String(data.toCharArray());
        string = string.replaceAll("[a-z]*[A-Z]*\\d*-*_*\\s*", "");
        System.out.println(string);
        if (string.length() == 0) {
            //不包含特殊字符
            return false;
        } else {
            return !isAllChinese(string);
        }
    }

    /**
     * 中文、英文、英文标点(, . ! ' " ( ) + - ? : ;)、数字
     *
     * @param data
     * @return
     */
    public static boolean isSpecialCharacters(String data) {
        if (TextUtils.isEmpty(data)) {
            return false;
        }
        String string = new String(data.toCharArray());
        string = string.replaceAll("[a-z]*[A-Z]*\\d*-*_*\\s*,*\\.*!*'*\"*\\(*\\)*\\+*\\-*\\?*:*;*", "");
        System.out.println(string);
        if (string.length() == 0) {
            //不包含特殊字符
            return false;
        } else {
            return !isAllChinese(string);
        }
    }

    /**
     * 过滤表情和特殊字符
     *
     * @param data
     * @return
     */
    public static String filterSpecialCharacter(String data) {
        if (TextUtils.isEmpty(data)) {
            return null;
        }
        String reg = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]|[\\s~·`@#￥$%^……&*\\-—【\\[\\]】｛{}｝\\|《<》>/]";
        return Pattern.compile(reg, Pattern.UNICODE_CASE | Pattern.CASE_INSENSITIVE).matcher(data).replaceAll("");
    }

    // 根据Unicode编码完美的判断中文汉字和符号
    private static boolean isChinese(char c) {
        Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
        if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B
                || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
                || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS
                || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION) {
            return true;
        }
        return false;
    }

    // 完整的判断中文汉字和符号
    public static boolean isAllChinese(String strName) {
        char[] ch = strName.toCharArray();
        for (int i = 0; i < ch.length; i++) {
            char c = ch[i];
            if (!isChinese(c)) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        //        String[] strArr = new String[]{"www.micmiu.com", "!@#$%^&*()_+{}[]|\"'?/:;<>,.",
        //                "！￥……（）——：；“”‘'《》，。？、", "不要啊", "やめて", "韩佳人", "???",
        //                "\uD83D\uDE0F\uD83D\uDE23\uD83D\uDE16\uD83D\uDE14\uD83D\uDE2A好看不v"};
        //        for (String str : strArr) {
        //            System.out.println("===========> 测试字符串：" + str);
        //            System.out.println("Unicode判断结果 ：" + isChinese(str));
        //            System.out.println("详细判断列表：");
        //            char[] ch = str.toCharArray();
        //            for (int i = 0; i < ch.length; i++) {
        //                char c = ch[i];
        //                System.out.println(c + " --> " + (isChinese(c) ? "是" : "否"));
        //            }
        //        }
        String string = "\uD83D\uDE0F\uD83D\uDE23\uD83D\uDE16\uD83D\uDE14\uD83D\uDE2A";
        System.out.println(isConSpeCharacters(string));
    }
}
