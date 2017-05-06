package com.yilidi.o2o.core;

/**
 * 通用常量定义
 * 
 * @Description: (通用常量定义)
 * @author: chenlian
 * @date: 2016年5月25日 上午11:17:37
 */
public final class CommonConstants {

    private CommonConstants() {
    }

    /**
     * 分页大小
     */
    public static final int PAGE_SIZE = 10;

    /**
     * 分页函数的名称前缀
     */
    public static final String PAGE_PREFIX = "find";

    /**
     * 加密使用的密钥: YLDO2O
     */
    public static final String ENCRYPT_KEY = "YLDO2O";

    /**
     * 国家区域编码（中国）
     */
    public static final String NATION_AREA_CODE_CHINA = "100000";

    /**
     * 反斜杠
     */
    public static final String BACKSLASH = "/";

    /**
     * 中文顿号
     */
    public static final String CHINESE_SLASH = "、";

    /**
     * ISO 拉丁字母表 No.1，也叫作 ISO-LATIN-1
     */
    public static final String ISO_8859_1 = "ISO-8859-1";

    /**
     * 8 位 UCS 转换格式
     */
    public static final String UTF_8 = "UTF-8";

    /**
     * 16 位 UCS 转换格式，字节顺序由可选的字节顺序标记来标识
     */
    public static final String UTF_16 = "UTF-16";

    /**
     * 中文超大字符集
     */
    public static final String GBK = "GBK";

    /**
     * 文本类型
     */
    public static final String TEXT_TYPE_PLAIN = "text/plain";

    /**
     * html类型
     */
    public static final String TEXT_TYPE_HTML = "text/html";

    /**
     * 短时间格式 yyyy-MM-dd
     */
    public static final String DATE_FORMAT_DAY = "yyyy-MM-dd";

    /**
     * 长时间格式 yyyy-MM-dd HH:mm:ss
     */
    public static final String DATE_FORMAT_CURRENTTIME = "yyyy-MM-dd HH:mm:ss";

    /**
     * 精确到毫秒的时间字符串 yyyyMMddHHmmssSSS
     */
    public static final String DATE_FORMAT_MILLISECOND = "yyyyMMddHHmmssSSS";

    /**
     * 中文日期格式 yyyy年MM月dd日 HH时mm分ss秒
     */
    public static final String DATE_FORMAT_CHINESE = "yyyy年MM月dd日 HH时mm分ss秒";

    /**
     * 日期格式 HH:mm:ss
     */
    public static final String DATE_FORMAT_TIME = "HH:mm:ss";
    /**
     * 日期格式 HH:mm
     */
    public static final String DATE_FORMAT_HOURANDSECOND = "HH:mm";

    // --------------分隔符号-------------------
    /** 分号分隔符 **/
    public static final String DELIMITER_SEMICOLON = ";";
    /** 下划线分隔符 **/
    public static final String DELIMITER_UNDERLINE = "_";
    /** 乘号分隔符 **/
    public static final String DELIMITER_MULTIPLY = "x";
    /** 逗号 **/
    public static final String DELIMITER_COMMA = ",";
    /** 横线分割符 **/
    public static final String DELIMITER_HR = "-";
    /** 空格分割符 **/
    public static final String DELIMITER_SPACE = " ";
    /** 点分割符 **/
    public static final String DELIMITER_DOT = ".";
    /** 双引号分割符 **/
    public static final String DELIMITER_DQM = "\"";
    /** 单引号分割符 **/
    public static final String DELIMITER_SQM = "\'";
    /** 冒号 **/
    public static final String DELIMITER_COLON = ":";
    /** 井号 **/
    public static final String DELIMITER_POUND = "#";
    /** 波浪线 **/
    public static final String DELIMITER_WAVE_LINE = "~";
    /** 双竖线 **/
    public static final String DELIMITER_DOUBLE_VERTICAL_LINE = "\\|\\|";

    // --------------排序方式-------------------
    /** 默认排序 **/
    public static final String SORT_ORDER_DEFALUT = "ASC";
    /** 升序排序 **/
    public static final String SORT_ORDER_ASC = SORT_ORDER_DEFALUT;
    /** 降序排序 **/
    public static final String SORT_ORDER_DESC = "DESC";

    // --------------收货地址常量------------------
    /** 个人收货地址上限数量 **/
    public static final int CONSIGEE_ADDRESS_MAX_NUMBER = 10;

    // --------------请求参数名称------------------
    /** 全局请求参数名称 **/
    public static final String REQUEST_PARAMS_NAME = "params";

    // --------------Map中约定的Key------------------
    /** ID **/
    public static final String APPOINTED_KEY_ID = "id";
    /** NAME **/
    public static final String APPOINTED_KEY_NAME = "name";

    // --------------调用短信接口标识常量------------------
    /** 不调用短信接口标识 **/
    public static final String S_CALL_SMS_INTERFACE_FLAG_NO = "0";
    /** 调用短信接口标识 **/
    public static final String S_CALL_SMS_INTERFACE_FLAG_YES = "1";

    // ----------------- 配送时间说明----------------------
    /** 配送时间说明 **/
    public static final String DELIVERY_TIME_NOTE = "一小时闪电送达";
    /** 自提时间说明 **/
    public static final String PICKUP_TIME_NOTE = "营业时间内想提就提";

    // ----------------- 订单状态描述----------------------
    /** 等待买家付款状态描述 **/
    public static final String SALEORDERSTATUS_FORPAY_DESC = "请在{0}分钟内完成支付，超时将会自动取消订单";
    /** 等待卖家接单状态描述 **/
    public static final String SALEORDERSTATUS_PAID_DESC = "合伙人未接单订单自动取消";
    /** 等待卖家发货状态描述 **/
    public static final String SALEORDERSTATUS_FORSEND_DESC = "合伙人正在备货中";
    /** 等待买家收货状态描述 **/
    public static final String SALEORDERSTATUS_FORRECEIVE_DESC = "配送中，商家电话：{0}";
    /** 交易成功状态描述 **/
    public static final String SALEORDERSTATUS_FINISHED_DESC = "交易完成";
    /** 已评价状态描述 **/
    public static final String SALEORDERSTATUS_APPRAISE_DESC = "已评价";
    /** 退款中 态描述 **/
    public static final String SALEORDERSTATUS_REFUNDING_DESC = "预计2-5个工作日内退回至支付账户";
    /** 退款成功 态描述 **/
    public static final String SALEORDERSTATUS_REFUNDSUCCESS_DESC = "{0}  已退回至支付账户";
    /** 退款失败 态描述 **/
    public static final String SALEORDERSTATUS_REFUNDFAILURE_DESC = "订单退款失败";
    /** 交易取消状-卖家未接单 态描述 **/
    public static final String SALEORDERSTATUS_SELLERCANCEL_DESC = "已取消、退款中";
    /** 用户取消订单描述 **/
    public static final String SALEORDERSTATUS_BUYERCANCEL_DESC = "用户取消";
    /** 运营后台取消订单描述 **/
    public static final String SALEORDERSTATUS_OPERATORCANCEL_DESC = SALEORDERSTATUS_SELLERCANCEL_DESC;
    /** 系统自动取消-卖家未接单 订单描述 **/
    public static final String SALEORDERSTATUS_PAID_SYSTEMCANCEL_DESC = "合伙人未接单";
    /** 系统自动取消-买家未付款 订单描述 **/
    public static final String SALEORDERSTATUS_NOTPAID_SYSTEMCANCEL_DESC = "用户付款超时";
    /** 等待买家提货状态描述 **/
    public static final String SALEORDERSTATUS_FORPICKUP_DESC = "合伙人备货完成，请尽快到门店提货，商家电话：{0}";
    /** 买家已提货状态描述 **/
    public static final String SALEORDERSTATUS_PICKUP_DESC = "已从门店提货，交易完成，如有问题请拨打客服电话：{0}";
    /** 自提订单营业时间内未提货系统自动取消描述 **/
    public static final String SALEORDERSTATUS_OPERATORCANCEL_FORCEIVEER_PICKUP = "用户未按规定时间内提货,系统自动取消";

    // ----------------- APP静态H5页面代理路径----------------------
    /** APP静态H5页面代理路径 **/
    public static final String APP_STATIC_PAGE_PROXY_PATH = "/h5";

    /** 系统用户ID **/
    public static final int SYSTEM_USER_ID = -1;

    /** 默认客服热线 **/
    public static final String CUSTOMER_HOTLINE_DEFAULT = "400-1333-866";
    /**
     * 秒杀场次结束时间,单位:小时
     */
    public static final int SECKILLSCENE_ENDTIME_DEFAULT = 999;
    /**
     * YES字符串标识
     */
    public static final String STR_YES_FLAG = "Y";
    /**
     * NO字符串标识
     */
    public static final String STR_NO_FLAG = "N";

    // ----------------- 文件相关常量----------------------
    /**
     * 分享规则文件相对目录
     */
    public static final String USERSHARE_TO_WECHATFRIENDSCIRCLE_DEFAULT = "/pic/sharerule";
    /** 用户头像默认目录 **/
    public static final String USER_PIC_RELATIVE_PATH_DEFAULT = "/pic/user";
    /**
     * logo图片存放目录
     */
    public static final String COMPANY_LOGO_IAMGE_DIRECTORY_DEFAULT = "/pic/company";

    /** 用户默认头像名称 **/
    public static final String USERHEAD_IMAGE_NAME_DEFAULT = "/head_image_default.png";
    /** VIP用户头像遮罩背景名称 **/
    public static final String VIPUSERHEAD_SHADE_IMAGE_NAME_DEFAULT = "/head_image_vip.png";
    /** 普通用户头像遮罩背景名称 **/
    public static final String USERHEAD_SHADE_IMAGE_NAME_DEFAULT = "/head_image.png";
    /** 公司logo图片名称 **/
    public static final String COMPANY_IMAGE_NAME_70_DEFAULT = "/yld_logo_70.png";
    /** 缩略图后缀名称 **/
    public static final String THUMBNAILNAME_PREFFIX = "30_";

    // ----------------- 用户性别----------------------
    /** 1:男 **/
    public static final int GENDER_MALE = 1;
    /** 2:女 **/
    public static final int GENDER_FEMALE = 2;
}
