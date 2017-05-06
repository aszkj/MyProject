/**
 * 文件名称：SessionUtils.java
 * 
 * 描述：session操作工具类
 * 
 *
 */
package com.yilidi.o2o.common.utils;

import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.yilidi.o2o.appvo.seller.system.CaptchaSessionModel;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.buyer.order.OrderSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.order.ShopCartItemSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.BuyerCaptchaSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.sessionmodel.seller.user.SellerSessionModel;

/**
 * 功能描述：Session工具类<br>
 * 作者： chenb<br>
 * 
 * BugID:<br>
 * 修改内容：
 */
public final class SessionUtils {

    private SessionUtils() {
    }

    protected static final Logger LOGGER = Logger.getLogger(SessionUtils.class);

    /** 买家用户SESSION KEY **/
    private static final String BUYER_USER_SESSION_KEY = "BUYER_USER_SESSION_KEY";
    /** 买家验证码session key前缀 **/
    private static final String BUYER_CAPTCHA_SESSION_KEY = "BUYER_CAPTCHA_SESSIONK_KEY.";
    /** 买家校验验证码通过session key 前缀 **/
    private static final String BUYER_CAPTCHA_CHECK_SESSION_KEY = "BUYER_CAPTCHA_CHECK_SESSION_KEY";
    /** 订单结算订单商品列表信息缓存session key **/
    private static final String SETTLEMENT_ORDER_ITEM_SESSION_KEY = "SETTLEMENT_ORDER_ITEM_SESSION_KEY";
    /** 购物车商品列表信息缓存session key **/
    private static final String SHOPCART_ITEM_SESSION_KEY = "SHOPCART_ITEM_SESSION_KEY";
    /** 卖家用户SESSION KEY **/
    private static final String SELLER_USER_SESSION_KEY = "SELLER_USER_SESSION_KEY";
    /** 卖家验证码session key前缀 **/
    private static final String SELLER_CAPTCHA_SESSION_KEY = "SELLER_CAPTCHA_SESSIONK_KEY.";
    /** 卖家校验验证码通过session key 前缀 **/
    private static final String SELLER_CAPTCHA_CHECK_SESSION_KEY = "SELLER_CAPTCHA_CHECK_SESSION_KEY.";

    /**
     * 设置买家用户session
     * 
     * @param userSessionModel
     *            用户session
     */
    public static void setBuyerUserSession(UserSessionModel userSessionModel) {
        YiLiDiSession sessionOld = YiLiDiSessionHolder.getSession();
        sessionOld.invalidate();
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(BUYER_USER_SESSION_KEY, userSessionModel);
    }

    /**
     * 获取买家用户Session
     * 
     * @return UserSessionModel
     */
    public static UserSessionModel getBuyerUserSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (UserSessionModel) session.getAttribute(BUYER_USER_SESSION_KEY);
    }

    /**
     * 移除买家用户session
     * 
     */

    public static void removeBuyerUserSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.invalidate();
    }

    /**
     * 设置买家验证码SESSION
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     * @param captchaSession
     *            验证码session封装对象
     */
    public static void setBuyerCaptchaSession(String mobile, String type, BuyerCaptchaSessionModel captchaSession) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(generateCaptchaRelatedSessionKey(BUYER_CAPTCHA_SESSION_KEY, mobile, type), captchaSession);
    }

    /**
     * 获取买家验证码封装类
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     * @return String
     */
    public static BuyerCaptchaSessionModel getBuyerCaptchaSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (BuyerCaptchaSessionModel) session
                .getAttribute(generateCaptchaRelatedSessionKey(BUYER_CAPTCHA_SESSION_KEY, mobile, type));
    }

    /***
     * 移除买家验证码Session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     */
    public static void removeBuyerCaptchaSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(generateCaptchaRelatedSessionKey(BUYER_CAPTCHA_SESSION_KEY, mobile, type));
    }

    /**
     * 设置买家验证码校验通过session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            登录类型
     */
    public static void setBuyerCaptchaCheckSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(generateCaptchaRelatedSessionKey(BUYER_CAPTCHA_CHECK_SESSION_KEY, null, type), mobile);
    }

    /**
     * 获取买家验证码校验通过session
     * 
     * @return String
     */
    public static String getBuyerCaptchaCheckSession(String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (String) session.getAttribute(generateCaptchaRelatedSessionKey(BUYER_CAPTCHA_CHECK_SESSION_KEY, null, type));
    }

    /**
     * 删除买家验证码校验通过session
     * 
     */
    public static void removeBuyerCaptchaCheckSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(BUYER_CAPTCHA_CHECK_SESSION_KEY);
    }

    /**
     * 设置卖家用户session
     * 
     * @param sellerSessionModel
     *            卖家用户session
     */
    public static void setSellerUserSession(SellerSessionModel sellerSessionModel) {
        YiLiDiSession currentSession = YiLiDiSessionHolder.getSession();
        currentSession.invalidate();
        YiLiDiSession newSession = YiLiDiSessionHolder.getSession();
        newSession.setAttribute(SELLER_USER_SESSION_KEY, sellerSessionModel);
    }

    /**
     * 获取卖家用户Session
     * 
     * @return SellerSessionModel
     */
    public static SellerSessionModel getSellerUserSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (SellerSessionModel) session.getAttribute(SELLER_USER_SESSION_KEY);
    }

    /**
     * 移除卖家用户session
     * 
     */
    public static void removeSellerUserSessionModel() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.invalidate();
    }

    /**
     * 
     * 设置卖家验证码Session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     * @param captchaSessionModel
     */
    public static void setSellerCaptchaSession(String mobile, String type, CaptchaSessionModel captchaSessionModel) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_SESSION_KEY, mobile, type),
                captchaSessionModel);
    }

    /**
     * 获取卖家验证码Session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     * @return CaptchaSessionModel
     */
    public static CaptchaSessionModel getSellerCaptchaSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (CaptchaSessionModel) session
                .getAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_SESSION_KEY, mobile, type));
    }

    /**
     * 移除卖家验证码Session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     */
    public static void removeSellerCaptchaSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_SESSION_KEY, mobile, type));
    }

    /**
     * 
     * 设置卖家验证码校验通过Session
     * 
     * @param mobile
     *            手机号码
     * @param type
     *            验证码类型
     */
    public static void setSellerCaptchaCheckSession(String mobile, String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_CHECK_SESSION_KEY, null, type), mobile);
    }

    /**
     * 获取卖家验证码校验通过Session
     * 
     * @param type
     *            验证码类型
     * @return String
     */
    public static String getSellerCaptchaCheckSession(String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (String) session.getAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_CHECK_SESSION_KEY, null, type));
    }

    /**
     * 移除卖家验证码校验通过Session
     * 
     * @param type
     *            验证码类型
     */
    public static void removeSellerCaptchaCheckSession(String type) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(generateCaptchaRelatedSessionKey(SELLER_CAPTCHA_CHECK_SESSION_KEY, null, type));
    }

    /**
     * 订单结算-商品列表信息缓存
     * 
     * @param orderSessionModel
     *            商品列表信息
     */
    public static void setSettlementOrderSession(OrderSessionModel orderSessionModel) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(SETTLEMENT_ORDER_ITEM_SESSION_KEY, orderSessionModel);
    }

    /**
     * 获取订单结算-商品列表信息缓存
     * 
     * @return OrderSessionModel
     */
    public static OrderSessionModel getSettlementOrderSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        OrderSessionModel orderSessionModel = (OrderSessionModel) session.getAttribute(SETTLEMENT_ORDER_ITEM_SESSION_KEY);
        return orderSessionModel;
    }

    /**
     * 移除订单结算-商品列表信息缓存
     * 
     */
    public static void removeSettlementOrderSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(SETTLEMENT_ORDER_ITEM_SESSION_KEY);
    }

    /**
     * 订单结算-商品列表信息缓存
     * 
     * @param shopCartItemSessionModels
     *            购物车商品列表信息
     */
    public static void setShopCartItemSession(List<ShopCartItemSessionModel> shopCartItemSessionModels) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(SHOPCART_ITEM_SESSION_KEY, shopCartItemSessionModels);
    }

    /**
     * 获取订单结算-商品列表信息缓存
     * 
     * @return OrderSessionModel
     */
    public static List<ShopCartItemSessionModel> getShopCartItemSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        List<ShopCartItemSessionModel> shopCartItemSessionModels = (List<ShopCartItemSessionModel>) session
                .getAttribute(SHOPCART_ITEM_SESSION_KEY);
        return shopCartItemSessionModels;
    }

    /**
     * 移除购物车商品列表信息缓存
     * 
     */
    public static void removeShopCartItemSession() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.removeAttribute(SHOPCART_ITEM_SESSION_KEY);
    }

    /**
     * 移除购物车商品列表信息缓存
     * 
     */
    public static void removeShopCartItemSession(List<Integer> saleProductIds) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        if (ObjectUtils.isNullOrEmpty(saleProductIds)) {
            session.removeAttribute(SHOPCART_ITEM_SESSION_KEY);
        } else {
            List<ShopCartItemSessionModel> shopCartItemSessionModels = getShopCartItemSession();
            if (!ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
                for (Iterator<ShopCartItemSessionModel> iterator = shopCartItemSessionModels.iterator(); iterator
                        .hasNext();) {
                    ShopCartItemSessionModel shopCartItemSessionModel = iterator.next();
                    if (saleProductIds.contains(shopCartItemSessionModel.getSaleProductId())) {
                        iterator.remove();
                    }
                }
            }
            setShopCartItemSession(shopCartItemSessionModels);
        }
    }

    /**
     * 获取验证码session key
     * 
     * @return String
     */
    private static String generateCaptchaRelatedSessionKey(String preffix, String mobile, String type) {
        StringBuffer buffer = new StringBuffer();
        if (!StringUtils.isEmpty(preffix)) {
            buffer.append(preffix);
        }
        if (!StringUtils.isEmpty(mobile)) {
            buffer.append(mobile).append(CommonConstants.DELIMITER_DOT);
        }
        if (!StringUtils.isEmpty(type)) {
            buffer.append(type).append(CommonConstants.DELIMITER_DOT);
        }
        if (buffer.length() <= 0) {
            throw new IllegalArgumentException("params can not be null");
        }
        if (buffer.length() > 1) {
            return EncryptUtils.base64Encode(buffer.substring(0, buffer.length() - 1));
        }
        return EncryptUtils.base64Encode(buffer.substring(0, 1));
    }
}
