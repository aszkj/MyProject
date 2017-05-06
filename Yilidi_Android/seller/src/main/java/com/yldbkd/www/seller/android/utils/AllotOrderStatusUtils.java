package com.yldbkd.www.seller.android.utils;

/**
 * 订单状态工具
 * <p/>
 * Created by linghuxj on 16/6/21.
 */
public class AllotOrderStatusUtils {

    public static final int APPLY_CODE = 1;
    public static final int ACCEPTED_CODE = 2;
    public static final int ACCEPT_REJECTED_CODE = 3;
    public static final int SEND_CODE = 4;
    public static final int CHECKING_CODE = 5;
    public static final int CHECKED_CODE = 6;
    public static final int FINISHED_CODE = 7;
    public static final int FINISH_REJECTED_CODE = 8;
    public static final int ARBITRATE_CODE = 9;

    private static final String APPLY_NAME = "已提交";
    private static final String ACCEPTED_NAME = "已审核";
    private static final String ACCEPT_REJECTED_NAME = "审核不通过";
    private static final String SEND_NAME = "已发货";
    private static final String CHECKING_NAME = "验货中";
    private static final String CHECKED_NAME = "验货完毕";
    private static final String FINISHED_NAME = "调货完成";
    private static final String FINISH_REJECTED_NAME = "调拨争议";
    private static final String ARBITRATE_NAME = "平台客服已介入";

    public static String getName(int code) {
        switch (code) {
            case APPLY_CODE:
                return APPLY_NAME;
            case ACCEPTED_CODE:
                return ACCEPTED_NAME;
            case ACCEPT_REJECTED_CODE:
                return ACCEPT_REJECTED_NAME;
            case SEND_CODE:
                return SEND_NAME;
            case CHECKING_CODE:
                return CHECKING_NAME;
            case CHECKED_CODE:
                return CHECKED_NAME;
            case FINISHED_CODE:
                return FINISHED_NAME;
            case FINISH_REJECTED_CODE:
                return FINISH_REJECTED_NAME;
            case ARBITRATE_CODE:
                return ARBITRATE_NAME;
        }
        return "";
    }
}
