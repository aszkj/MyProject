package com.yilidi.o2o.controller.mobile.buyer.user;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.UserClientTokenParam;
import com.yilidi.o2o.appparam.buyer.user.BindQQParam;
import com.yilidi.o2o.appparam.buyer.user.BindWXParam;
import com.yilidi.o2o.appparam.buyer.user.ModifyUserInfoParam;
import com.yilidi.o2o.appparam.buyer.user.ResetPasswordParam;
import com.yilidi.o2o.appparam.buyer.user.UpdateAvatarParam;
import com.yilidi.o2o.appparam.buyer.user.UpdatePasswordParam;
import com.yilidi.o2o.appvo.buyer.user.BindQQInfoVO;
import com.yilidi.o2o.appvo.buyer.user.BindWXInfoVO;
import com.yilidi.o2o.appvo.buyer.user.ModifyUserInfoVO;
import com.yilidi.o2o.appvo.buyer.user.UserInfoVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IConnectUserService;
import com.yilidi.o2o.user.service.IUserClientTokenService;
import com.yilidi.o2o.user.service.IUserProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;
import com.yilidi.o2o.user.service.dto.UserClientTokenDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

/**
 * 用户信息
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerUserController")
@RequestMapping(value = "/interfaces/buyer")
public class UserController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String USER_PIC_RELATIVE_PATH_DEFAULT = "/pic/user";

    @Autowired
    private IUserService userService;
    @Autowired
    private IUserProfileService userProfileService;
    @Autowired
    private IConnectUserService connectUserService;
    @Autowired
    private IUserClientTokenService userClientTokenService;

    /**
     * 重置密码
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/resetpassword")
    @ResponseBody
    public ResultParamModel resetPassword(HttpServletRequest req, HttpServletResponse resp) {
        ResetPasswordParam resetPasswordParam = super.getEntityParam(req, ResetPasswordParam.class);
        // 新密码
        String password = resetPasswordParam.getPassword();
        String mobile = SessionUtils.getBuyerCaptchaCheckSession(WebConstants.BUYER_CAPTCHA_TYPE_FORGET_PASSWORD);
        if (StringUtils.isEmpty(mobile)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证码校验超时,请重新验证");
        }
        UserDto userDto = userService.loadUserByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
        if (userDto == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "帐户不存在");
        }
        userDto.setPassword(EncryptUtils.md5Crypt(password).toLowerCase());
        userService.updateUserForPassword(userDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "重置密码成功");
    }

    /**
     * 修改密码
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/updatepassword")
    @ResponseBody
    public ResultParamModel updatePassword(HttpServletRequest req, HttpServletResponse resp) {
        UpdatePasswordParam updatePasswordParam = super.getEntityParam(req, UpdatePasswordParam.class);
        String oldPassword = updatePasswordParam.getOldPassword(); // 旧密码
        String password = updatePasswordParam.getPassword(); // 新密码
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        if (oldPassword.equals(password)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "新密码与旧密码不能相同");
        }
        UserDto userDto = userService.loadUserByNameAndType(userSession.getUserName(),
                SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
        if (userDto == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "帐户不存在");
        }
        if (!EncryptUtils.md5Crypt(oldPassword).toLowerCase().equals(userDto.getPassword())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "密码不正确");
        }

        userDto.setPassword(EncryptUtils.md5Crypt(password).toLowerCase());
        userService.updateUserForPassword(userDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "修改密码成功");
    }

    /**
     * 查询当前用户信息
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/userinfo")
    @ResponseBody
    public ResultParamModel getUserInfo(HttpServletRequest req, HttpServletResponse resp) {
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        UserDto userDto = userService.loadUserById(userSession.getUserId());
        if (userDto == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "帐户不存在");
        }
        UserInfoVO userInfoVo = new UserInfoVO();
        userInfoVo.setMemberType(ConverterUtils.toClienMemberType(userDto.getBuyerLevelCode()));
        userInfoVo.setUserId(userDto.getId());
        userInfoVo.setUserName(userDto.getUserName());
        String vipExpireDate = null;
        if (!ObjectUtils.isNullOrEmpty(userDto.getVipExpireDate())) {
            vipExpireDate = DateUtils.formatDate(userDto.getVipExpireDate(), CommonConstants.DATE_FORMAT_DAY);
        }
        userInfoVo.setVipExpireDate(vipExpireDate);
        UserProfileDto userProfileDto = userDto.getUserProfileDto();
        if (!ObjectUtils.isNullOrEmpty(userProfileDto)) {
            userInfoVo.setNickName(userProfileDto.getNickName());
            userInfoVo.setUserImageUrl(StringUtils.toFullImageUrl(userProfileDto.getUserImageUrl()));
            userInfoVo.setBirthday(userProfileDto.getBirthday());
            userInfoVo.setUserSex(ConverterUtils.toClientGender(userProfileDto.getGender()));
        }
        ConnectUserDto qqConnectUserDto = connectUserService.loadByUserIdAndConnectType(userInfoVo.getUserId(),
                SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
        BindQQInfoVO bindQQInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(qqConnectUserDto)) {
            bindQQInfoVO = new BindQQInfoVO(qqConnectUserDto.getNickName());
        }
        List<String> connectTypes = new ArrayList<String>(2);
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
        connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
        List<ConnectUserDto> wxConnectUserDtos = connectUserService.listByUserIdAndConnectTypes(userInfoVo.getUserId(),
                connectTypes);
        BindWXInfoVO bindWXInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(wxConnectUserDtos)) {
            for (ConnectUserDto connectUserDto : wxConnectUserDtos) {
                bindWXInfoVO = new BindWXInfoVO(connectUserDto.getNickName());
                break;
            }
        }
        userInfoVo.setBindQQInfo(bindQQInfoVO);
        userInfoVo.setBindWXInfo(bindWXInfoVO);
        return super.encapsulateParam(userInfoVo, AppMsgBean.MsgCode.SUCCESS, "获取用户信息成功");
    }

    /**
     * 上传用户头像
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/updateavatar")
    @ResponseBody
    public ResultParamModel uploadAvatar(HttpServletRequest req, HttpServletResponse resp) {
        UpdateAvatarParam uploadAvatarParam = super.getEntityParam(req, UpdateAvatarParam.class);
        String userImgUrl = uploadAvatarParam.getUserImageUrl();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        userService.updateUserImgUrl(userSession.getUserId(), userImgUrl);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "修改头像成功");
    }

    /**
     * 修改用户信息
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/modifyuserinfo")
    @ResponseBody
    public ResultParamModel updateNickname(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        ModifyUserInfoParam modifyUserInfoParam = super.getEntityParam(req, ModifyUserInfoParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        UserProfileDto userProfileDto = new UserProfileDto();
        userProfileDto.setUserId(userSession.getUserId());
        ModifyUserInfoVO modifyUserInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(modifyUserInfoParam.getNickName())) {
            userProfileDto.setNickName(modifyUserInfoParam.getNickName());
        }
        if (!ObjectUtils.isNullOrEmpty(modifyUserInfoParam.getUserImageUrl())) {
            String userImgUrl = StringUtils.getUrlPathName(modifyUserInfoParam.getUserImageUrl());
            userProfileDto.setUserImageUrl(userImgUrl);
            modifyUserInfoVO = new ModifyUserInfoVO();
            modifyUserInfoVO.setUserImageUrl(StringUtils.toFullImageUrl(userImgUrl));
        }
        if (!ObjectUtils.isNullOrEmpty(modifyUserInfoParam.getUserSex())) {
            userProfileDto.setGender(ConverterUtils.toServerGender(modifyUserInfoParam.getUserSex()));
        }
        if (!ObjectUtils.isNullOrEmpty(modifyUserInfoParam.getBirthday())) {
            userProfileDto
                    .setBirthday(DateUtils.parseDate(modifyUserInfoParam.getBirthday(), CommonConstants.DATE_FORMAT_DAY));
        }
        userProfileService.updateByUserIdSelective(userProfileDto);
        return super.encapsulateParam(modifyUserInfoVO, AppMsgBean.MsgCode.SUCCESS, "修改用户昵称成功");
    }

    /**
     * 3.86 用户绑定微信接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/bind/bindwx")
    @ResponseBody
    public ResultParamModel bindWX(HttpServletRequest req, HttpServletResponse resp) {
        BindWXParam bindWXParam = super.getEntityParam(req, BindWXParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        connectUserService.updateBindWX(bindWXParam.getCode(), bindWXParam.getTradeType(), userSession.getUserId());
        String connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP;
        if (WechatConfig.JS_TRADE_TYPE.equals(bindWXParam.getTradeType())) {
            connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5;
        }
        BindWXInfoVO bindWXInfoVO = null;
        ConnectUserDto connectUserDto = connectUserService.loadByUserIdAndConnectType(userSession.getUserId(), connectType);
        if (!ObjectUtils.isNullOrEmpty(connectUserDto)) {
            bindWXInfoVO = new BindWXInfoVO();
            bindWXInfoVO.setNickName(connectUserDto.getNickName());
        }
        return super.encapsulateParam(bindWXInfoVO, AppMsgBean.MsgCode.SUCCESS, "绑定微信成功");
    }

    /**
     * 3.87 取消用户绑定微信接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/bind/unbindwx")
    @ResponseBody
    public ResultParamModel unBindWX(HttpServletRequest req, HttpServletResponse resp) {
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        connectUserService.updateUnBindWX(userSession.getUserId());
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "取消微信绑定成功");
    }

    /**
     * 3.88 用户绑定QQ接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/bind/bindqq")
    @ResponseBody
    public ResultParamModel bindQQ(HttpServletRequest req, HttpServletResponse resp) {
        BindQQParam bindQQParam = super.getEntityParam(req, BindQQParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        String channel = super.getIntfCallChannel(req);
        connectUserService.updateBindQQ(bindQQParam.getAccessToken(), bindQQParam.getOpenId(), userSession.getUserId(),
                channel);
        BindQQInfoVO bindQQInfoVO = null;
        ConnectUserDto connectUserDto = connectUserService.loadByUserIdAndConnectType(userSession.getUserId(),
                SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
        if (!ObjectUtils.isNullOrEmpty(connectUserDto)) {
            bindQQInfoVO = new BindQQInfoVO();
            bindQQInfoVO.setNickName(connectUserDto.getNickName());
        }
        return super.encapsulateParam(bindQQInfoVO, AppMsgBean.MsgCode.SUCCESS, "绑定QQ成功");
    }

    /**
     * 3.89 取消用户绑定QQ接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/bind/unbindqq")
    @ResponseBody
    public ResultParamModel unBindQQ(HttpServletRequest req, HttpServletResponse resp) {
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        connectUserService.updateUnBindQQ(userSession.getUserId());
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "取消QQ绑定成功");
    }

    /**
     * 3.90用户更改绑定手机接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/bind/changemobilewithbinding")
    @ResponseBody
    public ResultParamModel modifyBindMobile(HttpServletRequest req, HttpServletResponse resp) {
        // UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        // connectUserService.updateUnBindQQ(userSession.getUserId());
        return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "不支持的接口");
    }
    
    /**
     * 同步当前手机推送标识符到服务器
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/user/saveclientid")
    @ResponseBody
    public ResultParamModel saveClientId(HttpServletRequest req, HttpServletResponse resp) {
    	UserSessionModel userSession = SessionUtils.getBuyerUserSession();
    	if(ObjectUtils.isNullOrEmpty(userSession)){
    		return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "无效的用户");
    	}
    	Integer userId = userSession.getUserId();
        UserClientTokenParam userClientTokenParam = super.getEntityParam(req, UserClientTokenParam.class);
        String clientId = userClientTokenParam.getClientId();
        String deviceToken = userClientTokenParam.getDeviceToken();
        String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
        if (StringUtils.isEmpty(channelType)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "未获取到APP客户端所属平台");
        }
        UserClientTokenDto clientTokenDto = userClientTokenService.loadByClientToken(clientId);
        if (null != clientTokenDto) {
        	userClientTokenService.delete(clientTokenDto.getId());
        }
        UserClientTokenDto deviceTokenDto = userClientTokenService.loadByDeviceToken(deviceToken);
        if (null != deviceTokenDto) {
        	userClientTokenService.delete(deviceTokenDto.getId());
        }
        UserClientTokenDto userClientTokenDto = userClientTokenService.loadByUserId(userId);
        if (null == userClientTokenDto) {
            UserClientTokenDto uctDto = new UserClientTokenDto();
            UserDto userDto = userService.loadBuyerUserById(userId);
            if (null != userDto) {
                uctDto.setUserId(userDto.getId());
                uctDto.setClientToken(clientId);
                uctDto.setDeviceToken(deviceToken);
                uctDto.setPlatform(channelType);
                userClientTokenService.save(uctDto);
            }
        } else {
            userClientTokenService.update(userClientTokenDto.getId(), clientId, deviceToken, channelType);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "同步当前手机推送标识符到服务器成功");
    }
}
