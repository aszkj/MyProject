package com.yilidi.o2o.controller.mobile.seller.user;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.user.LoginParam;
import com.yilidi.o2o.appvo.seller.system.CaptchaSessionModel;
import com.yilidi.o2o.appvo.seller.user.StoreBaseVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.sessionmodel.seller.user.SellerSessionModel;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * @Description: TODO(登录Controller)
 * @author: chenlian
 * @date: 2016年6月1日 上午11:25:43
 */
@Controller("sellerLoginController")
@RequestMapping(value = "/interfaces/seller")
public class LoginController extends SellerBaseController {

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private ILoginLogService loginLogService;

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
     */
    @RequestMapping(value = "/user/login")
    @ResponseBody
    public ResultParamModel login(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        // 验证登录信息合法性
        LoginParam loginParam = super.getEntityParam(req, LoginParam.class);
        UserDto userDto = null;
        if (WebConstants.PASSWORD_LOGIN_TYPE == loginParam.getType().intValue()) {
            userDto = userService.loginValidate(loginParam.getMobile(), SystemContext.UserDomain.CUSTOMERTYPE_SELLER,
                    SystemContext.UserDomain.LOGINTYPE_PASSWORD, EncryptUtils.md5Crypt(loginParam.getCode()));
        } else {
            userDto = userService.loginValidate(loginParam.getMobile(), SystemContext.UserDomain.CUSTOMERTYPE_SELLER,
                    SystemContext.UserDomain.LOGINTYPE_CAPTCHA, EncryptUtils.md5Crypt(loginParam.getCode()));
            CaptchaSessionModel captchaSessionModel = SessionUtils.getSellerCaptchaSession(loginParam.getMobile(),
                    String.valueOf(WebConstants.SELLER_CAPTCHA_TYPE_LOGIN));
            if (null == captchaSessionModel) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
            }
            if (!loginParam.getCode().equals(captchaSessionModel.getCaptcha())) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码输入错误，请重新输入");
            }
            long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
            if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
                SessionUtils.removeSellerCaptchaSession(loginParam.getMobile(),
                        String.valueOf(WebConstants.SELLER_CAPTCHA_TYPE_LOGIN));
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
            }
        }
        String userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
        if (!StringUtils.isEmpty(userImageUrl)) {
            userImageUrl = StringUtils.toFullImageUrl(userImageUrl);
        }
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(userDto.getCustomerId(), null);
        if (null == storeProfileDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "您的店铺不存在");
        }
        // 将卖家常用的基本信息保存在Session内
        saveSellerSession(userDto, userImageUrl, storeProfileDto);
        // 发消息异步记录登录日志
        recordLoginLog(req, userDto);
        // 返回卖家相关信息
        return sellerRelatedInfos(userDto, userImageUrl, storeProfileDto);
    }

    private ResultParamModel sellerRelatedInfos(UserDto userDto, String userImageUrl, StoreProfileDto storeProfileDto) {
        StoreBaseVO storeBaseVO = new StoreBaseVO();
        storeBaseVO.setUserId(userDto.getId());
        storeBaseVO.setUserName(storeProfileDto.getContact());
        storeBaseVO.setUserImageUrl(userImageUrl);
        storeBaseVO.setUserMobile(userDto.getPhone());
        storeBaseVO.setHotline(storeProfileDto.getMobile());
        storeBaseVO.setStoreId(storeProfileDto.getStoreId());
        storeBaseVO.setStoreName(storeProfileDto.getStoreName());
        storeBaseVO.setAddressDetail(systemBasicDataInfoUtils.getAddressPrefix(storeProfileDto.getProvinceCode(),
                storeProfileDto.getCityCode(), storeProfileDto.getCountyCode()) + storeProfileDto.getAddressDetail());
        storeBaseVO.setBeginBusinessHours(storeProfileDto.getBusinessHoursBegin());
        storeBaseVO.setEndBusinessHours(storeProfileDto.getBusinessHoursEnd());
        CustomerDto customerDto = customerService.loadCustomerById(storeProfileDto.getStoreId());
        if (null != customerDto) {
            storeBaseVO.setInvitationCode(customerDto.getInvitationCode());
        }
        storeBaseVO.setLongitude(Double.parseDouble(storeProfileDto.getLongitude()));
        storeBaseVO.setLatitude(Double.parseDouble(storeProfileDto.getLatitude()));
        storeBaseVO.setShareFlag(ConverterUtils.toClientShareFlag(storeProfileDto.getStockShare()));
        return super.encapsulateParam(storeBaseVO, AppMsgBean.MsgCode.SUCCESS, "登录成功");
    }

    private void recordLoginLog(HttpServletRequest req, UserDto userDto) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(session.getId());
        if (null == loginLogDto) {
            String channelType = null;
            if (WebConstants.CALL_CHANNEL_TYPE_ANDROID.equals(getIntfCallChannel(req))) {
                channelType = SystemContext.UserDomain.CHANNELTYPE_ANDROID;
            } else if (WebConstants.CALL_CHANNEL_TYPE_IOS.equals(getIntfCallChannel(req))) {
                channelType = SystemContext.UserDomain.CHANNELTYPE_IOS;
            }
            LoginLogDto loginLog = new LoginLogDto(session.getId(), userDto.getId(), userDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_SELLER, DateUtils.getCurrentDateTime(), super.getRealIP(req),
                    channelType);
            loginLogService.sendLoginLogMessage(loginLog);
        }
    }

    private void saveSellerSession(UserDto userDto, String userImageUrl, StoreProfileDto storeProfileDto) {
        SellerSessionModel sellerSessionModel = new SellerSessionModel();
        sellerSessionModel.setUserId(userDto.getId());
        sellerSessionModel.setUserName(userDto.getUserName());
        sellerSessionModel.setUserMobile(userDto.getPhone());
        sellerSessionModel.setUserImageUrl(userImageUrl);
        sellerSessionModel.setMasterFlag(userDto.getMasterFlag());
        sellerSessionModel.setStoreId(storeProfileDto.getStoreId());
        sellerSessionModel.setLongitude(storeProfileDto.getLongitude());
        sellerSessionModel.setLatitude(storeProfileDto.getLatitude());
        SessionUtils.setSellerUserSession(sellerSessionModel);
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
    @SellerLoginValidation
    @RequestMapping(value = "/user/logout")
    @ResponseBody
    public ResultParamModel logout(HttpServletRequest req, HttpServletResponse resp) {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        String sessionId = session.getId();
        // 登出时将Session失效
        SessionUtils.removeSellerUserSessionModel();
        // 发消息异步更新登录日志
        LoginLogDto loginLogDto = loginLogService.getLoginLogBySessionId(sessionId);
        if (null != loginLogDto) {
            LoginLogDto llDto = new LoginLogDto();
            llDto.setSessionId(loginLogDto.getSessionId());
            llDto.setLogoutTime(DateUtils.getCurrentDateTime());
            loginLogService.sendLoginLogMessage(llDto);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "登出成功");
    }

    /**
     * 用户信息
     * 
     * @Description 用户信息
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/user/userinfo")
    @ResponseBody
    public ResultParamModel userinfo(HttpServletRequest req, HttpServletResponse resp) {
        StoreBaseVO storeBaseVO = new StoreBaseVO();
        storeBaseVO.setUserId(super.getUserId());
        storeBaseVO.setUserImageUrl(super.getUserImageUrl());
        storeBaseVO.setUserMobile(super.getUserMobile());
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == storeProfileDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "您的店铺不存在");
        }
        storeBaseVO.setUserName(storeProfileDto.getContact());
        storeBaseVO.setHotline(storeProfileDto.getMobile());
        storeBaseVO.setStoreId(storeProfileDto.getStoreId());
        storeBaseVO.setStoreName(storeProfileDto.getStoreName());
        storeBaseVO.setAddressDetail(systemBasicDataInfoUtils.getAddressPrefix(storeProfileDto.getProvinceCode(),
                storeProfileDto.getCityCode(), storeProfileDto.getCountyCode()) + storeProfileDto.getAddressDetail());
        storeBaseVO.setBeginBusinessHours(storeProfileDto.getBusinessHoursBegin());
        storeBaseVO.setEndBusinessHours(storeProfileDto.getBusinessHoursEnd());
        CustomerDto customerDto = customerService.loadCustomerById(storeProfileDto.getStoreId());
        if (null != customerDto) {
            storeBaseVO.setInvitationCode(customerDto.getInvitationCode());
        }
        storeBaseVO.setLongitude(Double.parseDouble(storeProfileDto.getLongitude()));
        storeBaseVO.setLatitude(Double.parseDouble(storeProfileDto.getLatitude()));
        storeBaseVO.setShareFlag(ConverterUtils.toClientShareFlag(storeProfileDto.getStockShare()));
        return super.encapsulateParam(storeBaseVO, AppMsgBean.MsgCode.SUCCESS, "获取用户信息成功");
    }

}
