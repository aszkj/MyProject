package com.yilidi.o2o.controller.mobile.buyer.user;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.RegistParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.BuyerCaptchaSessionModel;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IRecommendCustomerStoreService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

/**
 * 用户注册
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerRegisterController")
@RequestMapping(value = "/interfaces/buyer")
public class RegisterController extends BuyerBaseController {

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IRecommendCustomerStoreService recommendCustomerStoreService;
    
    @Autowired
    private IAccountService accountService;

    private Integer getRegistDefaultCreateUserId() {
        String paramValue = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.U_REGIST_DEFAULT_CREATE_USER_ID);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return null;
        }
        return Integer.parseInt(paramValue);
    }

    /**
     * 注册
     * 
     * @Description 注册
     * @param req
     *            HttpServletRequest 对象
     * @param resp
     *            HttpServletResponse 对象
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/user/regist")
    @ResponseBody
    public ResultParamModel regist(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        RegistParam registParam = super.getEntityParam(req, RegistParam.class);
        String mobile = registParam.getMobile();
        String invitationCode = registParam.getInvitationCode();

        BuyerCaptchaSessionModel captchaSessionModel = SessionUtils.getBuyerCaptchaSession(mobile,
                WebConstants.BUYER_CAPTCHA_TYPE_REGISTER);
        if (null == captchaSessionModel) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
        }
        if (!registParam.getCode().equals(captchaSessionModel.getCaptcha())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码不正确");
        }
        long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
        if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
            SessionUtils.removeBuyerCaptchaSession(registParam.getMobile(),
                    String.valueOf(WebConstants.BUYER_CAPTCHA_TYPE_REGISTER));
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
        }
        boolean isUserExists = userService.checkUserNameIsExist(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
        if (isUserExists) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该手机号码已经被注册");
        }
        int inviteCustomerId = 0;
        int recommendCustomerId = 0;
        if (!StringUtils.isBlank(invitationCode)) {
            // 校验邀请码
            CustomerDto cto = customerService.loadByInvitationCode(invitationCode.toUpperCase());
            if (cto == null) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "邀请码不存在");
            }
            if (SystemContext.UserDomain.CUSTOMERTYPE_SELLER.equals(cto.getCustomerType())) {
                inviteCustomerId = cto.getId().intValue();
            }
            if (SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR.equals(cto.getCustomerType())) {
                recommendCustomerId = cto.getId();
                Integer recommendStoreId = recommendCustomerStoreService
                        .loadStoreIdByRecommendCustomerId(recommendCustomerId);
                if (null != recommendStoreId) {
                    inviteCustomerId = recommendStoreId.intValue();
                }
            }
        }
        String passwordEncrypt = EncryptUtils.md5Crypt(registParam.getPassword()).toLowerCase();
        Integer defaultCreateUserId = getRegistDefaultCreateUserId();
        CustomerDto customerDto = new CustomerDto();
        customerDto.setCustomerName(mobile);
        customerDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
        customerDto.setPayPassword(passwordEncrypt);
        customerDto.setTelPhone(mobile);
        customerDto.setCreateUserId(defaultCreateUserId);
        customerDto.setInviteCustomerId(inviteCustomerId);
        customerDto.setRecommendCustomerId(recommendCustomerId);

        UserDto userDto = new UserDto();
        userDto.setUserName(mobile);
        userDto.setPhone(mobile);
        userDto.setPassword(passwordEncrypt);
        userDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
        userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
        userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
        userDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
        String registerPlatform = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
        userDto.setRegisterPlatform(registerPlatform);
        userDto.setCreateUserId(defaultCreateUserId);

        UserProfileDto userProfile = new UserProfileDto();
        userDto.setUserProfileDto(userProfile);
        customerDto.setUserDto(userDto);
        customerDto.setMasterUserDto(userDto);
        customerService.saveCustomer(customerDto);
        // TODO 记录注册日志
        //发送用户注册奖励
        accountService.sendUserRegistAwardMessage(userDto.getId(), new Date());
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "注册成功");
    }

    private Integer getSystemConfigCaptchaTimeout() {
        String systemConfigCaptchaTimeoutStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.SMS_CAPTCHA_TIME_OUT);
        systemConfigCaptchaTimeoutStr = StringUtils.isEmpty(systemConfigCaptchaTimeoutStr) ? SMS_CAPTCHA_TIME_OUT_DEFAULT
                : systemConfigCaptchaTimeoutStr;
        Integer systemConfigCaptchaTimeout = Integer.parseInt(systemConfigCaptchaTimeoutStr);
        return systemConfigCaptchaTimeout;
    }
}
