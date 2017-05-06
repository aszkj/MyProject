/**
 * 文件名称：WebConstants.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.common;

import com.yilidi.o2o.core.SystemContext;

/**
 * 功能描述：web端使用的常量定义 作者：chenl
 * 
 * BugID: 修改内容：
 */
public final class WebConstants {
    private WebConstants() {
    }

    /**
     * 用户最后访问页面的记录标识符，用来记录用户最后访问的页面url
     */
    public static final String LAST_PAGE = "com.yilidi.o2o.lastpage";

    /**
     * 错误信息
     */
    public static final String ERROR_MSG = "errorMsg";

    /**
     * 登录超时提示信息
     */
    public static final String MSG_LOGIN_TIMEOUT = "登录超时，请重新登录！";

    /**
     * 没用权限提示信息
     */
    public static final String MSG_NO_AUTH = "您没有该访问权限，请联系管理员！";

    /**
     * 网站的根目录
     */
    public static final String REDIRECT_HOME = "/";

    /**
     * 网站的根目录
     */
    public static final String REDIRECT_LOGIN = "login";

    /**
     * 存储在cookie中的用户名称的key
     */
    public static final String USERNAME_IN_COOKIE = "O2O_OPEN_USERNAME";

    /**
     * 管理员用户
     */
    public static final int ADMIN_USER = 1;
    /** 验证码登录 ***/
    public static final int CAPTCHA_LOGIN_TYPE = 0;
    /** 密码登录 ***/
    public static final int PASSWORD_LOGIN_TYPE = 1;
    /** 安卓调用渠道 **/
    public static final String CALL_CHANNEL_TYPE_ANDROID = "1";
    /** IOS调用渠道 **/
    public static final String CALL_CHANNEL_TYPE_IOS = "2";
    /** MOBILE调用渠道 **/
    public static final String CALL_CHANNEL_TYPE_WEIXIN = "3";
    // ----------------- 买家获取验证码类型常量----------------------
    /** 注册-验证码 ***/
    public static final String BUYER_CAPTCHA_TYPE_REGISTER = "1";
    /** 登录-验证码 **/
    public static final String BUYER_CAPTCHA_TYPE_LOGIN = "2";
    /** 忘记密-码验证码 **/
    public static final String BUYER_CAPTCHA_TYPE_FORGET_PASSWORD = "3";
    /** 修改密码-验证码 **/
    public static final String BUYER_CAPTCHA_TYPE_MODIFY_PASSWORD = "4";
    /** 用户绑定-验证码 **/
    public static final String BUYER_CAPTCHA_TYPE_USERBINDING = "5";

    // ----------------- 卖家获取验证码类型常量----------------------
    /** 登录-验证码 **/
    public static final int SELLER_CAPTCHA_TYPE_LOGIN = 1;
    /** 忘记密码-码验证码 **/
    public static final int SELLER_CAPTCHA_TYPE_FORGET_PASSWORD = 2;
    /** 修改密码-验证码 **/
    public static final int SELLER_CAPTCHA_TYPE_MODIFY_PASSWORD = 3;

    // ----------------- 获取商品类型列表查询类型----------------------
    /** 查询部分商品类型 **/
    public static final String GET_PRODUCT_TYPE_PART = "1";
    /** 查询全部商品类型 **/
    public static final String GET_PRODUCT_TYPE_ALL = "2";

    // ----------------- 搜索商品排序类型----------------------
    /** 库存排序 **/
    public static final int PRODUCT_SORT_TYPE_REMAINCOUNT = 1;
    /** 价格排序 **/
    public static final int PRODUCT_SORT_TYPE_PRICE = 1;
    /** 销量排序 **/
    public static final int PRODUCT_SORT_TYPE_SALE = 2;

    // ----------------- 搜索商品排序模式----------------------
    /** 从低到高 **/
    public static final int PRODUCT_SORT_LOW_TO_HIGH = 1;
    /** 从高到低 **/
    public static final int PRODUCT_SORT_HIGH_TO_LOW = 2;

    // ----------------- 返回app端店铺状态----------------------
    /** 店铺正常营业 **/
    public static final String STORE_STATUS_OPEN = "1";
    /** 店铺暂停营业 **/
    public static final String STORE_STATUS_CLOSE = "0";

    // ----------------- 广告链接类型----------------------
    /** 没有链接 **/
    public static final int ADVERTISEMENT_LINK_TYPE_NONE = 0;
    /** 商品分类 **/
    public static final int ADVERTISEMENTLINKTYPE_PRODUCT_CLASS = 1;
    /** H5页面 **/
    public static final int ADVERTISEMENTLINKTYPE_H5PAGE = 2;
    /** 首页分类专区页面 **/
    public static final int ADVERTISEMENTLINKTYPE_HOMECLASSZONE = 3;
    /** 专题 **/
    public static final int ADVERTISEMENTLINKTYPE_THEME = 4;
    /** 活动 **/
    public static final int ADVERTISEMENTLINKTYPE_ACTIVITY = 5;
    /** 商品详情页 **/
    public static final int ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL = 6;
    /** 网站资讯、公告 **/
    public static final int ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT = 7;

    // ----------------- 销售专区更多链接类型----------------------
    /** 商品分类 **/
    public static final int MORE_TYPE_PRODUCT_CLASS = 1;
    /** 专区页面 **/
    public static final int MORE_TYPE_SALEZONE = 2;

    // ----------------- 调整购物车类型----------------------
    /** 减少购物车数量类型 **/
    public static final int ADJUSTMENT_CART_COUNT_REDUCE = 0;
    /** 增加购物车数量类型 **/
    public static final int ADJUSTMENT_CART_COUNT_INCREASE = 1;

    // ----------------- 产品状态标识类型----------------------
    /** 产品下架 **/
    public static final int PRODUCT_STATUS_OFF_SALE = 0;
    /** 产品上架 **/
    public static final int PRODUCT_STATUS_ON_SALE = 1;
    /** 产品已删除 **/
    public static final int PRODUCT_STATUS_OFF = 2;

    // ----------------- 是否用户已经收藏商品标识类型----------------------
    /** 未收藏 **/
    public static final int PRODUCT_FAVORITE_NO = 0;
    /** 已收藏 **/
    public static final int PRODUCT_FAVORITE_YES = 1;

    // ----------------- 获取商品一级类型----------------------
    /** 获取商品一级分类所传参数 **/
    public static final String PRODUCT_TYPE_TOP_CLASS = "TOP_CLASS";

    // ----------------- 会员类型----------------------
    /** 普通会员 **/
    public static final int MEMBER_TYPE_ORDINARY = 0;
    /** 铂金会员 **/
    public static final int MEMBER_TYPE_PT = 1;

    // ----------------- 查询订单列表类型----------------------
    /** 订单列表-全部订单 **/
    public static final int ORDERLIST_ALL = 0;
    /** 订单列表-待付款 **/
    public static final int ORDERLIST_FORPAY = 1;
    /** 订单列表-待确认(收货) **/
    public static final int ORDERLIST_FORRECEIVE = 2;
    /** 订单列表-已完成 **/
    public static final int ORDERLIST_FINISHED = 3;
    /** 订单列表-已退款 **/
    public static final int ORDERLIST_REFUND = 4;

    // ----------------- 订单评价状态类型----------------------
    /** 订单列表-已完成 **/
    public static final int APPRAISE_NO = 0;
    /** 订单列表-已退款 **/
    public static final int APPRAISE_YES = 1;

    // ----------------- 评价类型常量----------------------
    /** 全部评价 ***/
    public static final String ALL_EVALUATION_TYPE = "0";
    /** 好评 **/
    public static final String POSITIVE_EVALUATION_TYPE = "1";
    /** 中评 **/
    public static final String MODERATE_EVALUATION_TYPE= "2";
    /** 差评 **/
    public static final String NEGATIVE_EVALUATION_TYPE = "3";
    /** 有图 **/
    public static final String PHOTO_EVALUATION_TYPE = "4";
    
 // ----------------- 评价类型名称常量----------------------
    /** 全部评价 ***/
    public static final String ALL_EVALUATION_TYPENAME = "全部评价";
    /** 好评 **/
    public static final String POSITIVE_EVALUATION_TYPENAME = "好评";
    /** 中评 **/
    public static final String MODERATE_EVALUATION_TYPENAME = "中评";
    /** 差评 **/
    public static final String NEGATIVE_EVALUATION_TYPENAME = "差评";
    /** 有图 **/
    public static final String PHOTO_EVALUATION_TYPENAME = "有图";
    
 // ----------------- 评价类型CODES常量----------------------
    /** 全部评价 ***/
    public static final String ALL_EVALUATION_CODE = "1,,2,3,4,5";
    /** 好评 **/
    public static final String POSITIVE_EVALUATION_CODE = "4,5";
    /** 中评 **/
    public static final String MODERATE_EVALUATION_CODE = "2,3";
    /** 差评 **/
    public static final String NEGATIVE_EVALUATION_CODE = "1";
    /** 有图 **/
    public static final String PHOTO_EVALUATION_CODE = SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_YES;

    // ----------------- 订单列表类型(卖家)----------------------
    /** 订单列表-全部订单 **/
    public static final int SELLER_ORDERLIST_ALL = 0;
    /** 订单列表-待接单 **/
    public static final int SELLER_ORDERLIST_PAID = 1;
    /** 订单列表-待发货 **/
    public static final int SELLER_ORDERLIST_FORSEND = 2;
    /** 订单列表-待确认 **/
    public static final int SELLER_ORDERLIST_FORRECEIVE = 3;
    /** 订单列表-已完成 **/
    public static final int SELLER_ORDERLIST_FINISHED = 4;
    /** 订单列表-已取消 **/
    public static final int SELLER_ORDERLIST_CANCEL = 5;

    // ----------------- 产品上下架标识----------------------
    /** 全部 **/
    public static final int ENABLED_FLAG_ALL = 0;
    /** 上架 **/
    public static final int ENABLED_FLAG_ON_SALE = 1;
    /** 下架 **/
    public static final int ENABLED_FLAG_OFF_SALE = 2;
    // ----------------- 收藏产品的产品状态标识----------------------
    /** 下架 **/
    public static final int SALESTATUS_OFFSALE = 0;
    /** 上架 **/
    public static final int SALESTATUS_ONSALE = 1;
    /** 已删除 **/
    public static final int ENABLEDFLAG_OFF = 2;
    /** 已过期 **/
    public static final int EXIST_NO = 3;

    // ----------------- 调货单状态----------------------
    /** 调货单已提交 **/
    public static final int FLITTING_ORDER_STATUS_APPLY = 1;
    /** 微仓已审核 **/
    public static final int FLITTING_ORDER_STATUS_ACCEPTED = 2;
    /** 微仓审核不通过 **/
    public static final int FLITTING_ORDER_STATUS_ACCEPTREJECTED = 3;
    /** 微仓已发货 **/
    public static final int FLITTING_ORDER_STATUS_SEND = 4;
    /** 验货中 **/
    public static final int FLITTING_ORDER_STATUS_CHECKING = 5;
    /** 验货完毕 **/
    public static final int FLITTING_ORDER_STATUS_CHECKED = 6;
    /** 调货完成 **/
    public static final int FLITTING_ORDER_STATUS_FINISHED = 7;
    /** 调拨争议 **/
    public static final int FLITTING_ORDER_STATUS_FINISHREJECTED = 8;
    /** 平台客服已介入 **/
    public static final int FLITTING_ORDER_STATUS_ARBITRATE = 9;

    // ----------------- 调货单状态查询类型----------------------
    /** 未完成 **/
    public static final int FLITTING_ORDER_STATUS_QUERY_NO_FINISHED = 0;
    /** 已完成 **/
    public static final int FLITTING_ORDER_STATUS_QUERY_FINISHED = 1;

    // ----------------- 订单类型----------------------
    /** 普通订单 **/
    public static final int SALE_ORDER_TYPE_ORDINARY = 1;
    /** 其它订单 **/
    public static final int SALE_ORDER_TYPE_OTHER = 2;

    // ----------------- 订单配送方式----------------------
    /** 配送上门 **/
    public static final int SALE_ORDER_DELIVERY_MODE_DISTRIBUTION = 1;
    /** 自提 **/
    public static final int SALE_ORDER_DELIVERY_MODE_PICKUP = 2;

    /** 密码正则表达式 **/
    public static final String PASSWORD_PATTERN = "^[A-Za-z0-9]{6,16}$";

    // ----------------- 楼层链接类型----------------------
    /** 商品分类 **/
    public static final int FLOORLINKTYPE_PRODUCT_CLASS = 1;
    /** 专区页面 **/
    public static final int FLOORLINKTYPE_ZONE = 2;
    /** 楼层商品 **/
    public static final int FLOORLINKTYPE_PRODUCT = 3;

    // ----------------- 专题背景颜色----------------------
    /** 红 #E21855 **/
    public static final String THEMEBASECOLOR_RED = "red";
    /** 黄 #F6C71A **/
    public static final String THEMEBASECOLOR_YELLOW = "yellow";
    /** 浅蓝 #48acdd **/
    public static final String THEMEBASECOLOR_LIGHTBLUE = "lightBlue";
    /** 深蓝 #2271bf **/
    public static final String THEMEBASECOLOR_NAVYBLUE = "navyBlue";
    /** 湖蓝 #007dd5 **/
    public static final String THEMEBASECOLOR_LAKEBLUE = "lakeBlue";
    /** 绿 #349F40 **/
    public static final String THEMEBASECOLOR_GREEN = "green";

    // ----------------- 券类类型----------------------
    /** 优惠券 **/
    public static final int TICKET_TYPE_COUPON = 1;
    /** 抵用券 **/
    public static final int TICKET_TYPE_VOUCHER = 2;

    // ----------------- 品牌类型----------------------
    /** 热门品牌 **/
    public static final String BRAND_TYPE_HOT = "hot";
    /** 全部品牌 **/
    public static final String BRAND_TYPE_ALL = "all";

    // ----------------- 是否共享库存----------------------
    /** 非共享 **/
    public static final Integer SHAREFLAG_NO = 0;
    /** 共享 **/
    public static final Integer SHAREFLAG_YES = 1;
    
    // ----------------- 商品参加的活动类型----------------------
    /** 买赠 **/
    public static final int ACTIVITY_TYPE_BUYREWARD = 1;
    
 // ----------------- 商品参加的活动类型名称----------------------
    /** 买赠 **/
    public static final String ACTIVITY_TYPE_BUYREWARD_NAME = "买赠";
    
  // -----------------消息管理编码转换-------------------------
    /**
	 * 消息类型对应的值
	 */
	public static final int MESSAGETYPEONE = 1;
	public static final int MESSAGETYPETWO = 2;
	public static final int MESSAGETYPETHREE = 3;
	
	/**
	 * 跳转类型对应的值
	 */
	public static final int SKIPTYPEONE = 1;
	public static final int SKIPTYPETWO = 2;
	public static final int SKIPTYPETHREE = 3;

}
