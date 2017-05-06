package com.yldbkd.www.seller.android.utils;

/**
 * 详细数据信息工具类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class Constants {

    /**
     * 应用Tag
     */
    public static final String TAG = "yldbkdSeller";
    /**
     * 是否开启debug模式
     */
    public static final String DEBUG = "1";
    /**
     * 应用渠道
     */
    public static final String CHANNEL = "1";
    /**
     * 分页页面数据大小默认值
     */
    public static final Integer PAGE_SIZE = 12;
    /**
     * 编码类型
     */
    public static final String ENCODE_UTF8 = "utf-8";
    /**
     * http返回数据类型
     */
    public static final String MIME_TYPE_HTML = "text/html";
    /**
     * 弹出框占界面的宽度比例
     */
    public static final float DIALOG_WIDTH_RATE = 0.75F;
    /**
     * 弹出框占界面的宽度比例
     */
    public static final float DIALOG_HEIGHT_RATE = 0.75F;
    /**
     * 价格符号
     */
    public static final String MONEY_FLAG = "¥";
    /**
     * 价格加符号
     */
    public static final String MONEY_PLUS_FLAG = "+";
    /**
     * 价格减符号
     */
    public static final String MONEY_MINUS_FLAG = "-";
    /**
     * 时间格式化
     */
    public static final String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    /**
     * 日期格式化
     */
    public static final String DAY_FORMAT = "yyyy-MM-dd";
    /**
     * 数量符号
     */
    public static final String COUNT_FLAG = "x";

    public static final String WX_APP_ID = "";
    /**
     * 查询第一级分类查询参数值
     */
    public static final String TOP_CLASS = "TOP_CLASS";

    /**
     * 页面跳转回调参数信息,startActivityForResult
     */
    public static class RequestCode {
        /**
         * 登录回调Code
         */
        public static final Integer LOGIN_CODE = 0x80;
        /**
         * 二维码扫描Code
         */
        public static final Integer SCAN_CODE = 0x81;
        /**
         * 调货单详情Code
         */
        public static final Integer ALLOT_ORDER_DETAIL_CODE = 0x82;
    }


    /**
     * 页面之间传递参数的Key名称
     */
    public static class BundleName {
        /**
         * 位置
         */
        public static final String POSITION = "position";
        /**
         * 是否是普通订单类型
         */
        public static final String IS_NORMAL_ORDER = "isNormalOrder";
        /**
         * 订单状态
         */
        public static final String ORDER_STATUS = "orderStatus";
        /**
         * 订单编号
         */
        public static final String ORDER_NO = "orderNo";
        /**
         * 订单收货码
         */
        public static final String RECEIVE_NO = "receiveNo";
        /**
         * 订单详细信息数据
         */
        public static final String ORDER_DETAIL_INFO = "orderDetailInfo";
        /**
         * 订单返款详细信息数据
         */
        public static final String ORDER_DETAIL_BACK_INFO = "orderDetailBackInfo";
        /**
         * 调货单确认信息数据
         */
        public static final String ALLOT_ORDER_CONFIRM_INFO = "allotOrderConfirmInfo";
        /**
         * 调货单生成成功信息
         */
        public static final String ALLOT_ORDER_BASE_INFO = "allotOrderBaseInfo";
        /**
         * 调货单类型：已完成和未完成
         */
        public static final String ALLOT_ORDER_STATUS_TYPE = "allotOrderStatusType";
        /**
         * 调货单编号
         */
        public static final String ALLOT_ORDER_NO = "allotOrderNo";
        /**
         * 调货单详情
         */
        public static final String ALLOT_ORDER_DETAIL_INFO = "allotOrderDetailInfo";
        /**
         * 调货单状态列表数据
         */
        public static final String ALLOT_ORDER_DETAIL_RECORD_INFO = "allotOrderDetailRecordInfo";
        /**
         * 搜索关键字
         */
        public static final String SEARCH_KEYWORD = "searchKeyword";
        /**
         * 订单详情的收货信息
         */
        public static final String ORDER_DETAIL_CONSIGNEE_INFO = "orderDetailConsigneeInfo";
        /**
         * 订单详情收货码标志
         */
        public static final String ORDER_DETAIL_RECEIVE_FLAG = "orderDetailReceiveFlag";
        /**
         * 网页展示地址URL
         */
        public static final String WEB_URL = "webUrl";
        /**
         * 标题
         */
        public static final String TITLE = "title";
        /**
         * 是否是系统推送通知
         */
        public static final String IS_NOTIFICATION = "isNotification";
        /**
         * H5页面由外部传递Url
         */
        public static final String H5URL = "h5Url";
        /**
         * 分类数据
         */
        public static final String CLASSITY_DATA = "classityData";
        /**
         * 选中分类
         */
        public static final String CLASSITY_CHECKED = "classityChecked";
        /**
         * 品牌名称
         */
        public static final String BRAND_NAME = "brandName";
        /**
         * 品牌Code
         */
        public static final String BRAND_CODE = "brandCode";
    }

    /**
     * Handler的传递参数信息
     */
    public static class HandlerCode {
        public static final int REFRESH_COMPLETE = 0x01;
        public static final int PRODUCT_PLUS = 0x02;
        public static final int PRODUCT_MINUS = 0x03;

        public static final int PRODUCT_ONLINE = 0x04;
        public static final int PRODUCT_OFFLINE = 0x05;

        public static final int PROGRESS_SHOW = 0x24;
        public static final int PROGRESS_HIDE = 0x25;

        //Cordova
        public static final int CORDOVA_BACK = 0x26;
        //分类
        public static final int CLASSIFY_SECOND = 0x30;
        public static final int CLASSIFY_THIRD = 0x31;
    }

    /**
     * 登录方式
     */
    public static class LoginType {
        public static final int BY_PASSWORD = 1;
        public static final int BY_CHECK_CODE = 0;
    }

    /**
     * 验证码发送类型
     */
    public static class SendCheckCodeType {
        public static final int LOGIN_TYPE = 1;
        public static final int FORGET_PWD_TYPE = 2;
        public static final int MODIFY_PWD_TYPE = 3;
    }

    /**
     * 在线支付类型
     */
    public static class OnlinePayType {
        public static final int ALI_PAY = 2;
        public static final int WX_PAY = 1;
    }

    /**
     * 支付类型
     */
    public static class PayTypeName {
        public static final String ALI_PAY_NAME = "支付宝";
        public static final String WX_PAY_NAME = "微信支付";
    }

    /**
     * VIP等级
     */
    public static class VIP_LEVEL {
        public static final int NORMAL = 0; // 非铂金会员
        public static final int PLATINUM = 1; // 铂金会员
        public static final int PLATINUM_PAUSE = 2; // 铂金体验会员
    }

    /**
     * 商品状态
     */
    public static class PRODUCT_STATUS {
        public static final int OFFLINE = 0; // 下架
        public static final int ONLINE = 1; // 上架
    }

    /**
     * 店铺状态
     */
    public static class STORE_STATUS {
        public static final int PAUSE = 0; // 暂停营业
        public static final int NORMAL = 1; // 正常营业
    }

    /**
     * 订单状态
     */
    public static class ORDER_STATUS {
        public static final Integer WAIT_RECEIVE = 1;
        public static final Integer WAIT_SEND = 2;
        public static final Integer WAIT_CONFIRM = 3;
        public static final Integer FINISHED = 4;
        public static final Integer CANCELED = 5;
    }

    /**
     * 调货单状态
     */
    public static class ALLOT_ORDER_STATUS {
        public static final Integer SUBMITED = 1; // 已提交
        public static final Integer AUDITED = 2; // 已审核
        public static final Integer SENDED = 3; // 已发货
        public static final Integer CHECKING = 4; // 验货中
        public static final Integer CHECKED = 5; // 已验货
        public static final Integer FINISHED = 6; // 已完成
        public static final Integer CANCELED = 6; // 已取消
    }

    /**
     * 返回规定的URL地址信息
     */
    public static class URL_TYPE {
        public static final int ABOUT_US = 1;
        public static final int FAQ = 2;
    }

    /**
     * 配送方式
     */
    public static class DeliveryMode {
        public static final int DELIVER_GOODS = 1; // 送货上门
        public static final int PICK_UP = 2; // 自提
    }

    /**
     * cordova
     */
    public static class CordovaPlugin {
        public static final String OPERATIONBACK = "backPressed";
    }

    /**
     * 品类查询类型
     */
    public static class ClassType {
        //查询第一级的类型
        public static final String TOP_CLASS = "TOP_LEVEL_CLASS";
    }

    public static class BrandType {
        /**
         * 所有品牌
         **/
        public static final String ALL = "all";
        /**
         * 热门品牌
         **/
        public static final String HOT = "hot";
    }
}
