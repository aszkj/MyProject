package com.yldbkd.www.library.android.common;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * 价格工具类
 * Created by linghuxj on 15/10/10.
 */
public class MoneyUtils {

    public static String toPrice(Long price) {
        if (price == null) {
            return "0.00";
        }
        double yuan = price / 1000d;
        BigDecimal bg = new BigDecimal(yuan);
        DecimalFormat format = new DecimalFormat();
        format.applyPattern("#0.00");
        return format.format(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
    }

    public static Integer toIntPrice(Long price) {
        if (price == null) {
            return 0;
        }
        return (int) (price / 1000);
    }
}
