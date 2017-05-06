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

import com.yilidi.o2o.appparam.buyer.user.LoginParam;
import com.yilidi.o2o.appvo.buyer.user.BindQQInfoVO;
import com.yilidi.o2o.appvo.buyer.user.BindWXInfoVO;
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
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IShopCartService;
import com.yilidi.o2o.order.service.dto.ShopCartDto;
import com.yilidi.o2o.sessionmodel.buyer.order.ShopCartItemSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.BuyerCaptchaSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IAccountService;
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
 * @Description: 登录
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerLoginController")
@RequestMapping(value = "/interfaces/buyer")
public class LoginController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";

    @Autowired
    private IUserService userService;
    @Autowired
    private ILoginLogService loginLogService;
    @Autowired
    private IUserShareService userShareService;
    @Autowired
    private IShopCartService shopCartService;
    @Autowired
    private IAccountService accountService;
    @Autowired
    private IConnectUserService connectUserService;

    /**
     * 登录
     * 
     * @Description 登录
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/user/login")
    @ResponseBody
    public ResultParamModel login(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        LoginParam loginParam = super.getEntityParam(req, LoginParam.class);
        String mobile = loginParam.getMobile();
        String code = loginParam.getCode();
        Integer type = loginParam.getType();
        UserDto userDto = null;
        // 密码登录
        if (WebConstants.PASSWORD_LOGIN_TYPE == type) {
            userDto = userService.loginValidate(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER,
                    SystemContext.UserDomain.LOGINTYPE_PASSWORD, EncryptUtils.md5Crypt(code));
        } else { // 验证码登录
            BuyerCaptchaSessionModel captchaSessionModel = SessionUtils.getBuyerCaptchaSession(mobile,
                    String.valueOf(WebConstants.BUYER_CAPTCHA_TYPE_LOGIN));
            if (null == captchaSessionModel) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
            }
            if (!loginParam.getCode().equals(captchaSessionModel.getCaptcha())) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码输入错误，请重新输入");
            }
            long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
            if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
                SessionUtils.removeBuyerCaptchaSession(loginParam.getMobile(),
                        String.valueOf(WebConstants.BUYER_CAPTCHA_TYPE_LOGIN));
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
            }
            userDto = userService.loadUserByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            if (userDto == null) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "帐号不存在");
            }
            if (!SystemContext.UserDomain.USERSTATUS_ON.equals(userDto.getStatusCode())) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "帐号无效");
            }
        }
        String userImageUrl = null;
        String nickName = null;
        String vipExpireDate = null;
        String gender = null;
        Date birthDay = null;
        if (null != userDto.getVipExpireDate()) {
            vipExpireDate = DateUtils.formatDate(userDto.getVipExpireDate(), CommonConstants.DATE_FORMAT_DAY);
        }
        if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
            userImageUrl = StringUtils.toFullImageUrl(userDto.getUserProfileDto().getUserImageUrl());
            nickName = userDto.getUserProfileDto().getNickName();
            gender = userDto.getUserProfileDto().getGender();
            birthDay = userDto.getUserProfileDto().getBirthday();
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
        loginVO.setBirthday(birthDay);
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
        YiLiDiSession session = YiLiDiSessionHolder.getSession();

        Date nowTime = new Date();
        // 发送用户分享登录奖励消息
        userShareService.sendUserShareAwardMessage(userDto.getId(), nowTime, null,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN);
        // 发送同步购物车商品消息
        shopCartService.sendAsycnShopCartMessage(userSession.getUserId(), shopCartDtos);
        // 登录日志
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(session.getId());
        if (null == loginLogDto) {
            String ip = req.getHeader("X-Real-IP");
            String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
            LoginLogDto loginLog = new LoginLogDto(session.getId(), userDto.getId(), userDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER, nowTime, ip, channelType);
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

    /**
     * 登出系统
     * 
     * @Description 登出系统
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/logout")
    @ResponseBody
    public ResultParamModel logout(HttpServletRequest req, HttpServletResponse resp) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        String sessionId = session.getId();
        SessionUtils.removeBuyerUserSession();

        // 登出日志
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(sessionId);
        if (null != loginLogDto) {
            LoginLogDto loginLog = new LoginLogDto();
            loginLog.setSessionId(loginLogDto.getSessionId());
            loginLog.setLogoutTime(DateUtils.getCurrentDateTime());
            loginLogService.sendLoginLogMessage(loginLog);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "登出成功");
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
