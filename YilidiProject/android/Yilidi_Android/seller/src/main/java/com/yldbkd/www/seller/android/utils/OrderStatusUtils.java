package com.yldbkd.www.seller.android.utils;

/**
 * 订单状态工具
 * <p/>
 * Created by linghuxj on 16/6/21.
 */
public class OrderStatusUtils {

    public static final int NOT_PAY_CODE = 1;
    public static final int WAIT_RECEIVE_CODE = 2;
    public static final int NOT_SEND_CODE = 3;
    public static final int SENDING_CODE = 4;
    public static final int FINISHED_CODE = 5;
    public static final int EVALUATED_CODE = 6;
    public static final int CANCELED_CODE = 7;
    public static final int REFUNDING_CODE = 8;
    public static final int REFUNDED_CODE = 9;

    private static final String NOT_PAY_NAME = "未付款";
    private static final String WAIT_RECEIVE_NAME = "待接单";
    private static final String NOT_SEND_NAME = "未发货";
    private static final String SENDING_NAME = "配送中";//待提货
    private static final String FINISHED_NAME = "已完成";//已提货
    private static final String EVALUATED_NAME = "已评价";
    private static final String CANCELED_NAME = "已取消";
    private static final String REFUNDING_NAME = "退款中";
    private static final String REFUNDED_NAME = "退款完成";

    public static String getName(int code) {
        switch (code) {
            case NOT_PAY_CODE:
                return NOT_PAY_NAME;
            case WAIT_RECEIVE_CODE:
                return WAIT_RECEIVE_NAME;
            case NOT_SEND_CODE:
                return NOT_SEND_NAME;
            case SENDING_CODE:
                return SENDING_NAME;
            case FINISHED_CODE:
                return FINISHED_NAME;
            case EVALUATED_CODE:
                return EVALUATED_NAME;
            case CANCELED_CODE:
                return CANCELED_NAME;
            case REFUNDING_CODE:
                return REFUNDING_NAME;
            case REFUNDED_CODE:
                return REFUNDED_NAME;
        }
        return "";
    }
}
