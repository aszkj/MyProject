/**
 * 文件名称：CookieUtils.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.common.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述：Cookie工具类<br>
 * 作者： chenl<br>
 * 
 * BugID:<br>
 * 修改内容：
 */
public final class CookieUtils {

    private CookieUtils() {
    }

    protected static final Logger LOGGER = Logger.getLogger(CookieUtils.class);

    /**
     * 获取Cookie的值，默认无需转码
     * 
     * @param request
     *            网络请求
     * @param cookieName
     *            cookie名称
     * @return Cookie的值
     */
    public static String getCookieValue(HttpServletRequest request, String cookieName) {
        return getCookieValue(request, cookieName, false);
    }

    /**
     * 获取Cookie的值
     * 
     * @param request
     *            网络请求
     * @param cookieName
     *            cookie名称
     * @param isDecoder
     *            是否需要转码
     * @return Cookie的值
     */
    public static String getCookieValue(HttpServletRequest request, String cookieName, boolean isDecoder) {
        Cookie[] cookieList = request.getCookies();
        if (cookieList == null || cookieName == null) {
            return null;
        }
        String retValue = null;
        try {
            LOGGER.debug("cookies.size:" + cookieList.length);
            for (int i = 0; i < cookieList.length; i++) {
                LOGGER.debug("NAME:" + cookieList[i].getName());
                if (cookieList[i].getName().equals(cookieName)) {
                    if (isDecoder) {
                        retValue = URLDecoder.decode(cookieList[i].getValue(), CommonConstants.UTF_8);
                    } else {
                        retValue = cookieList[i].getValue();
                    }
                    break;
                }
            }
        } catch (UnsupportedEncodingException e) {
            LOGGER.error(e.getMessage(), e);
        }
        return retValue;
    }

    /**
     * 设置Cookie 的值
     * 
     * @param response
     *            网络请求
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     */
    public static void setCookie(HttpServletResponse response, String cookieName, String cookieValue) {
        if (cookieValue == null) {
            cookieValue = "";
        }
        setCookie(null, response, cookieName, cookieValue);
    }

    /**
     * 设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     */
    public static void setCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
            String cookieValue) {
        setCookie(request, response, cookieName, cookieValue, -1);
    }

    /**
     * 设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     * @param cookieMaxage
     *            cookie最大有效时间
     */
    public static void setCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
            String cookieValue, int cookieMaxage) {
        setCookie(request, response, cookieName, cookieValue, cookieMaxage, false);
    }

    /**
     * 设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     * @param isEncode
     *            是否进行编码
     */
    public static void setCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
            String cookieValue, boolean isEncode) {
        setCookie(request, response, cookieName, cookieValue, -1, isEncode);
    }

    /**
     * 设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     * @param cookieMaxage
     *            cookie最大有效时间
     * @param isEncode
     *            是否进行编码
     */
    public static void setCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
            String cookieValue, int cookieMaxage, boolean isEncode) {
        doSetCookie(request, response, cookieName, cookieValue, cookieMaxage, isEncode);
    }

    /**
     * 删除 Cookie
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     */
    public static void deleteCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        doSetCookie(request, response, cookieName, "", -1, false);
    }

    /**
     * 删除 Cookie
     * 
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     */
    public static void deleteCookie(HttpServletResponse response, String cookieName) {
        doSetCookie(null, response, cookieName, "", -1, false);
    }

    /**
     * 删除 Cookie
     * 
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param domainName
     *            域名
     */
    public static void deleteCookieForGivenDomain(HttpServletResponse response, String cookieName, String domainName) {
        doSetCookieForGivenDomain(null, response, cookieName, "", -1, false, domainName);
    }

    /**
     * 设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     * @param cookieMaxage
     *            cookie最大有效时间
     * @param isEncode
     *            是否进行编码
     */
    private static final void doSetCookie(HttpServletRequest request, HttpServletResponse response, String cookieName,
            String cookieValue, int cookieMaxage, boolean isEncode) {
        try {
            if (cookieValue != null && "".equals(cookieValue)) {
                cookieValue = null;
            } else if (isEncode) {
                cookieValue = URLEncoder.encode(cookieValue, CommonConstants.UTF_8);
            }
            Cookie cookie = new Cookie(cookieName, cookieValue);
            if (cookieMaxage > 0) {
                cookie.setMaxAge(cookieMaxage);
            } else if (cookieValue == null) {
                cookie.setMaxAge(0);
            }
            cookie.setPath(CommonConstants.BACKSLASH);
            response.addCookie(cookie);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
    }

    /**
     * 根据指定的domainName，设置Cookie 的值
     * 
     * @param request
     *            网络请求
     * @param response
     *            网络应答
     * @param cookieName
     *            cookie名称
     * @param cookieValue
     *            cookie值
     * @param cookieMaxage
     *            cookie最大有效时间
     * @param isEncode
     *            是否进行编码
     * @param domainName
     *            域名
     */
    public static final void doSetCookieForGivenDomain(HttpServletRequest request, HttpServletResponse response,
            String cookieName, String cookieValue, int cookieMaxage, boolean isEncode, String domainName) {
        try {
            if (cookieValue != null && "".equals(cookieValue)) {
                cookieValue = null;
            } else if (isEncode) {
                cookieValue = URLEncoder.encode(cookieValue, CommonConstants.UTF_8);
            }
            Cookie cookie = new Cookie(cookieName, cookieValue);
            if (cookieMaxage > 0) {
                cookie.setMaxAge(cookieMaxage);
            } else if (cookieValue == null) {
                cookie.setMaxAge(0);
            }
            cookie.setDomain(domainName);
            cookie.setPath(CommonConstants.BACKSLASH);
            response.addCookie(cookie);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
    }

    /**
     * 获取域名
     * 
     * @param request
     *            网络请求
     * @return 域名
     */
    public static final String getDomainName(HttpServletRequest request) {
        String domainName = null;
        String referer = request.getHeader("Referer");
        String serverName = referer;
        if (StringUtils.isEmpty(serverName)) {
            // 如果没有Referer（比如APP），就直接从URL中获取。
            serverName = request.getRequestURL().toString();
        }
        serverName = serverName.toLowerCase();
        if (serverName.contains("?")) {
            String[] urlQuestionMark = serverName.split("\\?");
            serverName = urlQuestionMark[0];
        }
        String[] ary = serverName.split("://");
        if (ary.length > 1) {
            serverName = ary[1];
        }
        int end = serverName.indexOf(CommonConstants.BACKSLASH);
        if (-1 != end) {
            serverName = serverName.substring(0, end);
        }
        domainName = serverName;
        LOGGER.debug("CookieUtils : Referer=" + referer);
        LOGGER.debug("CookieUtils : RequestURL=" + request.getRequestURL().toString());
        LOGGER.debug("CookieUtils : domainName=" + domainName);
        return domainName;
    }
}
