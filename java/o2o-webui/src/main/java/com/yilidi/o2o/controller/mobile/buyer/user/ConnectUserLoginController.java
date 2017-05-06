package com.yilidi.o2o.controller.mobile.buyer.user;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.QQLoginParam;
import com.yilidi.o2o.appparam.buyer.user.UserBindParam;
import com.yilidi.o2o.appparam.buyer.user.WeChatLoginParam;
import com.yilidi.o2o.appvo.buyer.user.BindQQInfoVO;
import com.yilidi.o2o.appvo.buyer.user.BindWXInfoVO;
import com.yilidi.o2o.appvo.buyer.user.ConnectUserLoginVO;
import com.yilidi.o2o.appvo.buyer.user.LoginVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.connect.qq.api.QQUserInfoApi;
import com.yilidi.o2o.core.connect.qq.javabean.QQUserInfo;
import com.yilidi.o2o.core.connect.wechat.api.AccessTokenApi;
import com.yilidi.o2o.core.connect.wechat.api.WechatUserApi;
import com.yilidi.o2o.core.connect.wechat.javabean.AccessToken;
import com.yilidi.o2o.core.connect.wechat.javabean.WechatUserInfo;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IShopCartService;
import com.yilidi.o2o.order.service.dto.ShopCartDto;
import com.yilidi.o2o.sessionmodel.buyer.order.ShopCartItemSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.BuyerCaptchaSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IConnectUserService;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 用户登录
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("connectUserLoginController")
@RequestMapping(value = "/interfaces/buyer")
public class ConnectUserLoginController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final int UNBINDED = 0;
    private static final int BINDED = 1;

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";
    private static final String CONNECTUSER_OPENID_SESSION_KEY = "OAUTH2_OPENID_SESSION_KEY";
    @Autowired
    private IUserService userService;
    @Autowired
    private IConnectUserService connectUserService;
    @Autowired
    private ILoginLogService loginLogService;
    @Autowired
    private IUserShareService userShareService;
    @Autowired
    private IShopCartService shopCartService;

    /**
     * 第三方微信授权登录
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/user/weixinlogin")
    @ResponseBody
    public ResultParamModel wechatLogin(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        WeChatLoginParam weChatLoginParam = super.getEntityParam(req, WeChatLoginParam.class);
        String code = weChatLoginParam.getCode();
        String tradeType = weChatLoginParam.getTradeType();
        boolean isJsApi = WechatConfig.JS_TRADE_TYPE.equals(tradeType);
        AccessToken accessToken = AccessTokenApi.getAccessToken(code, isJsApi);
        List<ConnectUserDto> connectUserDtos = connectUserService.listByUnionId(accessToken.getUnionid());
        Integer bindedUserId = null;
        if (!ObjectUtils.isNullOrEmpty(connectUserDtos)) {
            for (ConnectUserDto connectUserDto : connectUserDtos) {
                if (!ObjectUtils.isNullOrEmpty(connectUserDto.getUserId())) {
                    bindedUserId = connectUserDto.getUserId();
                    break;
                }
            }
        }
        ConnectUserLoginVO connectUserLoginVO = new ConnectUserLoginVO();
        ConnectUserDto existsConnectUserDto = connectUserService.loadByOpenId(accessToken.getOpenid());
        Date nowTime = new Date();
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(CONNECTUSER_OPENID_SESSION_KEY, accessToken.getOpenid());
        if (ObjectUtils.isNullOrEmpty(existsConnectUserDto)) { // 第一次授权
            WechatUserInfo weiXinUserInfo = WechatUserApi.getUserInfo(accessToken.getAccessToken(), accessToken.getOpenid());
            if (!ObjectUtils.isNullOrEmpty(weiXinUserInfo.getErrmsg())) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, weiXinUserInfo.getErrmsg());
            }
            ConnectUserDto connectUserDto = new ConnectUserDto();
            connectUserDto.setOpenId(weiXinUserInfo.getOpenid());
            connectUserDto.setGender(weiXinUserInfo.getSex());
            connectUserDto.setNickName(weiXinUserInfo.getNickname());
            connectUserDto.setUnionId(weiXinUserInfo.getUnionid());
            connectUserDto.setHeadImgUrl(weiXinUserInfo.getHeadimgurl());
            String connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP;
            if (isJsApi) {
                connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5;
            }
            connectUserDto.setConnectType(connectType);
            connectUserDto.setCreateTime(nowTime);
            connectUserDto.setModifyTime(nowTime);
            if (!ObjectUtils.isNullOrEmpty(bindedUserId)) {
                connectUserLoginVO.setBinding(BINDED);
                connectUserDto.setUserId(bindedUserId);
            } else {
                connectUserLoginVO.setBinding(UNBINDED);
            }
            connectUserService.save(connectUserDto);
            if (ObjectUtils.isNullOrEmpty(connectUserDto.getUserId())) {
                return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
            }
        } else {
            if (ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId()) && ObjectUtils.isNullOrEmpty(bindedUserId)) {
                connectUserLoginVO.setBinding(UNBINDED);
                return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
            } else if (!ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId())) {
                bindedUserId = existsConnectUserDto.getUserId();
                if (ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUnionId())) {
                    connectUserService.updateBindUserIdByOpenId(existsConnectUserDto.getOpenId(), bindedUserId);
                } else {
                    connectUserService.updateBindUserIdByUnionId(existsConnectUserDto.getUnionId(), bindedUserId);
                }
            }
        }
        // 已经绑定手机号,直接登录
        UserDto userDto = userService.loadBuyerUserById(bindedUserId);
        if (ObjectUtils.isNullOrEmpty(userDto)) {
            connectUserLoginVO.setBinding(UNBINDED);
            return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
        }
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromSession();
        String vipExpireDate = null;
        if (null != userDto.getVipExpireDate()) {
            vipExpireDate = DateUtils.formatDate(userDto.getVipExpireDate(), CommonConstants.DATE_FORMAT_DAY);
        }
        String userImageUrl = null;
        String nickName = null;
        String gender = null;
        if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
            userImageUrl = StringUtils.toFullImageUrl(userDto.getUserProfileDto().getUserImageUrl());
            nickName = userDto.getUserProfileDto().getNickName();
            gender = userDto.getUserProfileDto().getGender();
        }
        connectUserLoginVO.setUserId(userDto.getId());
        connectUserLoginVO.setUserName(userDto.getUserName());
        connectUserLoginVO.setUserImageUrl(userImageUrl);
        connectUserLoginVO.setUserSex(ConverterUtils.toClientGender(gender));
        connectUserLoginVO.setMemberType(ConverterUtils.toClienMemberType(userDto.getBuyerLevelCode()));
        connectUserLoginVO.setVipExpireDate(vipExpireDate);
        connectUserLoginVO.setNickName(nickName);
        connectUserLoginVO.setBinding(BINDED);
        ConnectUserDto qqConnectUserDto = connectUserService.loadByUserIdAndConnectType(userDto.getId(),
                SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
        BindQQInfoVO bindQQInfo = null;
        if (!ObjectUtils.isNullOrEmpty(qqConnectUserDto)) {
            bindQQInfo = new BindQQInfoVO(qqConnectUserDto.getNickName());
        }
        List<String> connectTypes = new ArrayList<String>();
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
        List<ConnectUserDto> wxConnectUserDtos = connectUserService.listByUserIdAndConnectTypes(userDto.getId(),
                connectTypes);
        BindWXInfoVO bindWXInfo = null;
        if (!ObjectUtils.isNullOrEmpty(wxConnectUserDtos)) {
            for (ConnectUserDto connectUserDto : wxConnectUserDtos) {
                bindWXInfo = new BindWXInfoVO(connectUserDto.getNickName());
                break;
            }
        }
        connectUserLoginVO.setBindQQInfo(bindQQInfo);
        connectUserLoginVO.setBindWXInfo(bindWXInfo);
        UserSessionModel userSession = new UserSessionModel(userDto);
        SessionUtils.setBuyerUserSession(userSession);

        // 发送用户分享登录奖励消息
        userShareService.sendUserShareAwardMessage(userDto.getId(), nowTime, null,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN);
        // 发送同步购物车商品消息
        shopCartService.sendAsycnShopCartMessage(userSession.getUserId(), shopCartDtos);
        // 登录日志
        session = YiLiDiSessionHolder.getSession();
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(session.getId());
        if (null == loginLogDto) {
            String ip = req.getHeader("X-Real-IP");
            String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
            LoginLogDto loginLog = new LoginLogDto(session.getId(), userDto.getId(), userDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER, new Date(), ip, channelType);
            loginLogService.sendLoginLogMessage(loginLog);
        }
        return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
    }

    /**
     * 第三方QQ授权登录
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/user/qqlogin")
    @ResponseBody
    public ResultParamModel qqLogin(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        QQLoginParam weChatLoginParam = super.getEntityParam(req, QQLoginParam.class);
        String accessToken = weChatLoginParam.getAccessToken();
        String openId = weChatLoginParam.getOpenId();
        String channel = super.getIntfCallChannel(req);
        ConnectUserLoginVO connectUserLoginVO = new ConnectUserLoginVO();
        ConnectUserDto existsConnectUserDto = connectUserService.loadByOpenId(openId);
        Date nowTime = new Date();
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(CONNECTUSER_OPENID_SESSION_KEY, openId);
        if (ObjectUtils.isNullOrEmpty(existsConnectUserDto)) { // 第一次授权
            QQUserInfo qqUserInfo = QQUserInfoApi.getUserInfo(accessToken, openId, channel);
            if (!ObjectUtils.isNullOrEmpty(qqUserInfo.getMsg())) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, qqUserInfo.getMsg());
            }
            ConnectUserDto connectUserDto = new ConnectUserDto();
            connectUserDto.setOpenId(openId);
            connectUserDto.setGender(getGender(qqUserInfo.getGender()));
            connectUserDto.setNickName(qqUserInfo.getNickname());
            connectUserDto.setHeadImgUrl(qqUserInfo.getHeadimgurl());
            connectUserDto.setConnectType(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
            connectUserDto.setCreateTime(nowTime);
            connectUserDto.setModifyTime(nowTime);
            connectUserService.save(connectUserDto);
            connectUserLoginVO.setBinding(UNBINDED);
            return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
        }
        if (ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId())) { // 未绑定手机号
            connectUserLoginVO.setBinding(UNBINDED);
            return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
        }
        // 已经绑定手机号,直接登录
        UserDto userDto = userService.loadBuyerUserById(existsConnectUserDto.getUserId());
        if (ObjectUtils.isNullOrEmpty(userDto)) {
            connectUserLoginVO.setBinding(UNBINDED);
            return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
        }
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromSession();
        String vipExpireDate = null;
        if (null != userDto.getVipExpireDate()) {
            vipExpireDate = DateUtils.formatDate(userDto.getVipExpireDate(), CommonConstants.DATE_FORMAT_DAY);
        }
        String userImageUrl = null;
        String nickName = null;
        String gender = null;
        if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
            userImageUrl = StringUtils.toFullImageUrl(userDto.getUserProfileDto().getUserImageUrl());
            nickName = userDto.getUserProfileDto().getNickName();
            gender = userDto.getUserProfileDto().getGender();
        }
        connectUserLoginVO.setUserId(userDto.getId());
        connectUserLoginVO.setUserName(userDto.getUserName());
        connectUserLoginVO.setUserImageUrl(userImageUrl);
        connectUserLoginVO.setUserSex(ConverterUtils.toClientGender(gender));
        connectUserLoginVO.setMemberType(ConverterUtils.toClienMemberType(userDto.getBuyerLevelCode()));
        connectUserLoginVO.setVipExpireDate(vipExpireDate);
        connectUserLoginVO.setNickName(nickName);
        connectUserLoginVO.setBinding(BINDED);
        ConnectUserDto qqConnectUserDto = connectUserService.loadByUserIdAndConnectType(userDto.getId(),
                SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
        BindQQInfoVO bindQQInfo = null;
        if (!ObjectUtils.isNullOrEmpty(qqConnectUserDto)) {
            bindQQInfo = new BindQQInfoVO(qqConnectUserDto.getNickName());
        }
        List<String> connectTypes = new ArrayList<String>();
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
        List<ConnectUserDto> wxConnectUserDtos = connectUserService.listByUserIdAndConnectTypes(userDto.getId(),
                connectTypes);
        BindWXInfoVO bindWXInfo = null;
        if (!ObjectUtils.isNullOrEmpty(wxConnectUserDtos)) {
            for (ConnectUserDto connectUserDto : wxConnectUserDtos) {
                bindWXInfo = new BindWXInfoVO(connectUserDto.getNickName());
                break;
            }
        }
        connectUserLoginVO.setBindQQInfo(bindQQInfo);
        connectUserLoginVO.setBindWXInfo(bindWXInfo);
        UserSessionModel userSession = new UserSessionModel(userDto);
        SessionUtils.setBuyerUserSession(userSession);

        // 发送用户分享登录奖励消息
        userShareService.sendUserShareAwardMessage(userDto.getId(), nowTime, null,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN);
        // 发送同步购物车商品消息
        shopCartService.sendAsycnShopCartMessage(userSession.getUserId(), shopCartDtos);
        // 登录日志
        session = YiLiDiSessionHolder.getSession();
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(session.getId());
        if (null == loginLogDto) {
            String ip = req.getHeader("X-Real-IP");
            String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
            LoginLogDto loginLog = new LoginLogDto(session.getId(), userDto.getId(), userDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER, new Date(), ip, channelType);
            loginLogService.sendLoginLogMessage(loginLog);
        }
        return super.encapsulateParam(connectUserLoginVO, AppMsgBean.MsgCode.SUCCESS, "授权成功");
    }

    /**
     * 用户绑定
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/oauth2/user/bind")
    @ResponseBody
    public ResultParamModel userBind(HttpServletRequest req, HttpServletResponse resp) {
        UserBindParam userBindParam = super.getEntityParam(req, UserBindParam.class);
        String mobile = userBindParam.getMobile();
        String password = userBindParam.getPassword();
        String code = userBindParam.getCode();
        Date nowTime = new Date();
        BuyerCaptchaSessionModel captchaSessionModel = SessionUtils.getBuyerCaptchaSession(mobile,
                WebConstants.BUYER_CAPTCHA_TYPE_USERBINDING);
        if (null == captchaSessionModel) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
        }
        if (!code.equals(captchaSessionModel.getCaptcha())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码不正确");
        }
        long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
        if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
            SessionUtils.removeBuyerCaptchaSession(mobile, String.valueOf(WebConstants.BUYER_CAPTCHA_TYPE_USERBINDING));
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
        }
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        String openId = (String) session.getAttribute(CONNECTUSER_OPENID_SESSION_KEY);
        if (ObjectUtils.isNullOrEmpty(openId)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "绑定失败,请重新授权");
        }
        String registerPlatform = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
        Integer userId = connectUserService.saveBindUserInfo(openId, mobile, password, registerPlatform);
        UserDto userDto = userService.loadBuyerUserById(userId);
        String vipExpireDate = null;
        if (null != userDto.getVipExpireDate()) {
            vipExpireDate = DateUtils.formatDate(userDto.getVipExpireDate(), CommonConstants.DATE_FORMAT_DAY);
        }
        String userImageUrl = null;
        String nickName = null;
        String gender = null;
        if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
            userImageUrl = StringUtils.toFullImageUrl(userDto.getUserProfileDto().getUserImageUrl());
            gender = userDto.getUserProfileDto().getGender();
            nickName = userDto.getUserProfileDto().getNickName();
        }
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromSession();
        LoginVO loginVO = new LoginVO();
        loginVO.setUserId(userDto.getId());
        loginVO.setUserName(userDto.getUserName());
        loginVO.setUserImageUrl(userImageUrl);
        loginVO.setUserSex(ConverterUtils.toClientGender(gender));
        loginVO.setMemberType(ConverterUtils.toClienMemberType(userDto.getBuyerLevelCode()));
        loginVO.setVipExpireDate(vipExpireDate);
        loginVO.setNickName(nickName);
        ConnectUserDto qqConnectUserDto = connectUserService.loadByUserIdAndConnectType(userDto.getId(),
                SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
        BindQQInfoVO bindQQInfo = null;
        if (!ObjectUtils.isNullOrEmpty(qqConnectUserDto)) {
            bindQQInfo = new BindQQInfoVO(qqConnectUserDto.getNickName());
        }
        List<String> connectTypes = new ArrayList<String>();
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
        List<ConnectUserDto> wxConnectUserDtos = connectUserService.listByUserIdAndConnectTypes(userDto.getId(),
                connectTypes);
        BindWXInfoVO bindWXInfo = null;
        if (!ObjectUtils.isNullOrEmpty(wxConnectUserDtos)) {
            for (ConnectUserDto connectUserDto : wxConnectUserDtos) {
                bindWXInfo = new BindWXInfoVO(connectUserDto.getNickName());
                break;
            }
        }
        loginVO.setBindQQInfo(bindQQInfo);
        loginVO.setBindWXInfo(bindWXInfo);
        UserSessionModel userSession = new UserSessionModel(userDto);
        SessionUtils.setBuyerUserSession(userSession);
        // 发送用户分享登录奖励消息
        userShareService.sendUserShareAwardMessage(userDto.getId(), nowTime, null,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN);
        // 发送同步购物车商品消息
        shopCartService.sendAsycnShopCartMessage(userSession.getUserId(), shopCartDtos);
        // 登录日志
        session = YiLiDiSessionHolder.getSession();
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(session.getId());
        if (null == loginLogDto) {
            String ip = req.getHeader("X-Real-IP");
            String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
            LoginLogDto loginLog = new LoginLogDto(session.getId(), userDto.getId(), userDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER, new Date(), ip, channelType);
            loginLogService.sendLoginLogMessage(loginLog);
        }
        return super.encapsulateParam(loginVO, AppMsgBean.MsgCode.SUCCESS, "登录成功");
    }

    private Integer getSystemConfigCaptchaTimeout() {
        String systemConfigCaptchaTimeoutStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.SMS_CAPTCHA_TIME_OUT);
        systemConfigCaptchaTimeoutStr = StringUtils.isEmpty(systemConfigCaptchaTimeoutStr) ? SMS_CAPTCHA_TIME_OUT_DEFAULT
                : systemConfigCaptchaTimeoutStr;
        Integer systemConfigCaptchaTimeout = Integer.parseInt(systemConfigCaptchaTimeoutStr);
        return systemConfigCaptchaTimeout;
    }

    private int getGender(String gender) {
        if ("男".equals(gender)) {
            return CommonConstants.GENDER_MALE;
        }
        return CommonConstants.GENDER_FEMALE;
    }

    private List<ShopCartDto> getShopCartDtoListFromSession() {
        List<ShopCartItemSessionModel> shopCartItemSessions = SessionUtils.getShopCartItemSession();
        List<ShopCartDto> shopCartDtos = new ArrayList<ShopCartDto>();
        if (ObjectUtils.isNullOrEmpty(shopCartItemSessions)) {
            return shopCartDtos;
        }
        if (!ObjectUtils.isNullOrEmpty(shopCartItemSessions)) {
            for (ShopCartItemSessionModel shopCartItemSessionModel : shopCartItemSessions) {
                ShopCartDto shopCartDto = new ShopCartDto();
                shopCartDto.setActivityId(shopCartItemSessionModel.getActId());
                shopCartDto.setSaleProductId(shopCartItemSessionModel.getSaleProductId());
                shopCartDto.setQuantity(shopCartItemSessionModel.getQuantity());
                shopCartDto.setStoreId(shopCartItemSessionModel.getStoreId());
                shopCartDtos.add(shopCartDto);
            }
        }
        return shopCartDtos;
    }
}
