package com.yilidi.o2o.controller.mobile.seller.system;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.appparam.buyer.system.SendCaptchaParam;
import com.yilidi.o2o.appparam.seller.system.CheckCaptchaParam;
import com.yilidi.o2o.appvo.seller.system.CaptchaSessionModel;
import com.yilidi.o2o.appvo.seller.system.CaptchaVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * @Description: TODO(验证码Controller)
 * @author: chenlian
 * @date: 2016年5月31日 下午6:15:28
 */
@Controller("sellerCaptchaController")
@RequestMapping(value = "/interfaces/seller")
public class CaptchaController extends SellerBaseController {

    private static final String DAILY_SEND_SMS_COUNT_DEFAULT = "6";

    private static final String SEND_SMS_CAPTCHA_TIME_OUT_DEFAULT = "120";

    private static final String SMS_CAPTCHA_TIME_OUT_DEFAULT = "300";

    private static final String IP_OR_DEVICE_DAILY_SEND_SMS_COUNT_DEFAULT = "20";

    private static final String IP_SEND_SMS_KEY = "IP_SEND_SMS_KEY";

    private static final String DEVICEID_SEND_SMS_KEY = "DEVICEID_SEND_SMS_KEY";

    private static final String LOGIN_CAPTCHA_VALID_TIME_DEFAULT = "5";

    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;

    @Autowired
    private IMessageService messageService;

    @Autowired
    private IUserService userService;

    /**
     * 
     * 发送验证码
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     */
    @RequestMapping(value = "/system/sendcaptcha")
    @ResponseBody
    public ResultParamModel sendCaptcha(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        // 验证每日每个IP或设备发送短信（请求进入接口）的次数是否达到上限
        validateDailyDeviceOrIpSendSmsCount(req);
        SendCaptchaParam sendCaptchaParam = super.getEntityParam(req, SendCaptchaParam.class);
        CaptchaSessionModel captchaSessionModel = SessionUtils.getSellerCaptchaSession(sendCaptchaParam.getMobile(),
                sendCaptchaParam.getType().toString());
        if (ObjectUtils.isNullOrEmpty(captchaSessionModel)) {
            // 处理发送验证码过程
            return handleSendCaptcha(req, sendCaptchaParam);
        } else {
            long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
            if (getSystemConfigSendCaptchaTimeout().intValue() - lapseSeconds < 0) {
                // 移除过期的验证码Session
                removeCaptchaSession(sendCaptchaParam);
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

    private Integer getSystemConfigIpOrDeviceSendCount() {
        String systemConfigIpOrDeviceSendCountStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.IP_OR_DEVICE_DAILY_SEND_SMS_COUNT);
        systemConfigIpOrDeviceSendCountStr = StringUtils.isEmpty(systemConfigIpOrDeviceSendCountStr) ? IP_OR_DEVICE_DAILY_SEND_SMS_COUNT_DEFAULT
                : systemConfigIpOrDeviceSendCountStr;
        Integer systemConfigIpOrDeviceSendCount = Integer.parseInt(systemConfigIpOrDeviceSendCountStr);
        return systemConfigIpOrDeviceSendCount;
    }

    private Integer getSystemConfigSendCaptchaTimeout() {
        String systemConfigSendCaptchaTimeoutStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.SEND_SMS_CAPTCHA_TIME_OUT);
        systemConfigSendCaptchaTimeoutStr = StringUtils.isEmpty(systemConfigSendCaptchaTimeoutStr) ? SEND_SMS_CAPTCHA_TIME_OUT_DEFAULT
                : systemConfigSendCaptchaTimeoutStr;
        Integer systemConfigSendCaptchaTimeout = Integer.parseInt(systemConfigSendCaptchaTimeoutStr);
        return systemConfigSendCaptchaTimeout;
    }

    private void removeCaptchaSession(SendCaptchaParam sendCaptchaParam) {
        SessionUtils.removeSellerCaptchaSession(sendCaptchaParam.getMobile(), sendCaptchaParam.getType().toString());
    }

    private void setCaptchaSession(SendCaptchaParam sendCaptchaParam, String captcha, Date SendTime) {
        CaptchaSessionModel model = new CaptchaSessionModel();
        model.setCaptcha(captcha);
        model.setSendTime(SendTime);
        SessionUtils.setSellerCaptchaSession(sendCaptchaParam.getMobile(), sendCaptchaParam.getType().toString(), model);
    }

    private String sendSms(HttpServletRequest req, SendCaptchaParam sendCaptchaParam) {
        String captcha = StringUtils.generateArabicNumerals(6);
        SmsTypeModelClassMapping smsTypeModel = null;
        if (WebConstants.SELLER_CAPTCHA_TYPE_LOGIN == sendCaptchaParam.getType().intValue()) {
            smsTypeModel = SmsTypeModelClassMapping.LOGIN;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha, Integer.toString(getSystemConfigLoginValidTime()));
        }
        if (WebConstants.SELLER_CAPTCHA_TYPE_FORGET_PASSWORD == sendCaptchaParam.getType().intValue()) {
            smsTypeModel = SmsTypeModelClassMapping.RESETPWD;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha);
        }
        if (WebConstants.SELLER_CAPTCHA_TYPE_MODIFY_PASSWORD == sendCaptchaParam.getType().intValue()) {
            smsTypeModel = SmsTypeModelClassMapping.UPDATEPWD;
            messageService.userSendSms(smsTypeModel, super.getRealIP(req), Arrays.asList(sendCaptchaParam.getMobile()),
                    captcha);
        }
        if (null == smsTypeModel) {
            throw new SystemServiceException("不合法的验证码类型");
        }
        return captcha;
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

    /**
     * 
     * 手机验证码验证
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     */
    @RequestMapping(value = "/system/checkcode")
    @ResponseBody
    public ResultParamModel checkCode(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        CheckCaptchaParam checkCaptchaParam = super.getEntityParam(req, CheckCaptchaParam.class);
        CaptchaSessionModel captchaSessionModel = SessionUtils.getSellerCaptchaSession(checkCaptchaParam.getMobile(),
                String.valueOf(checkCaptchaParam.getType()));
        if (null == captchaSessionModel) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "手机号码输入错误或验证码已超时，请重新输入");
        }
        if (!checkCaptchaParam.getCode().equals(captchaSessionModel.getCaptcha())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码输入错误，请重新输入");
        }
        long lapseSeconds = DateUtils.secondsBetween(captchaSessionModel.getSendTime(), DateUtils.getCurrentDateTime());
        if (getSystemConfigCaptchaTimeout().intValue() - lapseSeconds < 0) {
            SessionUtils.removeSellerCaptchaSession(checkCaptchaParam.getMobile(),
                    String.valueOf(checkCaptchaParam.getType()));
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码已超时，请重新获取验证码");
        }
        if (WebConstants.SELLER_CAPTCHA_TYPE_FORGET_PASSWORD == checkCaptchaParam.getType().intValue()) {
            UserDto userDto = userService.loadUserByNameAndType(checkCaptchaParam.getMobile(),
                    SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            if (null == userDto) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该手机号还不是一里递社区会员");
            }
            SessionUtils.setSellerCaptchaCheckSession(checkCaptchaParam.getMobile(),
                    String.valueOf(checkCaptchaParam.getType()));
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "验证码校验成功");
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

}
