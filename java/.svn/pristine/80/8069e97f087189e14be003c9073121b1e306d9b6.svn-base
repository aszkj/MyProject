package com.yilidi.o2o.controller.mobile.buyer.system;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.system.CheckCaptchaParam;
import com.yilidi.o2o.appparam.buyer.system.SendCaptchaParam;
import com.yilidi.o2o.appvo.buyer.user.CaptchaVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.BuyerCaptchaSessionModel;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

import redis.clients.jedis.Jedis;

/**
 * 验证码
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerCaptchaController")
@RequestMapping(value = "/interfaces/buyer")
public class CaptchaController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String DAILY_SEND_SMS_COUNT_DEFAULT = "6";

    private static final String SEND_SMS_CAPTCHA_TIME_OUT_DEFAULT = "120";

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";

    private static final String IP_OR_DEVICE_DAILY_SEND_SMS_COUNT_DEFAULT = "20";

    private static final String DEVICEID_SEND_SMS_KEY = "DEVICEID_SEND_SMS_KEY";

    private static final String IP_SEND_SMS_KEY = "IP_SEND_SMS_KEY";

    private static final String LOGIN_CAPTCHA_VALID_TIME_DEFAULT = "5";

    private static final String REGISTER_CAPTCHA_VALID_TIME_DEFAULT = "5";

    @Autowired
    private IMessageService messageService;

    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;

    @Autowired
    private IUserService userService;

    /**
     * 
     * 获取手机验证码
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/system/sendcaptcha")
    @ResponseBody
    public ResultParamModel getMobileCaptcha(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        SendCaptchaParam sendCaptchaParam = super.getEntityParam(req, SendCaptchaParam.class);
        // 验证每日每个IP或设备发送短信（请求进入接口）的次数是否达到上限
        validateDailyDeviceOrIpSendSmsCount(req);
        BuyerCaptchaSessionModel captchaSessionModel = SessionUtils.getBuyerCaptchaSession(sendCaptchaParam.getMobile(),
                String.valueOf(sendCaptchaParam.getType()));
        if (ObjectUtils.isNullOrEmpty(captchaSessionModel)) {
            // 处理发送验证码过程
            return handleSendCaptcha(req, sendCaptchaParam);
        } else {
            long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
            if (getSystemConfigSendCaptchaTimeout().intValue() - lapseSeconds < 0) {
                // 移除过期的验证码Session
                SessionUtils.removeBuyerCaptchaSession(sendCaptchaParam.getMobile(),
                        String.valueOf(sendCaptchaParam.getType()));
                // 处理发送验证码过程
                return handleSendCaptcha(req, sendCaptchaParam);
            } else {
                // 返回剩余倒数计时秒数
                return super.encapsulateParam(
                        new CaptchaVO(new Long(getSystemConfigSendCaptchaTimeout() - lapseSeconds).intValue()),
                        AppMsgBean.MsgCode.SUCCESS, "发送验证码短信未超时，直接返回剩余倒数计时秒数");
            }
        }
    }

    /**
     * 校验手机验证码
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     *             转换异常
     */
    @RequestMapping(value = "/system/checkcaptcha")
    @ResponseBody
    public ResultParamModel checkMobileCaptcha(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        CheckCaptchaParam checkCaptchaParam = super.getEntityParam(req, CheckCaptchaParam.class);
        BuyerCaptchaSessionModel captchaSession = SessionUtils.getBuyerCaptchaSession(checkCaptchaParam.getMobile(),
                checkCaptchaParam.getType().toString());
        if (null == captchaSession) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
        }
        if (!checkCaptchaParam.getCode().equals(captchaSession.getCaptcha())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码输入错误，请重新输入");
        }
        long lapseSeconds = DateUtils.secondsBetween(captchaSession.getSendTime(), DateUtils.getCurrentDateTime());
        if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
            SessionUtils.removeBuyerCaptchaSession(checkCaptchaParam.getMobile(),
                    String.valueOf(checkCaptchaParam.getType()));
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
        }
        if (WebConstants.BUYER_CAPTCHA_TYPE_FORGET_PASSWORD.equals(checkCaptchaParam.getType().toString())) {
            UserDto userDto = userService.loadUserByNameAndType(checkCaptchaParam.getMobile(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            if (null == userDto) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该手机号还不是一里递社区会员");
            }
            SessionUtils.setBuyerCaptchaCheckSession(checkCaptchaParam.getMobile(),
                    String.valueOf(checkCaptchaParam.getType()));
        }
        SessionUtils.removeBuyerCaptchaSession(checkCaptchaParam.getMobile(), String.valueOf(checkCaptchaParam.getType()));
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "验证码校验成功");
    }

    private void validateDailyUserSendSmsCount(SendCaptchaParam sendCaptchaParam) {
        Integer sendSmsCount = 0;
        try {
            sendSmsCount = smsNotifyMessageService.dailySendSmsCountWithOneUser(sendCaptchaParam.getMobile(),
                    DateUtils.getTodayStartDate(), DateUtils.getTodayEndDate());
        } catch (Exception e) {
            String errorMsg = null == e.getMessage() ? "系统出现异常" : e.getMessage();
            logger.error(errorMsg, e);
            throw new IllegalStateException(errorMsg);
        }
        String systemConfigSendSmsCountStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.S_DAILY_SEND_SMS_COUNT);
        systemConfigSendSmsCountStr = StringUtils.isEmpty(systemConfigSendSmsCountStr) ? DAILY_SEND_SMS_COUNT_DEFAULT
                : systemConfigSendSmsCountStr;
        Integer systemConfigSendSmsCount = Integer.parseInt(systemConfigSendSmsCountStr);
        if (sendSmsCount.intValue() >= systemConfigSendSmsCount.intValue()) {
            String errorMsg = "您发送短信次数已达当日上限";
            throw new IllegalStateException(errorMsg);
        }
    }

    private ResultParamModel handleSendCaptcha(HttpServletRequest req, SendCaptchaParam sendCaptchaParam) {
        // 验证每日每个用户发送短信(非失败)的次数是否达到上限
        validateDailyUserSendSmsCount(sendCaptchaParam);
        // 发送验证码短信
        String captcha = sendSms(req, sendCaptchaParam);
        // 设置验证码Session
        setCaptchaSession(sendCaptchaParam, captcha, DateUtils.getCurrentDateTime());
        // 返回剩余倒数计时秒数
        return super.encapsulateParam(new CaptchaVO(getSystemConfigSendCaptchaTimeout()), AppMsgBean.MsgCode.SUCCESS,
                "发送验证码成功");
    }

    private void setCaptchaSession(SendCaptchaParam sendCaptchaParam, String captcha, Date SendTime) {
        BuyerCaptchaSessionModel model = new BuyerCaptchaSessionModel();
        model.setCaptcha(captcha);
        model.setSendTime(SendTime);
        SessionUtils.setBuyerCaptchaSession(sendCaptchaParam.getMobile(), sendCaptchaParam.getType().toString(), model);
    }

    private String sendSms(HttpServletRequest req, SendCaptchaParam sendCaptchaParam) {
        String captcha = StringUtils.generateArabicNumerals(6);
        SmsTypeModelClassMapping smsTypeModel = null;
        if (WebConstants.BUYER_CAPTCHA_TYPE_LOGIN.equals(String.valueOf(sendCaptchaParam.getType()))) {
            smsTypeModel = SmsTypeModelClassMapping.LOGIN;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha, Integer.toString(getSystemConfigLoginValidTime()));
        }
        if (WebConstants.BUYER_CAPTCHA_TYPE_FORGET_PASSWORD.equals(String.valueOf(sendCaptchaParam.getType()))) {
            smsTypeModel = SmsTypeModelClassMapping.RESETPWD;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha);
        }
        if (WebConstants.BUYER_CAPTCHA_TYPE_MODIFY_PASSWORD.equals(String.valueOf(sendCaptchaParam.getType()))) {
            smsTypeModel = SmsTypeModelClassMapping.UPDATEPWD;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha);
        }
        if (WebConstants.BUYER_CAPTCHA_TYPE_REGISTER.equals(String.valueOf(sendCaptchaParam.getType()))) {
            smsTypeModel = SmsTypeModelClassMapping.REGISTER;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha, Integer.toString(getSystemConfigRegisterValidTime()));
        }
        if (WebConstants.BUYER_CAPTCHA_TYPE_USERBINDING.equals(String.valueOf(sendCaptchaParam.getType()))) {
            smsTypeModel = SmsTypeModelClassMapping.USERBINDING;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha, Integer.toString(getSystemConfigRegisterValidTime()));
        }
        if (null == smsTypeModel) {
            throw new SystemServiceException("不合法的验证码类型");
        }
        return captcha;
    }

    private void validateDailyDeviceOrIpSendSmsCount(HttpServletRequest req) {
        Jedis jedis = null;
        try {
            String ip = super.getRealIP(req);
            String deviceId = super.getDeviceId(req);
            jedis = JedisUtils.getJedis();
            if (!StringUtils.isEmpty(deviceId)) {
                String key = EncryptUtils.base64Encode(DEVICEID_SEND_SMS_KEY + deviceId);
                if (!jedis.exists(key)) {
                    jedis.setex(key,
                            (int) DateUtils.secondsBetween(DateUtils.getCurrentDateTime(), DateUtils.getTodayEndDate()),
                            String.valueOf(0));
                }
                if (jedis.incr(key).longValue() > getSystemConfigIpOrDeviceSendCount().intValue()) {
                    throw new IllegalStateException("同一台设备每日发送短信数已达上限");
                }
            } else {
                if (!StringUtils.isEmpty(ip)) {
                    String key = EncryptUtils.base64Encode(IP_SEND_SMS_KEY + ip);
                    if (!jedis.exists(key)) {
                        jedis.setex(key,
                                (int) DateUtils.secondsBetween(DateUtils.getCurrentDateTime(), DateUtils.getTodayEndDate()),
                                String.valueOf(0));
                    }
                    if (jedis.incr(key).longValue() > getSystemConfigIpOrDeviceSendCount().intValue()) {
                        throw new IllegalStateException("同一个IP每日发送短信数已达上限");
                    }
                }
            }
        } catch (Exception e) {
            String errorMsg = null == e.getMessage() ? "系统出现异常" : e.getMessage();
            logger.error(errorMsg, e);
            throw new IllegalStateException(errorMsg);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    private Integer getSystemConfigIpOrDeviceSendCount() {
        String systemConfigIpOrDeviceSendCountStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.IP_OR_DEVICE_DAILY_SEND_SMS_COUNT);
        systemConfigIpOrDeviceSendCountStr = StringUtils.isEmpty(systemConfigIpOrDeviceSendCountStr)
                ? IP_OR_DEVICE_DAILY_SEND_SMS_COUNT_DEFAULT : systemConfigIpOrDeviceSendCountStr;
        Integer systemConfigIpOrDeviceSendCount = Integer.parseInt(systemConfigIpOrDeviceSendCountStr);
        return systemConfigIpOrDeviceSendCount;
    }

    private Integer getSystemConfigSendCaptchaTimeout() {
        String systemConfigSendCaptchaTimeoutStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.SEND_SMS_CAPTCHA_TIME_OUT);
        systemConfigSendCaptchaTimeoutStr = StringUtils.isEmpty(systemConfigSendCaptchaTimeoutStr)
                ? SEND_SMS_CAPTCHA_TIME_OUT_DEFAULT : systemConfigSendCaptchaTimeoutStr;
        Integer systemConfigSendCaptchaTimeout = Integer.parseInt(systemConfigSendCaptchaTimeoutStr);
        return systemConfigSendCaptchaTimeout;
    }

    private Integer getSystemConfigCaptchaTimeout() {
        String systemConfigCaptchaTimeoutStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.SMS_CAPTCHA_TIME_OUT);
        systemConfigCaptchaTimeoutStr = StringUtils.isEmpty(systemConfigCaptchaTimeoutStr) ? SMS_CAPTCHA_TIME_OUT_DEFAULT
                : systemConfigCaptchaTimeoutStr;
        Integer systemConfigCaptchaTimeout = Integer.parseInt(systemConfigCaptchaTimeoutStr);
        return systemConfigCaptchaTimeout;
    }

    private Integer getSystemConfigLoginValidTime() {
        String systemConfigLoginValidTimeStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.LOGIN_CAPTCHA_VALID_TIME);
        systemConfigLoginValidTimeStr = StringUtils.isEmpty(systemConfigLoginValidTimeStr) ? LOGIN_CAPTCHA_VALID_TIME_DEFAULT
                : systemConfigLoginValidTimeStr;
        Integer systemConfigLoginValidTime = Integer.parseInt(systemConfigLoginValidTimeStr);
        return systemConfigLoginValidTime;
    }

    private Integer getSystemConfigRegisterValidTime() {
        String systemConfigRegisterValidTimeStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.REGISTER_CAPTCHA_VALID_TIME);
        systemConfigRegisterValidTimeStr = StringUtils.isEmpty(systemConfigRegisterValidTimeStr)
                ? REGISTER_CAPTCHA_VALID_TIME_DEFAULT : systemConfigRegisterValidTimeStr;
        Integer systemConfigRegisterValidTime = Integer.parseInt(systemConfigRegisterValidTimeStr);
        return systemConfigRegisterValidTime;
    }

}
