package com.yilidi.o2o.core.connect.wechat.api;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.connect.wechat.cache.IAccessTokenCache;
import com.yilidi.o2o.core.connect.wechat.cache.IJsapiTicketCache;
import com.yilidi.o2o.core.connect.wechat.javabean.AccessToken;
import com.yilidi.o2o.core.connect.wechat.javabean.JsapiTicket;
import com.yilidi.o2o.core.connect.wechat.utils.PaymentUtils;
import com.yilidi.o2o.core.connect.wechat.utils.RetryUtils;
import com.yilidi.o2o.core.utils.HttpUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 网页授权获取 access_token API
 */
public class AccessTokenApi {

    private static final Logger LOGGER = Logger.getLogger(AccessTokenApi.class);

    private static String url = "https://api.weixin.qq.com/sns/oauth2/access_token";
    private static String authorize_uri = "https://open.weixin.qq.com/connect/oauth2/authorize";
    private static String qrconnect_url = "https://open.weixin.qq.com/connect/qrconnect";
    private static final String SDK_ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";
    private static final String SDK_JSAPI_TICKET_URL = "https://api.weixin.qq.com/cgi-bin/ticket/getticket";
    private static final String AUTHORIZE_URI_PUBLISH = "http://m.yldbkd.com/wx-code.html";

    /**
     * 生成Authorize链接
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @param snsapiBase
     *            snsapi_base（不弹出授权页面，只能拿到用户openid）snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
     * @return url
     */
    public static String getAuthorizeURL(String appId, String redirect_uri, boolean snsapiBase) {
        return getAuthorizeURL(appId, redirect_uri, null, snsapiBase);
    }

    /**
     * 生成Authorize链接(通过正式环境)
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @param snsapiBase
     *            snsapi_base（不弹出授权页面，只能拿到用户openid）snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
     * @return url
     */
    public static String getAuthorizeURLThroughPublish(String appId, String redirect_uri, boolean snsapiBase) {
        return getAuthorizeURLThroughPublish(appId, redirect_uri, null, snsapiBase);
    }

    /**
     * 生成Authorize链接
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @param state
     *            重定向后会带上state参数，开发者可以填写a-zA-Z0-9的参数值，最多128字节
     * @param snsapiBase
     *            snsapi_base（不弹出授权页面，只能拿到用户openid）snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
     * @return url
     */
    public static String getAuthorizeURL(String appId, String redirectUri, String state, boolean snsapiBase) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("appid", appId);
        params.put("response_type", "code");
        params.put("redirect_uri", redirectUri);
        // snsapi_base（不弹出授权页面，只能拿到用户openid）
        // snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
        if (snsapiBase) {
            params.put("scope", "snsapi_base");
        } else {
            params.put("scope", "snsapi_userinfo");
        }
        if (StringUtils.isBlank(state)) {
            params.put("state", "wx#wechat_redirect");
        } else {
            params.put("state", state.concat("#wechat_redirect"));
        }
        String para = PaymentUtils.packageSign(params, false);
        return authorize_uri + "?" + para;
    }

    /**
     * 生成Authorize链接(通过正式环境)
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @param state
     *            重定向后会带上state参数，开发者可以填写a-zA-Z0-9的参数值，最多128字节
     * @param snsapiBase
     *            snsapi_base（不弹出授权页面，只能拿到用户openid）snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
     * @return url
     */
    public static String getAuthorizeURLThroughPublish(String appId, String redirectUri, String state, boolean snsapiBase) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("appid", appId);
        params.put("response_type", "code");
        params.put("redirect_uri", redirectUri);
        // snsapi_base（不弹出授权页面，只能拿到用户openid）
        // snsapi_userinfo（弹出授权页面，这个可以通过 openid 拿到昵称、性别、所在地）
        if (snsapiBase) {
            params.put("scope", "snsapi_base");
        } else {
            params.put("scope", "snsapi_userinfo");
        }
        if (StringUtils.isBlank(state)) {
            params.put("state", "wx#wechat_redirect");
        } else {
            params.put("state", state.concat("#wechat_redirect"));
        }
        String para = PaymentUtils.packageSign(params, false);
        return AUTHORIZE_URI_PUBLISH + "?" + para;
    }

    /**
     * 生成网页二维码授权链接
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @return url
     */
    public static String getQrConnectURL(String appId, String redirect_uri) {
        return getQrConnectURL(appId, redirect_uri, null);
    }

    /**
     * 生成网页二维码授权链接
     * 
     * @param appId
     *            应用id
     * @param redirect_uri
     *            回跳地址
     * @param state
     *            重定向后会带上state参数，开发者可以填写a-zA-Z0-9的参数值，最多128字节
     * @return url
     */
    public static String getQrConnectURL(String appId, String redirect_uri, String state) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("appid", appId);
        params.put("response_type", "code");
        params.put("redirect_uri", redirect_uri);
        params.put("scope", "snsapi_login");
        if (StringUtils.isBlank(state)) {
            params.put("state", "wx#wechat_redirect");
        } else {
            params.put("state", state.concat("#wechat_redirect"));
        }
        String para = PaymentUtils.packageSign(params, false);
        return qrconnect_url + "?" + para;
    }

    /**
     * 通过code获取access_token
     * 
     * @param code
     *            第一步获取的code参数
     * @param appId
     *            应用唯一标识
     * @param secret
     *            应用密钥AppSecret
     * @return SnsAccessToken
     */
    public static AccessToken refreshSnsAccessToken(final String code, final boolean isJsApi) {
        final Map<String, String> queryParas = new HashMap<String, String>();
        queryParas.put("appid", WechatConfig.getAppId(isJsApi));
        queryParas.put("secret", WechatConfig.getAppSecret(isJsApi));
        queryParas.put("code", code);
        queryParas.put("grant_type", "authorization_code");
        return RetryUtils.retryOnException(3, new Callable<AccessToken>() {
            @Override
            public AccessToken call() throws Exception {
                String json = HttpUtils.doGet(url, queryParas);
                LOGGER.info("从微信获取到的关于用户授权的Token信息:" + json);
                AccessToken accessToken = new AccessToken(json);
                if (!ObjectUtils.isNullOrEmpty(accessToken.getErrorMsg())) {
                    throw new RuntimeException(accessToken.getErrorMsg());
                }
                accessTokenCache.set(WechatConfig.getAppId(isJsApi) + "." + code, accessToken, accessToken.getExpiresIn());
                return accessToken;
            }
        });
    }

    /**
     * 获取WXJS-SDK的access_token
     * 
     * @return SDKAccessToken
     */
    public static AccessToken refreshSDKAccessToken() {
        final Map<String, String> queryParas = new HashMap<String, String>();
        queryParas.put("appid", WechatConfig.getAppId(true));
        queryParas.put("secret", WechatConfig.getAppSecret(true));
        queryParas.put("grant_type", "client_credential");
        return RetryUtils.retryOnException(3, new Callable<AccessToken>() {
            @Override
            public AccessToken call() throws Exception {
                String json = HttpUtils.doGet(SDK_ACCESS_TOKEN_URL, queryParas);
                LOGGER.info("从微信获取到的关于JS-SDK调用的Token信息:" + json);
                AccessToken accessToken = new AccessToken(json);
                if (!ObjectUtils.isNullOrEmpty(accessToken.getErrorMsg())) {
                    throw new RuntimeException(accessToken.getErrorMsg());
                }
                accessTokenCache.set(WechatConfig.getAppId(true) + ".WXJS-SDK", accessToken, accessToken.getExpiresIn());
                return accessToken;
            }
        });
    }

    /**
     * 获取WXJS-SDK的jsapi ticket
     * 
     * @return SnsAccessToken
     */
    public static JsapiTicket refreshSDKJsapiTicket(String accessToken) {
        final Map<String, String> queryParas = new HashMap<String, String>();
        queryParas.put("access_token", accessToken);
        queryParas.put("type", "jsapi");
        return RetryUtils.retryOnException(3, new Callable<JsapiTicket>() {
            @Override
            public JsapiTicket call() throws Exception {
                String json = HttpUtils.doGet(SDK_JSAPI_TICKET_URL, queryParas);
                JsapiTicket jsapiTicket = new JsapiTicket(json);
                if (jsapiTicket.getErrcode() != null && jsapiTicket.getErrcode() != 0) {
                    throw new RuntimeException(jsapiTicket.getErrmsg());
                }
                jsapiTicketCache.set(WechatConfig.getAppId(true) + ".WXJS-SDK", jsapiTicket, jsapiTicket.getExpires_in());
                return jsapiTicket;
            }
        });
    }

    // 利用 appId 与 accessToken 建立关联，支持多账户
    static IAccessTokenCache accessTokenCache = WechatConfig.getAccessTokenCache();

    static IJsapiTicketCache jsapiTicketCache = WechatConfig.getJsapiTicketCache();

    /**
     * 从缓存中获取 access token，如果未取到或者 access token 不可用则先更新再获取
     */
    public static AccessToken getAccessToken(String code, boolean isJsApi) {
        if (ObjectUtils.isNullOrEmpty(code)) {
            throw new IllegalArgumentException("code can not be null");
        }
        String appId = WechatConfig.getAppId(isJsApi);
        AccessToken result = (AccessToken) accessTokenCache.get(appId + "." + code);
        if (result != null && result.isAvailable())
            return result;
        return refreshSnsAccessToken(code, isJsApi);
    }

    /**
     * 从缓存中获取jssdk access token，如果未取到或者jssdk access token 不可用则先更新再获取
     */
    public static AccessToken getSDKAccessToken() {
        String appId = WechatConfig.getAppId(true);
        AccessToken result = (AccessToken) accessTokenCache.get(appId + ".WXJS-SDK");
        if (result != null && result.isAvailable())
            return result;
        return refreshSDKAccessToken();
    }

    /**
     * 从缓存中获取jssdk ticket，如果未取到或者jssdk ticket 不可用则先更新再获取
     */
    public static JsapiTicket getSDKJsapiTicket() {
        AccessToken accessToken = AccessTokenApi.getSDKAccessToken();
        if (StringUtils.isEmpty(accessToken.getAccessToken())) {
            LOGGER.error("该次链接微信端获取AccessToken信息无法成功");
            throw new RuntimeException("该次链接微信端获取AccessToken信息无法成功");
        }
        String appId = WechatConfig.getAppId(true);
        JsapiTicket result = (JsapiTicket) jsapiTicketCache.get(appId + ".WXJS-SDK");
        if (result != null && result.isAvailable())
            return result;
        return refreshSDKJsapiTicket(accessToken.getAccessToken());
    }

    /**
     * 直接获取 accessToken 字符串，方便使用
     * 
     * @return String accessToken
     */
    public static String getAccessTokenStr(String code, boolean isJsApi) {
        return getAccessToken(code, isJsApi).getAccessToken();
    }
}
